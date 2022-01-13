import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pulperia/models/ProductSpecific.dart';
import 'package:sizer/sizer.dart';

class PopularProduct extends StatelessWidget {
  PopularProduct({
    required this.listSpecific,
    Key? key,
  }) : super(key: key);

  final List<ProductSpecific> listSpecific;

  @override
  Widget build(BuildContext context) {
    int delay = 0;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 10,
            ),
            child: Text(
              "Populares",
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color!
                    .withOpacity(.75),
                fontSize: 17.5.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: 100.w,
            height: 25.h,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: 1.h,
                horizontal: 2.w,
              ),
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemCount: listSpecific.length,
              itemBuilder: (BuildContext context, int index) {
                delay += 100;
                return FadeInRight(
                  delay: Duration(milliseconds: delay),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Theme.of(context).cardColor,
                    margin: EdgeInsets.only(left: 3.w),
                    child: Container(
                      width: 45.w,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.memory(
                              base64Decode(listSpecific[index].imagen),
                              height: 12.h,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              listSpecific[index].title,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!
                                    .withOpacity(.9),
                                fontWeight: FontWeight.w500,
                                fontSize: 17.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
