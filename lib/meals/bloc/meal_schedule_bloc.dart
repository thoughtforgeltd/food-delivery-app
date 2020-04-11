import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/authentication/repository/user_repository.dart';
import 'package:fooddeliveryapp/meals/bloc/meal_schedule_event.dart';
import 'package:fooddeliveryapp/meals/bloc/meal_schedule_state.dart';
import 'package:fooddeliveryapp/repositories/meal_schedule_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class MealScheduleBloc extends Bloc<MealScheduleEvent, MealScheduleState> {
  final MealScheduleRepository _mealSchedulesRepository;
  final UserRepository _userRepository;

  MealScheduleBloc({@required MealScheduleRepository userDetailsRepository,
    @required UserRepository userRepository})
      : assert(userDetailsRepository != null &&  userRepository != null),
        _mealSchedulesRepository = userDetailsRepository,
        _userRepository = userRepository;

  @override
  MealScheduleState get initialState => MealScheduleState.empty();

  @override
  Stream<Transition<MealScheduleEvent, MealScheduleState>> transformEvents(
      Stream<MealScheduleEvent> events,
      TransitionFunction<MealScheduleEvent, MealScheduleState> transitionFn,
      ) {
    final nonDebounceStream = events.where((event) {
      return (event is! DateChanged &&
          event is! MealSelectionChanged);
    });
    final debounceStream = events.where((event) {
      return (event is DateChanged ||
          event is MealSelectionChanged);
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
    if (event is DateChanged) {
      yield* _mapDateChangedToState(event.selectedDate);
    } else if (event is MealSelectionChanged) {
      yield* _mapMealSelectionChangedToState(event.mealsSelection);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(
          event.selectedDate, event.mealsSelection);
    }
  }

  Stream<MealScheduleState> _mapDateChangedToState(
      DateTime selectedDate) async* {
    yield state.update(
      selectedDate: selectedDate,
    );
  }

  Stream<MealScheduleState> _mapMealSelectionChangedToState(Map<String, bool> mealsSelection) async* {
    yield state.update(
      mealsSelection: mealsSelection,
    );
  }
  
  Stream<MealScheduleState> _mapFormSubmittedToState(
      DateTime selectedDate, Map<String, bool> mealsSelection) async* {
    yield MealScheduleState.loading();
    try {
      final userId = await _userRepository.getUserID();
      await _mealSchedulesRepository.updateMealSchedulesForTheDay(
          userId.uid, selectedDate, mealsSelection);
      yield MealScheduleState.success();
    } catch (_) {
      yield MealScheduleState.failure();
    }
  }
}
