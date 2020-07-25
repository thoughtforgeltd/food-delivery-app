import 'package:fooddeliveryapp/menu/model/model.dart';
import 'package:meta/meta.dart';

@immutable
class TodayMenuState {
  final Menus menus;
  final DateTime date;
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;

  TodayMenuState(
      {@required this.date,
      @required this.menus,
      @required this.isLoading,
      @required this.isSuccess,
      @required this.isFailure});

  factory TodayMenuState.empty() {
    return TodayMenuState(
        date: DateTime.now(),
        menus: Menus(menus: List()),
        isLoading: false,
        isSuccess: false,
        isFailure: false);
  }

  TodayMenuState loading() {
    return copyWith(isLoading: true, isSuccess: false, isFailure: false);
  }

  TodayMenuState failure() {
    return copyWith(isLoading: false, isSuccess: false, isFailure: true);
  }

  TodayMenuState success({Menus menus}) {
    return copyWith(
        menus: menus, isLoading: false, isSuccess: true, isFailure: false);
  }

  TodayMenuState copyWith(
      {Menus menus, bool isLoading, bool isSuccess, bool isFailure}) {
    return TodayMenuState(
        date: this.date,
        menus: menus ?? this.menus,
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure);
  }

  @override
  String toString() {
    return '''TodayMenuState {
      date: $date,
      menus: $menus,
      isLoading: $isLoading,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
