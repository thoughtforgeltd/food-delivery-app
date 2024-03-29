import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';

class TextButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final String _label;

  TextButton({Key key, VoidCallback onPressed, String label})
      : _onPressed = onPressed,
        _label = label,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      textColor: Theme.of(context).colorScheme.onPrimary,
      onPressed: _onPressed,
      child:
          Text(_label, style: TextStyle(fontSize: Dimensions.button_text_size)),
    );
  }
}
