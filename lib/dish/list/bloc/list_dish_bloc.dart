import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/repositories/repositories.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class ListDishBloc extends Bloc<ListDishEvent, ListDishState> {
  final DishRepository dishRepository;

  ListDishBloc({@required DishRepository dishRepository})
      : assert(dishRepository != null),
        dishRepository = dishRepository;

  @override
  ListDishState get initialState => ListDishState.empty();

  @override
  Stream<Transition<ListDishEvent, ListDishState>> transformEvents(
    Stream<ListDishEvent> events,
    TransitionFunction<ListDishEvent, ListDishState> transitionFn,
  ) {
    final debounceStream = events.where((event) {
      return (event is LoadDishesEvent ||
          event is DeleteDishEvent ||
          event is EditDishEvent);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      debounceStream,
      transitionFn,
    );
  }

  @override
  Stream<ListDishState> mapEventToState(
    ListDishEvent event,
  ) async* {
    if (event is LoadDishesEvent) {
      yield* _mapLoadDishesEventToState(event);
    } else if (event is DeleteDishEvent) {
      yield* _mapDeleteDishEventToState(event);
    } else if (event is EditDishEvent) {
      yield* _mapEditDishEventToState(event);
    }
  }

  Stream<ListDishState> _mapLoadDishesEventToState(LoadDishesEvent event) async* {
    yield state.loading();
    try {
      final dishes = await dishRepository.loadDishes();
      yield state.success(dishes : dishes);
    } catch (_) {
      yield state.failure();
    }
  }

  Stream<ListDishState> _mapDeleteDishEventToState(DeleteDishEvent event) async* {

  }

  Stream<ListDishState> _mapEditDishEventToState(EditDishEvent event) async* {

  }
}
