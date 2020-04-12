import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback _onPressed;
  final String _label;

  Button({Key key, VoidCallback onPressed, String label})
      : _onPressed = onPressed,
        _label = label,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onPressed: _onPressed,
      child: Text(_label),
    );
  }
}
