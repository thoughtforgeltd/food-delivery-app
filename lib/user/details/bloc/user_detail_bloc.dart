import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/user/user_details_alias.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final UserDetailsRepository _userDetailsRepository;

  UserDetailBloc({@required UserDetailsRepository userDetailsRepository})
      : assert(userDetailsRepository != null),
        _userDetailsRepository = userDetailsRepository;

  @override
  UserDetailState get initialState => UserDetailState.empty();

  @override
  Stream<Transition<UserDetailEvent, UserDetailState>> transformEvents(
    Stream<UserDetailEvent> events,
    TransitionFunction<UserDetailEvent, UserDetailState> transitionFn,
  ) {
    final debounceStream = events.where((event) {
      return (event is UserDetailLoadEvent);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      debounceStream,
      transitionFn,
    );
  }

  @override
  Stream<UserDetailState> mapEventToState(
    UserDetailEvent event,
  ) async* {
    if (event is UserDetailLoadEvent) {
      yield* _mapUserDetailLoadEventToState();
    }
  }

  Stream<UserDetailState> _mapUserDetailLoadEventToState() async* {
    yield state.loading();
    try {
      final details = await _userDetailsRepository.loadUserDetails();
      yield state.success(details: details);
    } catch (_) {
      yield state.failure();
    }
  }
}
