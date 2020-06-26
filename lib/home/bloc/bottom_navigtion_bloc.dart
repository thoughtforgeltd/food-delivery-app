import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/home/bloc/bottom_navigation_event.dart';
import 'package:fooddeliveryapp/home/bloc/bottom_navigation_state.dart';
import 'package:fooddeliveryapp/home/bloc/model/bottom_navigation_options.dart';
import 'package:fooddeliveryapp/meals/bloc/meal_schedule_event.dart';
import 'package:rxdart/rxdart.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {

  @override
  BottomNavigationState get initialState => BottomNavigationState.empty();

  @override
  Stream<Transition<BottomNavigationEvent, BottomNavigationState>> transformEvents(
    Stream<BottomNavigationEvent> events,
    TransitionFunction<BottomNavigationEvent, BottomNavigationState> transitionFn,
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
  Stream<BottomNavigationState> mapEventToState(
      BottomNavigationEvent event,
  ) async* {
    if (event is BottomNavigationChanged) {
      yield* _mapBottomNavigationChangedToState(event.options);
    }
  }

  Stream<BottomNavigationState> _mapBottomNavigationChangedToState(
      BottomNavigationOptions options) async* {
    yield BottomNavigationState.update(options: options);
  }
}
