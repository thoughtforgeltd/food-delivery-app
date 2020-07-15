import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/common/widget/widget.dart';
import 'package:fooddeliveryapp/design/colors.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/meals/bloc/bloc.dart';
import 'package:fooddeliveryapp/meals/model/model.dart';
import 'package:fooddeliveryapp/meals/schedule/widget.dart';

class MealTimelineModal extends StatefulWidget {
  final MealSelection _mealSelection;
  final void Function() _onMealScheduleUpdated;

  MealTimelineModal(
      {Key key,
      @required MealSelection mealSelection,
      @required Function() onMealScheduleUpdated})
      : assert(mealSelection != null),
        _mealSelection = mealSelection,
        _onMealScheduleUpdated = onMealScheduleUpdated,
        super(key: key);

  State<MealTimelineModal> createState() => _MealTimelineModalState();
}

class _MealTimelineModalState extends State<MealTimelineModal> {
  MealScheduleBloc _mealScheduleBloc;

  MealSelection get _mealSelection => widget._mealSelection;

  Function() get _onMealScheduleUpdated => widget._onMealScheduleUpdated;

  bool isButtonEnabled(MealScheduleState state) {
    return !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _mealScheduleBloc = BlocProvider.of<MealScheduleBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MealScheduleBloc, MealScheduleState>(
      listener: (context, state) {
        if (state.isSubmitted) {
          _onMealScheduleUpdated();
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              getAppSnackBar(
                'Error while loading timeline',
                Icon(Icons.error),
              ),
            );
        }
      },
      child: BlocBuilder<MealScheduleBloc, MealScheduleState>(
        builder: (context, state) {
          final schedules = state.mealsSelection?.meals
              ?.firstWhere((element) => element.date == _mealSelection.date,
                  orElse: () => null)
              ?.schedules
              ?.firstWhere(
                  (element) => element.id == _mealSelection.schedules.id);

          final mealType = state.categories.categories.firstWhere(
              (element) => element.id == _mealSelection.category.id,
              orElse: () => null);

          final meal = MealSelection(
            date: _mealSelection.date,
            schedules: schedules,
            category: mealType,
          );

          return state.isSubmitting
              ? SizedBox(
                  height: 250,
                  child: buildLoadingWidget(),
                )
              : Container(
                  padding: Dimensions.padding_16,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        padding: Dimensions.padding_bottom_16,
                        child: Text("Update Meal",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Dimensions.button_text_size,
                                color: AppColors.colorWhite)),
                      ),
                      MealSelectionCard(
                          meal: meal,
                          onAddPressed: _onAddPressed,
                          onSubtractPressed: _onRemovePressed),
                      TextButton(
                        onPressed: () => !isButtonEnabled(state)
                            ? null
                            : _onMealSubmitted(state, meal),
                        label: "Submit",
                      )
                    ],
                  ));
        },
      ),
    );
  }

  void _onAddPressed(MealSelection mealSelection) {
    _mealScheduleBloc.add(
      AddMealSchedule(selection: mealSelection),
    );
  }

  void _onRemovePressed(MealSelection mealSelection) {
    _mealScheduleBloc.add(
      RemoveMealSchedule(selection: mealSelection),
    );
  }

  void _onMealSubmitted(MealScheduleState state, MealSelection meals) {
    _mealScheduleBloc.add(
      Submitted(
          selectedDate: meals.date.toDate(),
          mealsSelection: state.mealsSelection,
          handleSubmitted: true),
    );
  }
}
