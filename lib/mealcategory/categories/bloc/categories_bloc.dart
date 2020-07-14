import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final MealCategoryRepository categoryRepository;

  CategoriesBloc({@required MealCategoryRepository categoryRepository})
      : assert(categoryRepository != null),
        categoryRepository = categoryRepository;

  @override
  CategoriesState get initialState => CategoriesState.empty();

  @override
  Stream<Transition<CategoriesEvent, CategoriesState>> transformEvents(
    Stream<CategoriesEvent> events,
    TransitionFunction<CategoriesEvent, CategoriesState> transitionFn,
  ) {
    final debounceStream = events.where((event) {
      return (event is LoadCategoriesEvent ||
          event is DeleteCategoryEvent ||
          event is EditCategoryEvent);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      debounceStream,
      transitionFn,
    );
  }

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    if (event is LoadCategoriesEvent) {
      yield* _mapLoadCategoriesEventToState(event);
    } else if (event is DeleteCategoryEvent) {
      yield* _mapDeleteCategoryEventToState(event);
    } else if (event is EditCategoryEvent) {
      yield* _mapEditCategoryEventToState(event);
    }
  }

  Stream<CategoriesState> _mapLoadCategoriesEventToState(
      LoadCategoriesEvent event) async* {
    yield state.loading();
    try {
      final categories = await categoryRepository.loadCategories();
      yield state.success(categories: categories);
    } catch (_) {
      yield state.failure();
    }
  }

  Stream<CategoriesState> _mapDeleteCategoryEventToState(
      DeleteCategoryEvent event) async* {
    yield state.loading();
    try {
      await categoryRepository.deleteCategory(event.category);
      final categories = await categoryRepository.loadCategories();
      yield state.success(categories: categories);
    } catch (_) {
      yield state.failure();
    }
  }

  Stream<CategoriesState> _mapEditCategoryEventToState(
      EditCategoryEvent event) async* {}
}
