import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/common/common.dart';
import 'package:fooddeliveryapp/dish/model/model.dart';
import 'package:fooddeliveryapp/repositories/repositories.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class DishBloc extends Bloc<DishEvent, DishState> {
  final DishRepository dishRepository;

  DishBloc({@required DishRepository dishRepository})
      : assert(dishRepository != null),
        dishRepository = dishRepository;

  @override
  DishState get initialState => DishState.empty();

  @override
  Stream<Transition<DishEvent, DishState>> transformEvents(
    Stream<DishEvent> events,
    TransitionFunction<DishEvent, DishState> transitionFn,
  ) {
    final debounceStream = events.where((event) {
      return (event is LoadDishEvent ||
          event is AddDishEvent ||
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
  Stream<DishState> mapEventToState(
    DishEvent event,
  ) async* {
    if (event is AddDishEvent) {
      yield* _mapDishAddPressedEventToState(event);
    } else if (event is DishTitleChangedEvent) {
      yield* _mapTitleChangedToState(event.title);
    } else if (event is DishDescriptionChangedEvent) {
      yield* _mapDescriptionChangedToState(event.description);
    } else if (event is DishImageAddedEvent) {
      yield* _mapImageAddedToState(event.path);
    }
  }

  Stream<DishState> _mapTitleChangedToState(String title) async* {
    yield state.copyWith(
      isTitleValid: Validators.isEmpty(title),
    );
  }

  Stream<DishState> _mapDescriptionChangedToState(String description) async* {
    yield state.copyWith(
      isDescriptionValid: Validators.isEmpty(description),
    );
  }

  Stream<DishState> _mapImageAddedToState(String path) async* {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    yield state.copyWith(
      imagePath: image.path,
      isImageAdded: image.path != null,
    );
  }

  Stream<DishState> _mapDishAddPressedEventToState(AddDishEvent event) async* {
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
