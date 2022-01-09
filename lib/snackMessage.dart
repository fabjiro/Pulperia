import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

void showSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(
      message,
      style: TextStyle(
        fontSize: 14.sp,
      ),
    )),
  );
}
