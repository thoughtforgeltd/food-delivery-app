import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooddeliveryapp/meals/model/meal.dart';
import 'package:fooddeliveryapp/meals/model/meal_schedules.dart';
import 'package:fooddeliveryapp/meals/model/meal_selection.dart';
import 'package:fooddeliveryapp/meals/model/meal_type_configurations.dart';
import 'package:fooddeliveryapp/meals/model/schedule.dart';
import 'package:meta/meta.dart';
import 'package:fooddeliveryapp/utilities/date_utilities.dart';

@immutable
class MealScheduleState {
  final Timestamp selectedDate;
  final Timestamp startDate;
  final MealSchedules mealsSelection;
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
      startDate: Timestamp.now(),
      selectedDate:  Timestamp.now(),
      mealsSelection: MealSchedules(),
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

  MealScheduleState success(
      {MealSchedules mealsSelection, MealTypeConfigurations mealTypes}) {
    return copyWith(
      mealsSelection: mealsSelection,
      mealTypes: mealTypes,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  MealScheduleState copyWith({
    Timestamp startDate,
    Timestamp selectedDate,
    MealSchedules mealsSelection,
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

  MealScheduleState updateSchedule({
    MealSelection selection,
    int quantityOperator
  }) {
    if (selection.schedules == null) {
      selection.schedules =
          Schedules(quantity: 0, id: selection.configurations.id);
    }
    if(selection.schedules.quantity > 0){
      selection?.schedules?.quantity = selection.schedules.quantity + quantityOperator;
    }else {
      selection?.schedules?.quantity = 0;
    }

    final date = selection.date;
    final meals = this.mealsSelection.meals ?? List<Meal>();
    if (meals.isEmpty) {
      meals.add(Meal(date: date, schedules: [selection.schedules]));
      this.mealsSelection.meals = meals;
    } else {
      final mealOfSpecificDay = meals
          ?.firstWhere((element) => element?.date?.isSameDayFromTimestamp(date), orElse: () => null);

      final scheduleOfSpecificDay = mealOfSpecificDay?.schedules?.firstWhere(
          (element) => element?.id == selection.configurations.id,
          orElse: () => null);

      if (mealOfSpecificDay == null) {
        meals.add(Meal(date: date, schedules: [selection.schedules]));
      } else if (scheduleOfSpecificDay == null) {
        mealOfSpecificDay.schedules.add(Schedules(
            id: selection.schedules.id,
            quantity: selection.schedules.quantity));
      } else {
        scheduleOfSpecificDay.quantity = selection.schedules.quantity;
      }
    }
    return copyWith(
      mealsSelection: this.mealsSelection,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false
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
