import 'package:flutter/material.dart';

class BodyText1 extends StatelessWidget {
  final String _text;

  BodyText1({Key key, String text})
      : _text = text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}
