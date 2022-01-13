import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pulperia/data.dart';
import 'package:pulperia/models/ProductSpecific.dart';
import 'package:pulperia/models/ReactData.dart';
import 'package:pulperia/pages/PageHome/PopularProduct.dart';
import 'package:pulperia/pages/PageHome/ProductSelector.dart';
import 'package:pulperia/pages/PageHome/welcomewidget.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

class PageHome extends StatefulWidget {
  PageHome({Key? key}) : super(key: key);

  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome>
    with AutomaticKeepAliveClientMixin {
  late ReacData reacdata;
  int currenindex = 0;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    reacdata = context.watch<ReacData>();
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          WelcomeWidget(
            reacdata: reacdata,
          ),
          ProductSelector(
            listGeneral: listProductGeneral,
            onTap: (idGeneral, indexlist) {
              setState(() {
                currenIndexData = idGeneral;
                listProductGeneral.insert(
                    0, listProductGeneral.removeAt(indexlist));
              });
            },
          ),
          SizedBox(
            height: 2.h,
          ),
          PopularProduct(
            listSpecific: randSpecific(listProductSpecific[currenIndexData]!),
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100.w,
                    margin: EdgeInsets.only(
                      left: 10,
                      top: 10,
                    ),
                    child: Text(
                      "Pulperias Cercanas",
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CircularOption extends StatelessWidget {
  const CircularOption({
    Key? key,
    required this.icon,
  }) : super(key: key);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          size: 23.5.sp,
          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6),
        ),
      ),
    );
  }
}

List<ProductSpecific> randSpecific(List<ProductSpecific> items) {
  var random = new Random();

  // Go through all elements.
  for (var i = items.length - 1; i > 0; i--) {
    // Pick a pseudorandom number according to the list length
    var n = random.nextInt(i + 1);

    var temp = items[i];
    items[i] = items[n];
    items[n] = temp;
  }

  return items;
}
