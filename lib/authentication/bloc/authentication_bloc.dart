import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/authentication/repository/user_details_repository.dart';
import 'package:fooddeliveryapp/authentication/repository/user_repository.dart';
import 'package:meta/meta.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  final UserDetailsRepository _userDetailsRepository;

  AuthenticationBloc(
      {@required UserRepository userRepository,
      @required UserDetailsRepository userDetailsRepository})
      : assert(userRepository != null && userDetailsRepository != null),
        _userRepository = userRepository,
        _userDetailsRepository = userDetailsRepository;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is AddedUserDetails) {
      yield* _mapUserDetailsAddedToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    final isSignedIn = await _userRepository.isSignedIn();
    if (isSignedIn) {
      final userId = await _userRepository.getUserID();
      final name = await _userRepository.getUser();
      final userDetails =
          await _userDetailsRepository.isUserDetailsEntered(userId.uid);
      if (userDetails.data != null)
        yield UserDetailsEntered(name);
      else
        yield Authenticated(name);
    } else {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    final userId = await _userRepository.getUserID();
    final name = await _userRepository.getUser();
    final userDetails =
        await _userDetailsRepository.isUserDetailsEntered(userId.uid);
    if (userDetails.exists)
      yield UserDetailsEntered(name);
    else
      yield Authenticated(name);
  }

  Stream<AuthenticationState> _mapUserDetailsAddedToState() async* {
    yield UserDetailsEntered(await _userRepository.getUser());
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }
}
