import 'package:flutter/material.dart';

class Headline5 extends StatelessWidget {
  final String _text;

  Headline5({Key key, String text})
      : _text = text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: Theme.of(context).textTheme.headline5,
    );
  }
}
