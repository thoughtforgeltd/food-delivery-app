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
            child: Container(
                padding: Dimensions.padding_16,
                child: Wrap(
                  children: <Widget>[
                    Row(
                      children: <Widget>[_buildUserDetails()],
                    ),
                  ],
                ))));
  }

  Widget _buildUserDetails() {
    return Expanded(
        child: Container(
            padding: Dimensions.padding_left_8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildUserName(),
                _buildEmail(),
                _buildContact()
              ],
            )));
  }

  _buildUserName() {
    return Container(
      margin: Dimensions.padding_4,
      child:
      Headline6(text: "${_userDetail.firstName} ${_userDetail.lastName}"),
    );
  }

  _buildEmail() {
    return Container(
      margin: Dimensions.padding_4,
      child: BodyText1(text: _userDetail.email),
    );
  }

  _buildContact() {
    return Container(
      margin: Dimensions.padding_4,
      child: BodyText1(text: _userDetail.phone),
    );
  }
}
