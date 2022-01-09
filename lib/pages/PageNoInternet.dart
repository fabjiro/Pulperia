import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pulperia/themeApp.dart';
import 'package:sizer/sizer.dart';

class PageNoInternet extends StatefulWidget {
  PageNoInternet({Key? key}) : super(key: key);

  @override
  _PageNoInternetState createState() => _PageNoInternetState();
}

class _PageNoInternetState extends State<PageNoInternet> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          width: 100.w,
          height: 100.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/svg/No connection-pana.svg",
                height: 35.h,
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                "Upss!! 😞",
                style: TextStyle(
                  color: ThemeApp.colorTitle,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "La primera vez necesitamos \n una conexion a internet",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 4.h,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: ThemeApp.colorPrimario,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 2.5.h,
                    horizontal: 15.w,
                  ),
                  child: Text(
                    "Reintentar",
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: ThemeApp.colorTitleInvert,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
