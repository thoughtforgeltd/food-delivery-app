import 'package:flutter/material.dart';

SnackBar getAppSnackBar(String message, Icon icon){
  return SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Flexible(child: Text(message)), icon],
    ),
  );
}
