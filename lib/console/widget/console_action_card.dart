import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/common/widget/text/text.dart';
import 'package:fooddeliveryapp/console/console.dart';
import 'package:fooddeliveryapp/design/colors.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';

class ConsoleActionCard extends StatelessWidget {
  final ConsoleActions _action;
  final void Function(ConsoleActions) _onPressed;

  ConsoleActionCard(
      {Key key,
      @required ConsoleActions action,
      @required Function(ConsoleActions) onPressed})
      : _action = action,
        _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: InkWell(
                onTap: () => _onPressed(_action),
                child: Row(
                  children: <Widget>[
                    _buildStartIcon(),
                    _buildTitle(),
                    _buildEndIcon()
                  ],
                ))));
  }

  Widget _buildStartIcon() {
    return Container(
        padding: Dimensions.padding_16,
        child: Icon(_action.icon, color: AppColors.colorPrimary));
  }

  Widget _buildEndIcon() {
    return Container(
        padding: Dimensions.padding_16,
        child: Icon(Icons.keyboard_arrow_right, color: AppColors.colorPrimary));
  }

  Widget _buildTitle() {
    return Expanded(
        child: Container(
      margin: Dimensions.padding_4,
      child: BodyText1(text: _action.title),
    ));
  }
}
