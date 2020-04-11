import 'package:meta/meta.dart';

@immutable
class MealScheduleState {

  final DateTime selectedDate;
  final DateTime startDate;
  final Map<String, bool> mealsSelection;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  MealScheduleState({
    @required this.startDate,
    @required this.selectedDate,
    @required this.mealsSelection,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory MealScheduleState.empty() {
    return MealScheduleState(
      startDate: new DateTime.now(),
      selectedDate: new DateTime.now(),
      mealsSelection: {},
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory MealScheduleState.loading() {
    return MealScheduleState(
      startDate: new DateTime.now(),
      selectedDate: new DateTime.now(),
      mealsSelection: {},
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory MealScheduleState.failure() {
    return MealScheduleState(
      startDate: new DateTime.now(),
      selectedDate: new DateTime.now(),
      mealsSelection: {},
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory MealScheduleState.success() {
    return MealScheduleState(
      startDate: new DateTime.now(),
      selectedDate: new DateTime.now(),
      mealsSelection: {},
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  MealScheduleState update({
    DateTime selectedDate,
    Map<String, bool> mealsSelection,
  }) {
    return copyWith(
      selectedDate: selectedDate,
      mealsSelection: mealsSelection,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  MealScheduleState copyWith({
    DateTime selectedDate,
    Map<String, bool> mealsSelection,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return MealScheduleState(
      startDate: startDate ?? this.startDate,
      selectedDate: selectedDate ?? this.selectedDate,
      mealsSelection: mealsSelection ?? this.mealsSelection,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''MealScheduleState {
      startDate: $startDate,
      selectedDate: $selectedDate,
      mealsSelection: $mealsSelection,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
