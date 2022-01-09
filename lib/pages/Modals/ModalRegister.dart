import 'package:flutter/material.dart';

void modalRegister(BuildContext context, Widget widget) => showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      // isDismissible: false,
      builder: (context) => widget
    );
