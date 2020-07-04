import 'package:flutter/material.dart';

class Headline1 extends StatelessWidget {
  final String _text;

  Headline1({Key key, String text})
      : _text = text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: Theme.of(context).textTheme.headline1,
    );
  }
}
