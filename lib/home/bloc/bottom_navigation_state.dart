import 'package:fooddeliveryapp/home/model/model.dart';
import 'package:meta/meta.dart';

@immutable
class BottomNavigationState {
  final BottomNavigationOptions options;
  static const DEFAULT_SELECTION = BottomNavigationOptions.profile;

  BottomNavigationState({@required this.options});

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
