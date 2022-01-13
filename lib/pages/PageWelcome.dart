import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:pulperia/pages/Components/btn.dart';
import 'package:sizer/sizer.dart';

class PageWelcome extends StatefulWidget {
  PageWelcome({Key? key}) : super(key: key);

  @override
  _PageWelcomeState createState() => _PageWelcomeState();
}

class _PageWelcomeState extends State<PageWelcome> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 100.w,
          height: 100.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                "assets/lottie/72342-welcome.json",
                height: 30.h,
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                width: 70.w,
                child: Text(
                  "Seleccione un perfil para su cuenta",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              CustomBtn(
                background: Colors.grey.withOpacity(.5),
                title: "Usuario",
                icono: Iconsax.user,
                ontap: () => Navigator.pushNamed(context, 'register'),
                textcolor: Theme.of(context).textTheme.bodyText1!.color!,
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomBtn(
                background: Theme.of(context).primaryColor.withOpacity(.9),
                title: "Pulperia",
                icono: Iconsax.home_2,
                ontap: () => Navigator.pushNamed(context, 'registerpulperia'),
                textcolor: Theme.of(context).textTheme.bodyText2!.color!,
              ),
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => Navigator.pushNamed(context, 'login'),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "¿ya tienes una cuenta?",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(.8),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
