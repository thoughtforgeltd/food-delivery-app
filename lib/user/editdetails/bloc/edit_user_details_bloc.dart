import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/common/validators.dart';
import 'package:fooddeliveryapp/user/user_details_alias.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class EditUserDetailsBloc
    extends Bloc<EditUserDetailsEvent, EditUserDetailsState> {
  final UserDetailsRepository _userDetailsRepository;

  EditUserDetailsBloc({@required UserDetailsRepository userDetailsRepository})
      : assert(userDetailsRepository != null),
        _userDetailsRepository = userDetailsRepository;

  @override
  EditUserDetailsState get initialState => EditUserDetailsState.empty();

  @override
  Stream<Transition<EditUserDetailsEvent, EditUserDetailsState>>
      transformEvents(
    Stream<EditUserDetailsEvent> events,
    TransitionFunction<EditUserDetailsEvent, EditUserDetailsState> transitionFn,
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
  Stream<EditUserDetailsState> mapEventToState(
      EditUserDetailsEvent event,) async* {
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

  Stream<EditUserDetailsState> _mapFirstNameChangedToState(
      String firstName) async* {
    yield state.update(
      isFirstNameValid: Validators.isEmpty(firstName),
    );
  }

  Stream<EditUserDetailsState> _mapLastNameChangedToState(
      String lastName) async* {
    yield state.update(
      isLastNameValid: Validators.isEmpty(lastName),
    );
  }

  Stream<EditUserDetailsState> _mapAddressChangedToState(
      String address) async* {
    yield state.update(
      isAddressValid: Validators.isEmpty(address),
    );
  }

  Stream<EditUserDetailsState> _mapPhoneChangedToState(String phone) async* {
    yield state.update(
      phone: phone,
      isPhoneValid: Validators.isEmpty(phone),
    );
  }

  Stream<EditUserDetailsState> _mapFormSubmittedToState(String firstName,
      String lastName, String address, String phone) async* {
    yield EditUserDetailsState.loading();
    try {
      await _userDetailsRepository.updateUserDetails(UserDetails(
          firstName: firstName,
          lastName: lastName,
          address: address,
          phone: phone));
      yield EditUserDetailsState.success();
    } catch (_) {
      yield EditUserDetailsState.failure();
    }
  }
}
