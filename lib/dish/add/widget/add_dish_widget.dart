import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/common/widget/widget.dart';
import 'package:fooddeliveryapp/dish/add/bloc/bloc.dart';

class AddDishWidget extends StatefulWidget {
  State<AddDishWidget> createState() => _AddDishWidgetState();
}

class _AddDishWidgetState extends State<AddDishWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  AddDishBloc _dishBloc;

  bool get isPopulated =>
      _titleController.text.isNotEmpty &&
      _descriptionController.text.isNotEmpty;

  bool isAddButtonEnabled(AddDishState state) {
    return state.isDataValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _dishBloc = BlocProvider.of<AddDishBloc>(context);
    _titleController.addListener(_onTitleChanged);
    _descriptionController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddDishBloc, AddDishState>(
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
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<AddDishBloc, AddDishState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              child: ListView(
                children: <Widget>[
                  InkWell(
                    onTap: () => _onAddImagePressed(state.imagePath),
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: state.imagePath == null
                            ? Icon(Icons.add_a_photo, size: 50)
                            : SizedBox(
                                width: 250,
                                height: 250,
                                child: Image.file(File(state.imagePath),
                                    fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.title),
                      labelText: 'Title',
                    ),
                    keyboardType: TextInputType.text,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isTitleValid ? 'Invalid Title' : null;
                    },
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
                  TextFormField(
                      controller: _noteController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.note),
                        labelText: 'Note',
                      ),
                      keyboardType: TextInputType.text,
                      autovalidate: true,
                      autocorrect: false),
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
    _dishBloc.add(
      DishTitleChangedEvent(title: _titleController.text),
    );
  }

  void _onAddImagePressed(String path) {
    _dishBloc.add(
      DishImageAddedEvent(path: path),
    );
  }

  void _onPasswordChanged() {
    _dishBloc.add(
      DishDescriptionChangedEvent(description: _descriptionController.text),
    );
  }

  void _onFormSubmitted(AddDishState state) {
    _dishBloc.add(
      OnAddDishPressedEvent(
          title: _titleController.text,
          description: _descriptionController.text,
          note: _noteController.text,
          imagePath: state.imagePath),
    );
  }
}
