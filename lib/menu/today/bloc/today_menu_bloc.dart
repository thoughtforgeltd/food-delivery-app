import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';
import 'package:fooddeliveryapp/menu/add/add_schedule.dart';
import 'package:fooddeliveryapp/repositories/repositories.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class TodayMenuBloc extends Bloc<TodayMenuEvent, TodayMenuState> {
  final MenuRepository _todayMenuRepository;
  final MealCategoryRepository _categoryRepository;
  final DishRepository _dishRepository;

  TodayMenuBloc(
      {@required MenuRepository todayMenuRepository,
      MealCategoryRepository categoryRepository,
      DishRepository dishRepository})
      : assert(todayMenuRepository != null),
        _todayMenuRepository = todayMenuRepository,
        _categoryRepository = categoryRepository,
        _dishRepository = dishRepository;

  @override
  TodayMenuState get initialState => TodayMenuState.empty();

  @override
  Stream<Transition<TodayMenuEvent, TodayMenuState>> transformEvents(
    Stream<TodayMenuEvent> events,
    TransitionFunction<TodayMenuEvent, TodayMenuState> transitionFn,
  ) {
    final debounceStream = events.where((event) {
      return (event is TodayMenuLoadEvent || event is TodayMenuLoadedEvent);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      debounceStream,
      transitionFn,
    );
  }

  @override
  Stream<TodayMenuState> mapEventToState(TodayMenuEvent event,) async* {
    if (event is TodayMenuLoadEvent) {
      yield* _mapTodayMenuLoadEventToState();
    }
  }

  Stream<TodayMenuState> _mapTodayMenuLoadEventToState() async* {
    yield state.loading();
    try {
      final menus = await _todayMenuRepository.loadTodayMenu(state.date);
      final categories = await _categoryRepository.loadCategories();
      final dishes = await _dishRepository.loadDishes();
      final menuView = menus
          .toMenusView(categories, dishes)
          ?.menus
          ?.firstWhere((element) => true, orElse: () => null);
      yield state.success(menus: menuView);
    } catch (_) {
      yield state.failure();
    }
  }
}
