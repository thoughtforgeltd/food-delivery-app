import 'package:fooddeliveryapp/user/user_details_alias.dart';
import 'package:meta/meta.dart';

@immutable
class UserDetailState {
  final UserDetails details;
  final List<UserProfileActions> actions;
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;

  UserDetailState(
      {@required this.details,
      @required this.actions,
      @required this.isLoading,
      @required this.isSuccess,
      @required this.isFailure});

  factory UserDetailState.empty() {
    return UserDetailState(
        details: null,
        actions: List(),
        isLoading: false,
        isSuccess: false,
        isFailure: false);
  }

  UserDetailState loading() {
    return copyWith(isLoading: true, isSuccess: false, isFailure: false);
  }

  UserDetailState failure() {
    return copyWith(isLoading: false, isSuccess: false, isFailure: true);
  }

  UserDetailState success(
      {UserDetails details, List<UserProfileActions> actions}) {
    return copyWith(
        details: details,
        actions: actions,
        isLoading: false,
        isSuccess: true,
        isFailure: false);
  }

  UserDetailState copyWith({UserDetails details, List<
      UserProfileActions> actions, bool isLoading, bool isSuccess, bool isFailure}) {
    return UserDetailState(
        actions: actions ?? this.actions,
        details: details ?? this.details,
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure);
  }

  @override
  String toString() {
    return '''UserDetailState {
      details: $details,
      actions: $actions,
      isLoading: $isLoading,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
