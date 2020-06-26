import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooddeliveryapp/home/bloc/model/bottom_navigation_options.dart';
import 'package:fooddeliveryapp/meals/model/meal.dart';
import 'package:fooddeliveryapp/meals/model/meal_schedules.dart';
import 'package:fooddeliveryapp/meals/model/meal_selection.dart';
import 'package:fooddeliveryapp/meals/model/meal_type_configurations.dart';
import 'package:fooddeliveryapp/meals/model/schedule.dart';
import 'package:meta/meta.dart';
import 'package:fooddeliveryapp/utilities/date_utilities.dart';

@immutable
class BottomNavigationState {
  final BottomNavigationOptions options;
  static const DEFAULT_SELECTION = BottomNavigationOptions.meals_timeline;

  BottomNavigationState({
    @required this.options
  });

  factory BottomNavigationState.empty() {
    return BottomNavigationState(
      options: DEFAULT_SELECTION,
    );
  }

  factory BottomNavigationState.update({
    final BottomNavigationOptions options
}) {
    return BottomNavigationState(
      options: options ?? DEFAULT_SELECTION,
    );
  }

  @override
  String toString() {
    return '''BottomNavigationState {
      options: $options
    }''';
  }
}
