import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
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
            /*style: DefaultTextStyle.of(context)
                    .style
                    .copyWith(fontStyle: FontStyle.italic),*/
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
              leading: ClipRRect(
                borderRadius: Dimensions.radius_4,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: dish.image != null
                    ? Image.network(dish.image,
                        height: 80, width: 80, fit: BoxFit.cover)
                    : Icon(Icons.error,
                        color: Theme.of(context).colorScheme.error),
              ),
              title: Text(dish.title),
              subtitle: Text(dish.description),
            );
          },
          onSuggestionSelected: (suggestion) {
            _onDishSelected(suggestion);
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
