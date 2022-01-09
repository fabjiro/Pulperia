import 'package:flutter/material.dart';
import 'package:pulperia/themeApp.dart';
import 'package:sizer/sizer.dart';

class TextfieldCustom extends StatelessWidget {
  const TextfieldCustom({
    Key? key,
    required this.title,
    required this.icono,
    required this.controller,
    this.typeKeyboar = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
  }) : super(key: key);

  final String title;
  final IconData icono;
  final TextInputType typeKeyboar;
  final TextInputAction textInputAction;
  final bool obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 13.5.h,
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                color: ThemeApp.colorTitle,
                fontSize: 16.sp,
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Container(
            width: 80.w,
            height: 7.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Center(
                child: TextField(
                  obscureText: obscureText,
                  keyboardType: typeKeyboar,
                  textInputAction: textInputAction,
                  controller: controller,
                  style: TextStyle(
                    fontSize: 15.5.sp,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Icon(
                      icono,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
