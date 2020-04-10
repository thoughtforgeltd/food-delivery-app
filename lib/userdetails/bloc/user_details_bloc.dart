import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/authentication/repository/user_details_repository.dart';
import 'package:fooddeliveryapp/common/validators.dart';
import 'package:fooddeliveryapp/userdetails/bloc/user_details_event.dart';
import 'package:fooddeliveryapp/userdetails/bloc/user_details_state.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final UserDetailsRepository _userDetailsRepository;

  UserDetailsBloc({@required UserDetailsRepository userDetailsRepository})
      : assert(userDetailsRepository != null),
        _userDetailsRepository = userDetailsRepository;

  @override
  UserDetailsState get initialState => UserDetailsState.empty();

  @override
  Stream<Transition<UserDetailsEvent, UserDetailsState>> transformEvents(
    Stream<UserDetailsEvent> events,
    TransitionFunction<UserDetailsEvent, UserDetailsState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! FirstNameChanged &&
          event is! LastNameChanged &&
          event is! AddressChanged &&
          event is! PhoneChanged);
    });
    final debounceStream = events.where((event) {
      return (event is FirstNameChanged ||
          event is LastNameChanged ||
          event is AddressChanged ||
          event is PhoneChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<UserDetailsState> mapEventToState(
    UserDetailsEvent event,
  ) async* {
    if (event is FirstNameChanged) {
      yield* _mapFirstNameChangedToState(event.firstName);
    } else if (event is LastNameChanged) {
      yield* _mapLastNameChangedToState(event.lastName);
    } else if (event is AddressChanged) {
      yield* _mapAddressChangedToState(event.address);
    } else if (event is PhoneChanged) {
      yield* _mapPhoneChangedToState(event.phone);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(
          event.firstName, event.lastName, event.address, event.phone);
    }
  }

  Stream<UserDetailsState> _mapFirstNameChangedToState(
      String firstName) async* {
    yield state.update(
      isFirstNameValid: Validators.isEmpty(firstName),
    );
  }

  Stream<UserDetailsState> _mapLastNameChangedToState(String lastName) async* {
    yield state.update(
      isLastNameValid: Validators.isEmpty(lastName),
    );
  }

  Stream<UserDetailsState> _mapAddressChangedToState(String address) async* {
    yield state.update(
      isAddressValid: Validators.isEmpty(address),
    );
  }

  Stream<UserDetailsState> _mapPhoneChangedToState(String phone) async* {
    yield state.update(
      isPhoneValid: Validators.isEmpty(phone),
    );
  }

  Stream<UserDetailsState> _mapFormSubmittedToState(
      String firstName, String lastName, String address, String phone) async* {
    yield UserDetailsState.loading();
    try {
      await _userDetailsRepository.updateUserDetails(
          firstName, lastName, address, phone);
      yield UserDetailsState.success();
    } catch (_) {
      yield UserDetailsState.failure();
    }
  }
}
