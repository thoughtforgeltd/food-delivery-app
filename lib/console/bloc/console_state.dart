import 'package:fooddeliveryapp/console/console.dart';
import 'package:meta/meta.dart';

@immutable
class ConsoleState {
  final List<ConsoleActions> actions = ConsoleActions.values;

  @override
  String toString() {
    return '''ConsoleState {
      actions: $actions,
    }''';
  }
}
