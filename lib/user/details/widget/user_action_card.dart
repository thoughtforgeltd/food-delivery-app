import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/common/widget/text/text.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/user/user_details_alias.dart';

class UserActionCard extends StatelessWidget {
  final UserProfileActions _action;
  final void Function(UserProfileActions) _onPressed;

  UserActionCard(
      {Key key,
      @required UserProfileActions action,
      @required Function(UserProfileActions) onPressed})
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
                    _buildStartIcon(context),
                    _buildTitle(),
                    _buildEndIcon(context)
                  ],
                ))));
  }

  Widget _buildStartIcon(BuildContext context) {
    return Container(
        padding: Dimensions.padding_16,
        child: Icon(_action.icon, color: Theme.of(context).primaryColor));
  }

  Widget _buildEndIcon(BuildContext context) {
    return Container(
        padding: Dimensions.padding_16,
        child: Icon(Icons.keyboard_arrow_right, color: Theme
            .of(context)
            .primaryColor));
  }

  Widget _buildTitle() {
    return Expanded(
        child: Container(
      margin: Dimensions.padding_4,
      child: BodyText1(text: _action.title),
    ));
  }
}
