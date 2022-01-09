import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    Key? key,
    required this.background,
    required this.title,
    required this.icono,
    required this.ontap,
    required this.textcolor,
  }) : super(key: key);

  final Color background;
  final String title;
  final IconData icono;
  final Color textcolor;
  final Function() ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => ontap(),
      child: Container(
        width: 67.w,
        height: 7.5.h,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: textcolor,
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(
              width: 3,
            ),
            Icon(
              icono,
              color: textcolor,
            ),
          ],
        ),
      ),
    );
  }
}
