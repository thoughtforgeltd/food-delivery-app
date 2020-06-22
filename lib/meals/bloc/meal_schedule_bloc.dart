import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/authentication/repository/user_repository.dart';
import 'package:fooddeliveryapp/meals/bloc/meal_schedule_event.dart';
import 'package:fooddeliveryapp/meals/bloc/meal_schedule_state.dart';
import 'package:fooddeliveryapp/meals/model/meal_schedules.dart';
import 'package:fooddeliveryapp/meals/model/meal_selection.dart';
import 'package:fooddeliveryapp/repositories/configuration_repository.dart';
import 'package:fooddeliveryapp/repositories/meal_schedule_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class MealScheduleBloc extends Bloc<MealScheduleEvent, MealScheduleState> {
  final MealScheduleRepository _mealSchedulesRepository;
  final UserRepository _userRepository;
  final ConfigurationsRepository _configurationsRepository;

  MealScheduleBloc(
      {@required MealScheduleRepository mealScheduleRepository,
      @required UserRepository userRepository,
      @required ConfigurationsRepository configurationsRepository})
      : assert(mealScheduleRepository != null &&
            userRepository != null &&
            configurationsRepository != null),
        _mealSchedulesRepository = mealScheduleRepository,
        _userRepository = userRepository,
        _configurationsRepository = configurationsRepository;

  @override
  MealScheduleState get initialState => MealScheduleState.empty();

  @override
  Stream<Transition<MealScheduleEvent, MealScheduleState>> transformEvents(
    Stream<MealScheduleEvent> events,
    TransitionFunction<MealScheduleEvent, MealScheduleState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! DateChanged && event is! MealSelectionChanged);
    });
    final debounceStream = events.where((event) {
      return (event is DateChanged || event is MealSelectionChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<MealScheduleState> mapEventToState(
    MealScheduleEvent event,
  ) async* {
    if (event is MealSchedulesLoaded) {
      yield* _mapMealSchedulesLoadedToState();
    } else if (event is DateChanged) {
      yield* _mapDateChangedToState(event.selectedDate);
    } else if (event is MealSelectionChanged) {
      yield* _mapMealSelectionChangedToState(event.mealsSelection);
    }else if (event is AddMealSchedule) {
      yield* _mapAddMealScheduleToState(event.selection);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.selectedDate, event.mealsSelection);
    }
  }

  Stream<MealScheduleState> _mapMealSchedulesLoadedToState() async* {
    yield state.loading();
    try {
      final userId = await _userRepository.getUserID();
      final configurations = await _configurationsRepository.getMealTypeConfigurations();
      final schedules =
          await _mealSchedulesRepository.getMealSelections(userId.uid);
      yield state.success(mealsSelection: schedules, mealTypes: configurations);
    } catch (_) {
      yield state.failure();
    }
  }

  Stream<MealScheduleState> _mapDateChangedToState(
      Timestamp selectedDate) async* {
    yield state.copyWith(
      selectedDate: selectedDate,
      isSuccess: false,
      isSubmitting: false,
      isFailure: false
    );
  }

  Stream<MealScheduleState> _mapMealSelectionChangedToState(
      MealSchedules mealsSelection) async* {
    yield state.copyWith(
      mealsSelection: mealsSelection,
        isSuccess: false,
        isSubmitting: false,
        isFailure: false
    );
  }

  Stream<MealScheduleState> _mapAddMealScheduleToState(
      MealSelection mealSelection) async* {
    yield state.addSchedule(
        selection: mealSelection
    );
  }

  Stream<MealScheduleState> _mapFormSubmittedToState(DateTime selectedDate,
      MealSchedules mealsSelection) async* {
    yield state.loading();
    try {
      final userId = await _userRepository.getUserID();
      await _mealSchedulesRepository.updateMealSchedulesForTheDay(
          userId.uid, selectedDate, mealsSelection);
      yield state.success();
    } catch (_) {
      yield state.failure();
    }
  }
}
