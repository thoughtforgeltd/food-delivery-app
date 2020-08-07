import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fooddeliveryapp/dish/model/model.dart';
import 'package:fooddeliveryapp/repositories/dishes/dish_repository.dart';

class SelectDishDialog extends StatelessWidget {
  final void Function(Dish) _onDishSelected;

  SelectDishDialog({Key key, @required Function(Dish) onDishSelected})
      : _onDishSelected = onDishSelected,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text("Alert Dialog title"),
      content: Container(
        height: 70,
        child: TypeAheadField(
          getImmediateSuggestions: true,
          textFieldConfiguration: TextFieldConfiguration(
            autofocus: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Which dish are you looking for?'),
          ),
          suggestionsCallback: (pattern) async {
            return await RepositoryProvider.of<DishRepository>(context)
                .loadDishes()
                .then((value) => value.dishes);
          },
          itemBuilder: (context, suggestion) {
            final dish = suggestion as Dish;
            return ListTile(
              title: Text(dish.title),
            );
          },
          onSuggestionSelected: (suggestion) {
            _onDishSelected(suggestion);
            Navigator.of(context).pop();
          },
        ),
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
