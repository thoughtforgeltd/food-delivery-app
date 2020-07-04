import 'package:flutter/material.dart';

class OverLine extends StatelessWidget {
  final String _text;

  OverLine({Key key, String text})
      : _text = text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: Theme.of(context).textTheme.overline,
    );
  }
}
