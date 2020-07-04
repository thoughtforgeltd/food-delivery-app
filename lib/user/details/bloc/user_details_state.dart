import 'package:meta/meta.dart';

@immutable
class UserDetailsState {
  final bool isFirstNameValid;
  final bool isLastNameValid;
  final bool isAddressValid;
  final bool isPhoneValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String phone;

  bool get isFormValid =>
      isFirstNameValid && isLastNameValid && isAddressValid && isPhoneValid;

  UserDetailsState({
    @required this.isFirstNameValid,
    @required this.isLastNameValid,
    @required this.isAddressValid,
    @required this.isPhoneValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.phone,
  });

  factory UserDetailsState.empty() {
    return UserDetailsState(
      isFirstNameValid: true,
      isLastNameValid: true,
      isAddressValid: true,
      isPhoneValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      phone: null,
    );
  }

  factory UserDetailsState.loading() {
    return UserDetailsState(
      isFirstNameValid: true,
      isLastNameValid: true,
      isAddressValid: true,
      isPhoneValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      phone: null,
    );
  }

  factory UserDetailsState.failure() {
    return UserDetailsState(
      isFirstNameValid: true,
      isLastNameValid: true,
      isAddressValid: true,
      isPhoneValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      phone: null,
    );
  }

  factory UserDetailsState.success() {
    return UserDetailsState(
      isFirstNameValid: true,
      isLastNameValid: true,
      isAddressValid: true,
      isPhoneValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      phone: null,
    );
  }

  UserDetailsState update({
    bool isFirstNameValid,
    bool isLastNameValid,
    bool isAddressValid,
    bool isPhoneValid,
    String phone,
  }) {
    return copyWith(
      isFirstNameValid: isFirstNameValid,
      isLastNameValid: isLastNameValid,
      isAddressValid: isAddressValid,
      isPhoneValid: isPhoneValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      phone: phone,
    );
  }

  UserDetailsState copyWith({
    bool isFirstNameValid,
    bool isLastNameValid,
    bool isAddressValid,
    bool isPhoneValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    String phone,
  }) {
    return UserDetailsState(
      isFirstNameValid: isFirstNameValid ?? this.isFirstNameValid,
      isLastNameValid: isLastNameValid ?? this.isLastNameValid,
      isAddressValid: isAddressValid ?? this.isAddressValid,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      phone: phone ?? this.phone,
    );
  }

  @override
  String toString() {
    return '''UserDetailsState {
      isFirstNameValid: $isFirstNameValid,
      isLastNameValid: $isLastNameValid,
      isAddressValid: $isAddressValid,
      isPhoneValid: $isPhoneValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      phone: $phone,
    }''';
  }
}
