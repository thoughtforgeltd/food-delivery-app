import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../meal_category.dart';

class MealCategoryIconsBloc
    extends Bloc<MealCategoryIconsEvent, MealCategoryIconsState> {
  final MealCategoryRepository iconsRepository;

  MealCategoryIconsBloc({@required MealCategoryRepository iconsRepository})
      : assert(iconsRepository != null),
        iconsRepository = iconsRepository;

  @override
  MealCategoryIconsState get initialState => MealCategoryIconsState.empty();

  @override
  Stream<Transition<MealCategoryIconsEvent, MealCategoryIconsState>>
      transformEvents(
    Stream<MealCategoryIconsEvent> events,
    TransitionFunction<MealCategoryIconsEvent, MealCategoryIconsState>
        transitionFn,
  ) {
    final debounceStream = events.where((event) {
      return (event is LoadMealCategoryIconsEvent);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      debounceStream,
      transitionFn,
    );
  }

  @override
  Stream<MealCategoryIconsState> mapEventToState(
    MealCategoryIconsEvent event,
  ) async* {
    if (event is LoadMealCategoryIconsEvent) {
      yield* _mapLoadMealCategoryIconsEventToState(event);
    }
  }

  Stream<MealCategoryIconsState> _mapLoadMealCategoryIconsEventToState(
      LoadMealCategoryIconsEvent event) async* {
    yield state.loading();
    try {
      final categories = await iconsRepository.getMealCategoryIcons();
      yield state.success(icons: categories.icons);
    } catch (_) {
      yield state.failure();
    }
  }
}
