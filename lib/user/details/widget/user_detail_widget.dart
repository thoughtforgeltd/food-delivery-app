import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/common/widget/widget.dart';
import 'package:fooddeliveryapp/user/user_details_alias.dart';

class UserDetailWidget extends StatefulWidget {
  State<UserDetailWidget> createState() => _UserDetailWidgetState();
}

class _UserDetailWidgetState extends State<UserDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserDetailBloc, UserDetailState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('There is a error while loading details'),
                    Icon(Icons.error)
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<UserDetailBloc, UserDetailState>(
        builder: (context, state) {
          return state.isLoading
              ? buildLoadingWidget()
              : state.isSuccess
                  ? Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          UserDetailCard(userDetail: state.details),
                          _buildActionsList(state.actions)
                        ],
                      ),
                    )
                  : Container();
        },
      ),
    );
  }

  _buildActionsList(List<UserProfileActions> actions) {
    return Column(
        children: actions
            ?.map((action) =>
                UserActionCard(action: action, onPressed: onActionPressed))
            ?.toList());
  }

  onActionPressed(UserProfileActions action) {
    switch (action) {
      case UserProfileActions.edit_profile:
        break;
      case UserProfileActions.contact_us:
        break;
      case UserProfileActions.console:
        Navigator.of(context).pushNamed('/console');
        break;
    }
  }
}
