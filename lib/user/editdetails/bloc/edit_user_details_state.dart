import 'package:meta/meta.dart';

@immutable
class EditUserDetailsState {
  final bool isFirstNameValid;
  final bool isLastNameValid;
  final bool isAddressValid;
  final bool isPhoneValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String imagePath;
  final String phone;

  bool get isFormValid =>
      isFirstNameValid &&
      isLastNameValid &&
      isAddressValid &&
      isPhoneValid &&
      imagePath != null;

  EditUserDetailsState({
    @required this.isFirstNameValid,
    @required this.isLastNameValid,
    @required this.isAddressValid,
    @required this.isPhoneValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.phone,
    @required this.imagePath,
  });

  factory EditUserDetailsState.empty() {
    return EditUserDetailsState(
      isFirstNameValid: true,
      isLastNameValid: true,
      isAddressValid: true,
      isPhoneValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      phone: null,
        imagePath: null
    );
  }

  factory EditUserDetailsState.loading() {
    return EditUserDetailsState(
      isFirstNameValid: true,
      isLastNameValid: true,
      isAddressValid: true,
      isPhoneValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      phone: null,
        imagePath: null
    );
  }

  factory EditUserDetailsState.failure() {
    return EditUserDetailsState(
      isFirstNameValid: true,
      isLastNameValid: true,
      isAddressValid: true,
      isPhoneValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      phone: null,
        imagePath: null
    );
  }

  factory EditUserDetailsState.success() {
    return EditUserDetailsState(
      isFirstNameValid: true,
      isLastNameValid: true,
      isAddressValid: true,
      isPhoneValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      phone: null,
        imagePath: null
    );
  }

  EditUserDetailsState update({
    bool isFirstNameValid,
    bool isLastNameValid,
    bool isAddressValid,
    bool isPhoneValid,
    String phone,
    String imagePath,
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
        imagePath: imagePath
    );
  }

  EditUserDetailsState copyWith({
    bool isFirstNameValid,
    bool isLastNameValid,
    bool isAddressValid,
    bool isPhoneValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    String phone,
    String imagePath,
  }) {
    return EditUserDetailsState(
      isFirstNameValid: isFirstNameValid ?? this.isFirstNameValid,
      isLastNameValid: isLastNameValid ?? this.isLastNameValid,
      isAddressValid: isAddressValid ?? this.isAddressValid,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      phone: phone ?? this.phone,
      imagePath: imagePath ?? this.imagePath,
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
      imagePath: $imagePath,
    }''';
  }
}
