import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../meal_category.dart';

@immutable
class CategoriesState {
  final Categories categories;
  final bool isSuccess;
  final bool isFailure;
  final bool isLoading;

  CategoriesState(
      {@required this.categories,
      @required this.isSuccess,
      @required this.isFailure,
      @required this.isLoading});

  factory CategoriesState.empty() {
    return CategoriesState(
        categories: Categories(categories: List()),
        isSuccess: false,
        isFailure: false,
        isLoading: false);
  }

  CategoriesState loading() {
    return copyWith(isLoading: true, isSuccess: false, isFailure: false);
  }

  CategoriesState failure() {
    return copyWith(isLoading: false, isSuccess: false, isFailure: true);
  }

  CategoriesState success({Categories categories}) {
    return copyWith(
        categories: categories,
        isLoading: false,
        isSuccess: true,
        isFailure: false);
  }

  CategoriesState copyWith(
      {Categories categories, bool isLoading, bool isSuccess, bool isFailure}) {
    return CategoriesState(
        categories: categories ?? this.categories,
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure);
  }

  @override
  String toString() {
    return '''CategoriesState {
      categories: $categories,
      isLoading: $isLoading,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
