import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SearchBtn extends StatelessWidget {
  const SearchBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      child: Container(
        width: 100.w,
        child: Center(
          child: Container(
            width: 77.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: (Theme.of(context).brightness == Brightness.dark)
                      ? Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.5)
                      : Colors.transparent,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 1.0,
                ),
              ],
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 1.9.h,
                ),
                child: Text(
                  "¿que buscaremos?",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
