import 'package:iconsax/iconsax.dart';
import 'package:pulperia/LoadAnimation.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

void modalViewPulperia(BuildContext context, Map<String, String> data,
    Map<String, dynamic> datapulperia) async {
  showSlidingBottomSheet(context, builder: (context) {
    final textPrymariColor = Theme.of(context).textTheme.bodyText1!.color;

    return SlidingSheetDialog(
      elevation: 8,
      cornerRadius: 12,
      snapSpec: const SnapSpec(
        snap: true,
        snappings: [0.365, .65],
        positioning: SnapPositioning.relativeToAvailableSpace,
      ),
      headerBuilder: (context, state) {
        return Container(
          width: 100.w,
          height: 7.h,
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.red.withOpacity(.15),
                blurRadius: 5.0,
                offset: Offset(0.0, 0.5),
              )
            ],
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Card(
              color: Theme.of(context).scaffoldBackgroundColor,
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
                            color: Theme.of(context).primaryColor,
                            fontSize: 19.sp,
                          ),
                        ),
                        TextSpan(
                          text: ' (${data['duration']})',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: textPrymariColor,
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
                      color: textPrymariColor,
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
          width: 100.w,
          height: 50.h,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Card(
            color: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    datapulperia['title'],
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: textPrymariColor,
                    ),
                  ),
                ),
                LoadAnimation(
                  child: Container(
                    width: 100.w,
                    height: 15.h,
                    child: ListView.separated(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 10,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 30.w,
                          height: 15.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.withOpacity(.5),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
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
                color: Colors.red.withOpacity(.15),
                blurRadius: 5.0,
                offset: Offset(0.0, 0.5),
              )
            ],
            color: Theme.of(context).scaffoldBackgroundColor,
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
