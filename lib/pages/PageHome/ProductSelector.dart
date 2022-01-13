import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pulperia/models/ProductGenral.dart';
import 'package:sizer/sizer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ProductSelector extends StatelessWidget {
  ProductSelector({
    Key? key,
    required this.listGeneral,
    required this.onTap(String idGeneral, int indexlist),
  }) : super(key: key);

  final List<ProductGeneral> listGeneral;
  final Function(String, int) onTap;
  final itemCotrolle = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 1.5.h,
      ),
      width: 100.w,
      height: 10.h,
      child: ScrollablePositionedList.builder(
        itemScrollController: itemCotrolle,
        padding: EdgeInsets.symmetric(
          vertical: .70.h,
          horizontal: 1.w,
        ),
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: listGeneral.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return FadeInRight(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.w,
                ),
                margin: EdgeInsets.only(left: 1.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: Theme.of(context).primaryColor,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    listGeneral[index].title,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText2!.color,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return FadeInRight(
              child: GestureDetector(
                onTap: () {
                  onTap(listGeneral[index].idm, index);
                  itemCotrolle.scrollTo(
                      index: 0, duration: Duration(milliseconds: 450));
                },
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 32.w,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.w,
                  ),
                  margin: EdgeInsets.only(left: 1.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: listGeneral[index].title,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
