import 'package:fooddeliveryapp/meals/model/meal_type_configurations.dart';
import 'package:meta/meta.dart';

@immutable
class MealScheduleState {

  final DateTime selectedDate;
  final DateTime startDate;
  final Map<String, Map<String, bool>> mealsSelection;
  final MealTypeConfigurations mealTypes;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  MealScheduleState({
    @required this.startDate,
    @required this.selectedDate,
    @required this.mealsSelection,
    @required this.mealTypes,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory MealScheduleState.empty() {
    return MealScheduleState(
      startDate: DateTime.now(),
      selectedDate: DateTime.now(),
      mealsSelection: Map(),
      mealTypes: MealTypeConfigurations(types: List()),
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  MealScheduleState loading() {
    return copyWith(
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  MealScheduleState failure() {
    return copyWith(
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  MealScheduleState success({
    Map<String,Map<String, bool>> mealsSelection,
    MealTypeConfigurations mealTypes
  }) {
    return copyWith(
      mealsSelection: mealsSelection,
      mealTypes: mealTypes,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  MealScheduleState copyWith({
    DateTime startDate,
    DateTime selectedDate,
    Map<String,Map<String, bool>> mealsSelection,
    MealTypeConfigurations mealTypes,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return MealScheduleState(
      startDate: startDate ?? this.startDate,
      selectedDate: selectedDate ?? this.selectedDate,
      mealsSelection: mealsSelection ?? this.mealsSelection,
      mealTypes: mealTypes ?? this.mealTypes,
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
      mealTypes: $mealTypes,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
