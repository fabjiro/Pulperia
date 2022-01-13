import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pulperia/dio.dart';
import 'package:pulperia/pages/PageLogin/textfielCustom.dart';
import 'package:pulperia/snackMessage.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

class PageRegisterUser extends StatefulWidget {
  PageRegisterUser({Key? key}) : super(key: key);

  @override
  _PageRegisterUserState createState() => _PageRegisterUserState();
}

class _PageRegisterUserState extends State<PageRegisterUser> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final List<TextEditingController> _listTextfielcontroller = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  @override
  Widget build(BuildContext context) {
    final textColorPrymari = Theme.of(context).textTheme.bodyText1!.color;
    final textColorSecundary = Theme.of(context).textTheme.bodyText2!.color;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 100.h,
          width: 100.w,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                // top
                Container(
                  width: 100.w,
                  height: 10.h,
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.arrow_left_2,
                          size: 25.sp,
                          color: textColorPrymari!.withOpacity(.8),
                        ),
                        Text(
                          "Registrar",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                            color: textColorPrymari.withOpacity(.8),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // mensaje
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.w,
                    vertical: 0.5.h,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Regístrese con una de las siguientes opciones.",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: textColorPrymari.withOpacity(.8),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                // btn google
                Container(
                  width: 100.w,
                  height: 10.h,
                  child: Center(
                    child: Container(
                      width: 85.w,
                      height: 7.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[300],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/svg/Google.svg",
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                // mensaje
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "-- ó --",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: textColorPrymari.withOpacity(.8),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextfieldCustom(
                  title: "Usuario",
                  icono: Iconsax.user,
                  controller: _listTextfielcontroller[0],
                ),
                TextfieldCustom(
                  title: "Email",
                  icono: Icons.email_outlined,
                  typeKeyboar: TextInputType.emailAddress,
                  controller: _listTextfielcontroller[1],
                ),
                TextfieldCustom(
                  title: "Contrasena",
                  obscureText: true,
                  icono: Icons.lock_open_outlined,
                  typeKeyboar: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  controller: _listTextfielcontroller[2],
                ),
                SizedBox(
                  height: 3.h,
                ),
                // btn registrar
                RoundedLoadingButton(
                  color: Theme.of(context).primaryColor.withOpacity(.8),
                  width: 60.w,
                  height: 8.h,
                  borderRadius: 12,
                  elevation: 0,
                  child: Text(
                    'Registrar',
                    style: TextStyle(
                      color: textColorSecundary,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  controller: _btnController,
                  onPressed: () async {
                    try {
                      final result = await dio.post("/api/register", data: {
                        'user': _listTextfielcontroller[0].text,
                        'email': _listTextfielcontroller[1].text,
                        'password': _listTextfielcontroller[2].text,
                      });
                      _btnController.reset();

                      if (result.data['status'] == 200) {
                        Navigator.pushNamed(context, 'opt');
                      } else {
                        showSnack(context, result.data['smg']);
                      }
                    } catch (e) {
                      _btnController.error();
                      Future.delayed(Duration(seconds: 4))
                          .then((value) => _btnController.reset());
                      showSnack(context, 'tenemos problemas');
                    }
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
                // mensaje ya tienes una cuenta
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => Navigator.pushNamed(context, 'login'),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "¿ya tienes una cuenta?",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: textColorPrymari.withOpacity(.9),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
