import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/common/widget/text/text.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';

class AddCard extends StatelessWidget {
  final String _title;
  final void Function(String) _onAddButtonPressed;

  AddCard(
      {Key key,
      @required String title,
      @required Function(String) onAddButtonPressed})
      : _title = title,
        _onAddButtonPressed = onAddButtonPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
            onTap: () => _onAddButtonPressed(_title),
            child: Container(
                padding: Dimensions.padding_8,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[_buildStartIcon(), _buildTitle()],
                ))));
  }

  Widget _buildStartIcon() {
    return Container(padding: Dimensions.padding_4, child: Icon(Icons.add));
  }

  Widget _buildTitle() {
    return Container(
      padding: Dimensions.padding_4,
      child: BodyText1(text: _title),
    );
  }
}
