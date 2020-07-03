import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class AddDishState {
  final bool isTitleValid;
  final bool isDescriptionValid;
  final bool isImageAdded;
  final String imagePath;
  final bool isSuccess;
  final bool isFailure;
  final bool isSubmitting;

  bool get isDataValid => isTitleValid && isDescriptionValid && imagePath!= null;

  AddDishState(
      {@required this.isTitleValid,
      @required this.isDescriptionValid,
      @required this.isImageAdded,
      @required this.imagePath,
      @required this.isSuccess,
      @required this.isFailure,
      @required this.isSubmitting});

  factory AddDishState.empty() {
    return AddDishState(
        isTitleValid: true,
        isDescriptionValid: true,
        imagePath: null,
        isImageAdded: false,
        isSuccess: false,
        isFailure: false,
        isSubmitting: false);
  }

  AddDishState loading() {
    return copyWith(isSubmitting: true, isSuccess: false, isFailure: false);
  }

  AddDishState failure() {
    return copyWith(isSubmitting: false, isSuccess: false, isFailure: true);
  }

  AddDishState success() {
    return copyWith(isSubmitting: false, isSuccess: true, isFailure: false);
  }

  AddDishState copyWith(
      {bool isTitleValid,
      bool isDescriptionValid,
      String imagePath,
      bool isImageAdded,
      bool isSubmitting,
      bool isSuccess,
      bool isFailure}) {
    return AddDishState(
        isTitleValid: this.isTitleValid,
        isDescriptionValid: this.isDescriptionValid,
        isImageAdded: this.isImageAdded,
        imagePath: imagePath ?? this.imagePath,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure);
  }

  @override
  String toString() {
    return '''DishState {
      title: $isTitleValid,
      description: $isDescriptionValid,
      isImageAdded: $isImageAdded,
      image: $isImageAdded,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
