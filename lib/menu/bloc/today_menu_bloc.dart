import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/menu/bloc/today_menu_event.dart';
import 'package:fooddeliveryapp/menu/bloc/today_menu_state.dart';
import 'package:fooddeliveryapp/repositories/today_menu_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:fooddeliveryapp/utilities/date_utilities.dart';

class TodayMenuBloc extends Bloc<TodayMenuEvent, TodayMenuState> {
  final TodayMenuRepository _todayMenuRepository;

  TodayMenuBloc({@required TodayMenuRepository todayMenuRepository})
      : assert(todayMenuRepository != null),
        _todayMenuRepository = todayMenuRepository;

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
  Stream<TodayMenuState> mapEventToState(
      TodayMenuEvent event,
  ) async* {
    if (event is TodayMenuLoadEvent) {
      yield* _mapTodayMenuLoadEventToState();
    }
  }

  Stream<TodayMenuState> _mapTodayMenuLoadEventToState() async* {
    yield state.loading();
    try {
      final menus = await _todayMenuRepository.loadTodayMenu(state.date.toMenuDate());
      yield state.success(menus: menus);
    } catch (_) {
      yield state.failure();
    }
  }
}
