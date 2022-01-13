import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pulperia/sharedpreferences.dart';
import 'package:sizer/sizer.dart';

void modalChageMap(BuildContext context, Function(int indexmap) callSetstate) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    builder: (BuildContext context) {
      return ContainerMapStyles(
        callSetstate: callSetstate,
      );
    },
  );
}

class ContainerMapStyles extends StatefulWidget {
  ContainerMapStyles({
    Key? key,
    required this.callSetstate,
  }) : super(key: key);
  final Function(int indexmap) callSetstate;

  @override
  _ContainerMapStylesState createState() => _ContainerMapStylesState();
}

class _ContainerMapStylesState extends State<ContainerMapStyles> {
  @override
  Widget build(BuildContext context) {
    int indexMap = PreferenceShared.pref!.getInt('indexmapstyle')!;
    return Container(
      width: 100.w,
      height: 25.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Estilos",
            style: TextStyle(
              fontSize: 18.sp,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Row(
            children: [
              StyleMap(
                urlimage: "assets/png/map white.png",
                ontap: () {
                  widget.callSetstate(0);
                  PreferenceShared.pref!.setInt('indexmapstyle', 0);
                  setState(() => {});
                },
                color: indexMap == 0
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
              ),
              SizedBox(
                width: 10,
              ),
              StyleMap(
                urlimage: "assets/png/map hybrid.png",
                ontap: () {
                  widget.callSetstate(1);
                  PreferenceShared.pref!.setInt('indexmapstyle', 1);

                  setState(() => {});
                },
                color: indexMap == 1
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StyleMap extends StatelessWidget {
  const StyleMap({
    Key? key,
    required this.urlimage,
    required this.ontap,
    required this.color,
  }) : super(key: key);
  final String urlimage;
  final Function() ontap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 3,
            color: color,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 23.w,
            height: 10.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(urlimage),
                fit: BoxFit.fill,
              ),
              boxShadow: [
                BoxShadow(
                  color: (Theme.of(context).brightness == Brightness.dark)
                      ? Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.4)
                      : Colors.transparent,
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
