import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';

class DateWidget extends StatelessWidget {
  final String _label;

  DateWidget({Key key, @required String label})
      : _label = label,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
            padding: Dimensions.padding_16,
            child: Center(
                child: Text(_label,
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.center))));
  }
}
