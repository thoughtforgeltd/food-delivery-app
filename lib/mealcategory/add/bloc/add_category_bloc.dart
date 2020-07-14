import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/common/common.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../meal_category.dart';
import '../add_category_alias.dart';

class AddCategoryBloc extends Bloc<AddCategoryEvent, AddCategoryState> {
  final MealCategoryRepository categoryRepository;

  AddCategoryBloc({@required MealCategoryRepository categoryRepository})
      : assert(categoryRepository != null),
        categoryRepository = categoryRepository;

  @override
  AddCategoryState get initialState => AddCategoryState.empty();

  @override
  Stream<Transition<AddCategoryEvent, AddCategoryState>> transformEvents(
    Stream<AddCategoryEvent> events,
    TransitionFunction<AddCategoryEvent, AddCategoryState> transitionFn,
  ) {
    final debounceStream = events.where((event) {
      return (event is OnAddCategoryPressedEvent ||
          event is CategoryTitleChangedEvent ||
          event is CategoryDescriptionChangedEvent ||
          event is CategoryAddedEvent ||
          event is CategoryImageAddedEvent);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      debounceStream,
      transitionFn,
    );
  }

  @override
  Stream<AddCategoryState> mapEventToState(
    AddCategoryEvent event,
  ) async* {
    if (event is OnAddCategoryPressedEvent) {
      yield* _mapCategoryAddPressedEventToState(event);
    } else if (event is CategoryTitleChangedEvent) {
      yield* _mapTitleChangedToState(event.title);
    } else if (event is CategoryDescriptionChangedEvent) {
      yield* _mapDescriptionChangedToState(event.description);
    } else if (event is CategoryImageAddedEvent) {
      yield* _mapImageAddedToState(event.path);
    }
  }

  Stream<AddCategoryState> _mapTitleChangedToState(String title) async* {
    yield state.copyWith(
      isTitleValid: Validators.isEmpty(title),
    );
  }

  Stream<AddCategoryState> _mapDescriptionChangedToState(
      String description) async* {
    yield state.copyWith(
      isDescriptionValid: Validators.isEmpty(description),
    );
  }

  Stream<AddCategoryState> _mapImageAddedToState(String path) async* {
    yield state.copyWith(
      imagePath: path,
      isImageAdded: path != null,
    );
  }

  Stream<AddCategoryState> _mapCategoryAddPressedEventToState(
      OnAddCategoryPressedEvent event) async* {
    yield state.loading();
    try {
      await categoryRepository.addCategory(Category(
          title: event.title,
          description: event.description,
          image: event.imagePath));
      yield state.success();
    } catch (_) {
      yield state.failure();
    }
  }
}
