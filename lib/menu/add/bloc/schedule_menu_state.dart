import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';
import 'package:fooddeliveryapp/menu/add/add_schedule.dart';
import 'package:meta/meta.dart';

@immutable
class ScheduleMenuState {
  final DateTime selectedDate;
  final DateTime startDate;
  final MenusView menus;
  final Categories categories;
  final String selectedCategory;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool isSubmitted;

  MenuView get menuSelection => menus?.getMenuView(selectedDate);

  ScheduleMenuState({
    @required this.startDate,
    @required this.selectedDate,
    @required this.selectedCategory,
    @required this.menus,
    @required this.categories,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.isSubmitted,
  });

  factory ScheduleMenuState.empty() {
    return ScheduleMenuState(
        startDate: DateTime.now(),
        selectedDate: DateTime.now(),
        selectedCategory: null,
        menus: null,
        categories: null,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        isSubmitted: false);
  }

  ScheduleMenuState loading() {
    return copyWith(
        isSubmitting: true,
        isSuccess: false,
        isFailure: false,
        isSubmitted: false);
  }

  ScheduleMenuState failure() {
    return copyWith(
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        isSubmitted: false);
  }

  ScheduleMenuState success(
      {MenusView menus,
      Categories categories,
      String selectedCategory,
      bool handleSubmitted}) {
    return copyWith(
        menus: menus,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false,
        categories: categories,
        selectedCategory: selectedCategory,
        isSubmitted: handleSubmitted);
  }

  ScheduleMenuState copyWith({Timestamp startDate,
    Timestamp selectedDate,
    String selectedCategory,
    MenusView menus,
    Categories categories,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    bool isSubmitted}) {
    return ScheduleMenuState(
        startDate: startDate ?? this.startDate,
        selectedDate: selectedDate ?? this.selectedDate,
        menus: menus ?? this.menus,
        selectedCategory: selectedCategory ?? this.selectedCategory,
        categories: categories ?? this.categories,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure,
        isSubmitted: isSubmitted ?? this.isSubmitted);
  }

  @override
  String toString() {
    return '''ScheduleMenuState {
      startDate: $startDate,
      selectedDate: $selectedDate,
      selectedCategory: $selectedCategory,
      menus: $menus,
      categories: $categories,
      menuSelection: $menuSelection,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      isSubmitted: $isSubmitted
    }''';
  }
}
