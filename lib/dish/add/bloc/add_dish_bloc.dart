import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/common/common.dart';
import 'package:fooddeliveryapp/dish/model/model.dart';
import 'package:fooddeliveryapp/repositories/repositories.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class AddDishBloc extends Bloc<AddDishEvent, AddDishState> {
  final DishRepository dishRepository;

  AddDishBloc({@required DishRepository dishRepository})
      : assert(dishRepository != null),
        dishRepository = dishRepository;

  @override
  AddDishState get initialState => AddDishState.empty();

  @override
  Stream<Transition<AddDishEvent, AddDishState>> transformEvents(
    Stream<AddDishEvent> events,
    TransitionFunction<AddDishEvent, AddDishState> transitionFn,
  ) {
    final debounceStream = events.where((event) {
      return (event is OnAddDishPressedEvent ||
          event is DishTitleChangedEvent ||
          event is DishDescriptionChangedEvent ||
          event is DishAddedEvent ||
          event is DishImageAddedEvent);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      debounceStream,
      transitionFn,
    );
  }

  @override
  Stream<AddDishState> mapEventToState(
    AddDishEvent event,
  ) async* {
    if (event is OnAddDishPressedEvent) {
      yield* _mapDishAddPressedEventToState(event);
    } else if (event is DishTitleChangedEvent) {
      yield* _mapTitleChangedToState(event.title);
    } else if (event is DishDescriptionChangedEvent) {
      yield* _mapDescriptionChangedToState(event.description);
    } else if (event is DishImageAddedEvent) {
      yield* _mapImageAddedToState(event.path);
    }
  }

  Stream<AddDishState> _mapTitleChangedToState(String title) async* {
    yield state.copyWith(
      isTitleValid: Validators.isEmpty(title),
    );
  }

  Stream<AddDishState> _mapDescriptionChangedToState(String description) async* {
    yield state.copyWith(
      isDescriptionValid: Validators.isEmpty(description),
    );
  }

  Stream<AddDishState> _mapImageAddedToState(String path) async* {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    yield state.copyWith(
      imagePath: image.path,
      isImageAdded: image.path != null,
    );
  }

  Stream<AddDishState> _mapDishAddPressedEventToState(OnAddDishPressedEvent event) async* {
    yield state.loading();
    try {
      final url = await dishRepository.uploadImage(event.imagePath);
      await dishRepository.addDish(Dish(
          title: event.title,
          description: event.description,
          note: event.note,
          image: url));
      yield state.success();
    } catch (_) {
      yield state.failure();
    }
  }
}
