import 'package:equatable/equatable.dart';

abstract class MealCategoryIconsEvent extends Equatable {
  const MealCategoryIconsEvent();

  @override
  List<Object> get props => [];
}

class LoadMealCategoryIconsEvent extends MealCategoryIconsEvent {}
