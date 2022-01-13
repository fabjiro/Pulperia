import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pulperia/models/ReactData.dart';
import 'package:pulperia/sharedpreferences.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: 100.w,
        height: 100.h,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: 25.h,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Card(
                        elevation: 1,
                        color: Theme.of(context).cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(
                            Iconsax.arrow_left_1,
                            size: 25.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/png/profile.png",
                          height: 13.h,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          context.watch<ReacData>().getuser!,
                          style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color!
                                .withOpacity(.6),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                height: 60.h,
              ),
              Divider(
                color: Colors.grey,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        title: Text(
                          "Aceptar",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                        ),
                        content: Text(
                          "Desea cerrar sesion?",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                        ),
                        actionsOverflowDirection: VerticalDirection.down,
                        actions: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                InkWell(
                                  borderRadius: BorderRadius.circular(50),
                                  onTap: () {
                                    PreferenceShared.pref!.remove('user');
                                    PreferenceShared.pref!.remove('token');
                                    context.read<ReacData>().setuser = 'null';
                                    context.read<ReacData>().settoken = 'null';
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Si",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(50),
                                  onTap: () => Navigator.pop(context),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "No",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color,
                                      ),
                                    ),
                                  ),
                                ),
                              ])
                        ],
                      ),
                    );
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cerrar sesion",
                          style: TextStyle(
                            color: Colors.red[200],
                            fontSize: 16.sp,
                          ),
                        ),
                        Icon(
                          Iconsax.logout,
                          size: 20.sp,
                          color: Colors.grey,
                        ),
                      ],
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
