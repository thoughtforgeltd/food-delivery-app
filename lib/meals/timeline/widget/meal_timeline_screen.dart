import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/meals/bloc/bloc.dart';
import 'package:fooddeliveryapp/meals/timeline/widget/widget.dart';

class MealTimelineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MealScheduleBloc>(
      create: (context) => BlocProvider.of(context)..add(MealSchedulesLoaded()),
      child: MealTimelineWidget(),
    );
  }
}
