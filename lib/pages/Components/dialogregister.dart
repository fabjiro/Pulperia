import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pulperia/themeApp.dart';
import 'package:sizer/sizer.dart';

class DialogRegister extends StatelessWidget {
  const DialogRegister({Key? key, required this.ontap}) : super(key: key);

  final Function() ontap;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 28.h,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 24.h,
              decoration: BoxDecoration(
                color: ThemeApp.colorFondo,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: BoxDecoration(
                color: ThemeApp.colorFondo,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeApp.colorPrimario,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Iconsax.user,
                      color: ThemeApp.colorTitleInvert,
                      size: 33.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: 80.w,
                  child: Text(
                    "Para continuar debes tener una cuenta!! \nEs facil y rapido creala",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeApp.colorTitle,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.1.h,
                ),
                InkWell(
                  onTap: () => ontap(),
                  child: Container(
                    width: 55.w,
                    height: 6.5.h,
                    decoration: BoxDecoration(
                      color: ThemeApp.colorPrimario,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Crear cuenta",
                        style: TextStyle(
                          color: ThemeApp.colorTitleInvert,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
