import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/common/widget/loading.dart';
import 'package:fooddeliveryapp/common/widget/snack_bar.dart';
import 'package:fooddeliveryapp/common/widget/text_button.dart';
import 'package:fooddeliveryapp/design/colors.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/design/sizes.dart';
import 'package:fooddeliveryapp/design/text_styles.dart';
import 'package:fooddeliveryapp/meals/bloc/meal_schedule_bloc.dart';
import 'package:fooddeliveryapp/meals/bloc/meal_schedule_event.dart';
import 'package:fooddeliveryapp/meals/bloc/meal_schedule_state.dart';
import 'package:fooddeliveryapp/meals/meal_selection_card.dart';
import 'package:fooddeliveryapp/meals/model/meal.dart';
import 'package:fooddeliveryapp/meals/model/meal_selection.dart';
import 'package:fooddeliveryapp/meals/model/meal_type_configurations.dart';
import 'package:fooddeliveryapp/meals/timeline/meal_timeline_card.dart';
import 'package:fooddeliveryapp/utilities/date_utilities.dart';
import 'package:fooddeliveryapp/utilities/global_key_utilities.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:timeline_tile/timeline_tile.dart';

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

          final mealType = state.mealTypes.types.firstWhere(
              (element) => element.id == _mealSelection.configurations.id,
              orElse: () => null);

          final meal = MealSelection(
            date: _mealSelection.date,
            schedules: schedules,
            configurations: mealType,
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
