import 'package:flutter/material.dart';

class TextButton extends StatelessWidget {
  final String _text;

  TextButton({Key key, String text})
      : _text = text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: Theme.of(context).textTheme.button,
    );
  }
}
