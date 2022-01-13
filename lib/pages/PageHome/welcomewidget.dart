import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pulperia/models/ReactData.dart';
import 'package:pulperia/pages/Components/dialogregister.dart';
import 'package:pulperia/pages/Modals/ModalRegister.dart';
import 'package:pulperia/pages/PageHome.dart';
import 'package:pulperia/sharedpreferences.dart';
import 'package:sizer/sizer.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    Key? key,
    required this.reacdata,
  }) : super(key: key);

  final ReacData reacdata;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 3.5.w,
      ),
      width: 100.w,
      height: 10.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60.w,
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: "Hola, ",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                    children: [
                      TextSpan(
                        text: reacdata.gettoken == 'null'
                            ? "Bienvenido"
                            : reacdata.getuser,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.sp,
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                "busquemoslo!!",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(.6)),
              ),
            ],
          ),
          Row(
            children: [
              CircularOption(
                icon: Iconsax.message1,
              ),
              SizedBox(
                width: 1.w,
              ),
              GestureDetector(
                onTap: () {
                  // Scaffold.of(context).openDrawer();
                  if (PreferenceShared.pref!.getString('token') == null) {
                    modalRegister(
                      context,
                      DialogRegister(
                        ontap: () => Navigator.pushNamed(context, 'welcome'),
                      ),
                    );
                  } else {
                    Scaffold.of(context).openDrawer();
                  }
                },
                child: CircularOption(
                  icon: Iconsax.user,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
