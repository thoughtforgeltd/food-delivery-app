import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddeliveryapp/common/widget/widget.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/mealcategory/add/add_category_alias.dart';

import '../../meal_category.dart';

class AddCategoryWidget extends StatefulWidget {
  State<AddCategoryWidget> createState() => _AddCategoryWidgetState();
}

class _AddCategoryWidgetState extends State<AddCategoryWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  AddCategoryBloc _categoryBloc;

  bool get isPopulated =>
      _titleController.text.isNotEmpty &&
      _descriptionController.text.isNotEmpty;

  bool isAddButtonEnabled(AddCategoryState state) {
    return state.isDataValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _categoryBloc = BlocProvider.of<AddCategoryBloc>(context);
    _titleController.addListener(_onTitleChanged);
    _descriptionController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddCategoryBloc, AddCategoryState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('There is a error while adding dish'),
                    Icon(Icons.error)
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Adding Dish..'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          (ModalRoute.of(context).settings.arguments as AddCategoryArguments)
              ?.onAddPressed("");
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<AddCategoryBloc, AddCategoryState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              child: ListView(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () => _onAddImagePressed(state.imagePath),
                        child: state.imagePath == null
                            ? Icon(Icons.add_a_photo, size: 50)
                            : SvgPicture.network(state.imagePath,
                                placeholderBuilder: (context) => Container(
                                      padding: Dimensions.padding_8,
                                      child: CircularProgressIndicator(),
                                    ),
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover),
                      ),
                      Expanded(
                          child: Container(
                        margin: Dimensions.padding_left_16,
                        child: TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: 'Title',
                          ),
                          keyboardType: TextInputType.text,
                          autovalidate: true,
                          autocorrect: false,
                          validator: (_) {
                            return !state.isTitleValid ? 'Invalid Title' : null;
                          },
                        ),
                      )),
                    ],
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.description),
                      labelText: 'Description',
                    ),
                    keyboardType: TextInputType.text,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isDescriptionValid
                          ? 'Invalid Description'
                          : null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Button(
                          onPressed: isAddButtonEnabled(state)
                              ? () => _onFormSubmitted(state)
                              : null,
                          label: "Add Dish",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onTitleChanged() {
    _categoryBloc.add(
      CategoryTitleChangedEvent(title: _titleController.text),
    );
  }

  void _onAddImagePressed(String path) {
    Navigator.of(context).pushNamed('/select_meal_category_icon',
        arguments: SelectMealCategoryIconArgs(
            onIconSelected: (e) => _categoryBloc.add(
                  CategoryImageAddedEvent(path: e),
                )));
  }

  void _onPasswordChanged() {
    _categoryBloc.add(
      CategoryDescriptionChangedEvent(description: _descriptionController.text),
    );
  }

  void _onFormSubmitted(AddCategoryState state) {
    _categoryBloc.add(
      OnAddCategoryPressedEvent(
          title: _titleController.text,
          description: _descriptionController.text,
          imagePath: state.imagePath),
    );
  }
}
