import 'package:flutter/material.dart';

class Dimensions {
  static const padding_4 = EdgeInsets.all(4);
  static const padding_8 = EdgeInsets.all(8);
  static const padding_16 = EdgeInsets.all(16);
  static const padding_left_16 = EdgeInsets.fromLTRB(16, 0, 0, 0);
  static const padding_left_8 = EdgeInsets.fromLTRB(8, 0, 0, 0);
  static const padding_right_16 = EdgeInsets.fromLTRB(0, 0, 16, 0);
  static const padding_top_16 = EdgeInsets.fromLTRB(0, 16, 0, 0);
  static const padding_bottom_16 = EdgeInsets.fromLTRB(0, 0, 0, 16);
  static const padding_ltr_16 = EdgeInsets.fromLTRB(16, 16, 16, 0);
  static const padding_lr_16 = EdgeInsets.fromLTRB(16, 0, 16, 0);

  static final radius = BorderRadius.circular(10);
  static final radius_4 = BorderRadius.circular(4);
  static final topRadius = BorderRadius.only(
      topLeft: Radius.circular(15.0), topRight: Radius.circular(10.0));

  static const button_text_size = 16.0;
}
