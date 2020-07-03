import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/dish/model/model.dart';
import 'package:meta/meta.dart';

@immutable
class ListDishState {
  final Dishes dishes;
  final bool isSuccess;
  final bool isFailure;
  final bool isLoading;

  ListDishState(
      {@required this.dishes,
      @required this.isSuccess,
      @required this.isFailure,
      @required this.isLoading});

  factory ListDishState.empty() {
    return ListDishState(
        dishes: Dishes(
          dishes: List()
        ),
        isSuccess: false,
        isFailure: false,
        isLoading: false);
  }

  ListDishState loading() {
    return copyWith(isLoading: true, isSuccess: false, isFailure: false);
  }

  ListDishState failure() {
    return copyWith(isLoading: false, isSuccess: false, isFailure: true);
  }

  ListDishState success({Dishes dishes}) {
    return copyWith(dishes: dishes, isLoading: false, isSuccess: true, isFailure: false);
  }

  ListDishState copyWith(
      {Dishes dishes,
      bool isLoading,
      bool isSuccess,
      bool isFailure}) {
    return ListDishState(
        dishes: dishes ?? this.dishes,
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure);
  }

  @override
  String toString() {
    return '''ListDishState {
      dishes: $dishes,
      isLoading: $isLoading,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
