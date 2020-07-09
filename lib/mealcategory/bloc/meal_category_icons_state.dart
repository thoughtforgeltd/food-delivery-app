import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class MealCategoryIconsState {
  final List<String> icons;
  final bool isSuccess;
  final bool isFailure;
  final bool isLoading;

  MealCategoryIconsState(
      {@required this.icons,
      @required this.isSuccess,
      @required this.isFailure,
      @required this.isLoading});

  factory MealCategoryIconsState.empty() {
    return MealCategoryIconsState(
        icons: List(), isSuccess: false, isFailure: false, isLoading: false);
  }

  MealCategoryIconsState loading() {
    return copyWith(isLoading: true, isSuccess: false, isFailure: false);
  }

  MealCategoryIconsState failure() {
    return copyWith(isLoading: false, isSuccess: false, isFailure: true);
  }

  MealCategoryIconsState success({List<String> icons}) {
    return copyWith(
        icons: icons, isLoading: false, isSuccess: true, isFailure: false);
  }

  MealCategoryIconsState copyWith(
      {List<String> icons, bool isLoading, bool isSuccess, bool isFailure}) {
    return MealCategoryIconsState(
        icons: icons ?? this.icons,
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure);
  }

  @override
  String toString() {
    return '''MealCategoryIconsState {
      icons: $icons,
      isLoading: $isLoading,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
