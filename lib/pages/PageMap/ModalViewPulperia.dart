import 'package:iconsax/iconsax.dart';
import 'package:pulperia/themeApp.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

void modalViewPulperia(BuildContext context, Map<String, String> data,
    Map<String, dynamic> datapulperia) async {
  showSlidingBottomSheet(context, builder: (context) {
    return SlidingSheetDialog(
      elevation: 8,
      cornerRadius: 12,
      snapSpec: const SnapSpec(
        snap: true,
        snappings: [0.35, .65],
        positioning: SnapPositioning.relativeToAvailableSpace,
      ),
      headerBuilder: (context, state) {
        return Container(
          width: 100.w,
          height: 7.h,
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: ThemeApp.colorTitle.withOpacity(.15),
                blurRadius: 5.0,
                offset: Offset(0.0, 0.5),
              )
            ],
            color: ThemeApp.colorFondo,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Card(
              color: ThemeApp.colorFondo,
              elevation: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: data['distance'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ThemeApp.colorPrimario,
                            fontSize: 19.sp,
                          ),
                        ),
                        TextSpan(
                          text: ' (${data['duration']})',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: ThemeApp.colorTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: .2.h),
                  Text(
                    data['addres']!,
                    style: TextStyle(
                      fontSize: 8.sp,
                      color: ThemeApp.colorTitle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      builder: (context, state) {
        return Container(
          height: 100.h,
          width: 100.w,
          color: ThemeApp.colorFondo,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: Card(
              color: ThemeApp.colorFondo,
              elevation: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    datapulperia['title'],
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: ThemeApp.colorTitle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      footerBuilder: (context, state) {
        return Container(
          width: 100.w,
          height: 8.h,
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: ThemeApp.colorTitle.withOpacity(.15),
                blurRadius: 5.0,
                offset: Offset(0.0, 0.5),
              )
            ],
            color: ThemeApp.colorFondo,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(
                        Iconsax.send_1,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        "Iniciar",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  });
}
