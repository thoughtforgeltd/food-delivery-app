import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../console.dart';

class ConsoleBloc extends Bloc<ConsoleEvent, ConsoleState> {
  @override
  ConsoleState get initialState => ConsoleState();

  @override
  Stream<Transition<ConsoleEvent, ConsoleState>> transformEvents(
    Stream<ConsoleEvent> events,
    TransitionFunction<ConsoleEvent, ConsoleState> transitionFn,
  ) {
    final debounceStream = events.where((event) {
      return (event is LoadConsoleActionsEvent);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      debounceStream,
      transitionFn,
    );
  }

  @override
  Stream<ConsoleState> mapEventToState(
    ConsoleEvent event,
  ) async* {}
}
