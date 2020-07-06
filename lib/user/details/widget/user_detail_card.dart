import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/common/widget/text/text.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/user/user_details_alias.dart';

class UserDetailCard extends StatelessWidget {
  final UserDetails _userDetail;

  UserDetailCard({Key key, @required UserDetails userDetail})
      : _userDetail = userDetail,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          elevation: 5,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            children: <Widget>[_buildDishDetails()],
          )),
    );
  }

  Widget _buildDishDetails() {
    return Expanded(
        child: Container(
            padding: Dimensions.padding_left_8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[_buildDishTitle(), _buildDishDescription()],
            )));
  }

  _buildDishTitle() {
    return Container(
      margin: Dimensions.padding_4,
      child: Subtitle1(text: _userDetail.firstName),
    );
  }

  _buildDishDescription() {
    return Container(
      margin: Dimensions.padding_4,
      child: BodyText1(text: _userDetail.lastName),
    );
  }
}
