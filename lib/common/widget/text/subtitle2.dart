import 'package:flutter/material.dart';

class Subtitle2 extends StatelessWidget {
  final String _text;

  Subtitle2({Key key, String text})
      : _text = text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: Theme.of(context).textTheme.subtitle2,
    );
  }
}
