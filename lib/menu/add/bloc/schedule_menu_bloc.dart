import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';
import 'package:fooddeliveryapp/menu/add/add_schedule.dart';
import 'package:fooddeliveryapp/repositories/repositories.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class ScheduleMenuBloc extends Bloc<ScheduleMenuEvent, ScheduleMenuState> {
  final MenuRepository _menuRepository;
  final MealCategoryRepository _categoryRepository;
  final DishRepository _dishRepository;

  ScheduleMenuBloc(
      {@required MenuRepository todayMenuRepository,
      @required MealCategoryRepository categoryRepository,
      @required DishRepository dishRepository})
      : assert(todayMenuRepository != null),
        _menuRepository = todayMenuRepository,
        _categoryRepository = categoryRepository,
        _dishRepository = dishRepository;

  @override
  ScheduleMenuState get initialState => ScheduleMenuState.empty();

  @override
  Stream<Transition<ScheduleMenuEvent, ScheduleMenuState>> transformEvents(
    Stream<ScheduleMenuEvent> events,
    TransitionFunction<ScheduleMenuEvent, ScheduleMenuState> transitionFn,
  ) {
    final debounceStream = events.where((event) {
      return (event is MenuSchedulesLoaded || event is Submitted);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      debounceStream,
      transitionFn,
    );
  }

  @override
  Stream<ScheduleMenuState> mapEventToState(
    ScheduleMenuEvent event,
  ) async* {
    if (event is MenuSchedulesLoaded) {
      yield* _mapMenuSchedulesLoadedEventToState();
    } else if (event is Submitted) {
      yield* _mapMenuSchedulesSubmittedEventToState(event);
    }
  }

  Stream<ScheduleMenuState> _mapMenuSchedulesLoadedEventToState() async* {
    yield state.loading();
    try {
      final menus = await _menuRepository.loadMenus();
      final categories = await _categoryRepository.loadCategories();
      final dishes = await _dishRepository.loadDishes();
      yield state.success(menus: menus.toMenusView(categories, dishes));
    } catch (_) {
      yield state.failure();
    }
  }

  Stream<ScheduleMenuState> _mapMenuSchedulesSubmittedEventToState(
      Submitted event) async* {
    yield state.loading();
    try {
      await _menuRepository.addMenus(event.menus.toMenus());
      yield state.success(menus: event.menus);
    } catch (_) {
      yield state.failure();
    }
  }
}
