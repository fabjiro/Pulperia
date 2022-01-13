import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pulperia/dio.dart';
import 'package:pulperia/models/ReactData.dart';
import 'package:pulperia/pages/PageLogin/textfielCustom.dart';
import 'package:pulperia/sharedpreferences.dart';
import 'package:pulperia/snackMessage.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

class PageLogin extends StatefulWidget {
  PageLogin({Key? key}) : super(key: key);

  @override
  _PageLoginState createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  final List<TextEditingController> _listTextfielcontroller = [
    TextEditingController(),
    TextEditingController(),
  ];
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  late ReacData _reacdata;
  @override
  void initState() {
    super.initState();
    _reacdata = context.read<ReacData>();
  }

  void onpressbtnsend() async {
    try {
      final result = await dio.post("/api/login", data: {
        'email': _listTextfielcontroller[0].text,
        'password': _listTextfielcontroller[1].text,
      });
      _btnController.reset();

      if (result.data['status'] == 200) {
        PreferenceShared.pref!.setString('token', result.data['token']);
        PreferenceShared.pref!.setString('user', result.data['user']);

        if (result.data.containsKey('pulperia')) {
          PreferenceShared.pref!
              .setString('idpulperia', result.data['pulperia']);
          _reacdata.setidpulperia = result.data['pulperia'];
        }
        _reacdata.setuser = result.data['user'];
        _reacdata.settoken = result.data['token'];

        Navigator.of(context).popUntil((route) => route.isFirst);
      } else {
        showSnack(context, result.data['smg']);
      }
    } catch (e) {
      _btnController.error();
      print(e);
      Future.delayed(Duration(seconds: 4))
          .then((value) => _btnController.reset());
      showSnack(context, 'tenemos problemas');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColorPrymari = Theme.of(context).textTheme.bodyText1!.color;
    final textColorSecundary = Theme.of(context).textTheme.bodyText2!.color;

    return Scaffold(
      body: Container(
        width: 100.w,
        height: 100.h,
        child: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
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
                          "Acceder",
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
                      "Accede con una de las siguientes opciones.",
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
                    color: textColorPrymari,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextfieldCustom(
                  title: "Email",
                  icono: Icons.email_outlined,
                  typeKeyboar: TextInputType.emailAddress,
                  controller: _listTextfielcontroller[0],
                ),
                TextfieldCustom(
                  title: "Contrasena",
                  obscureText: true,
                  icono: Icons.lock_open_outlined,
                  typeKeyboar: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  controller: _listTextfielcontroller[1],
                ),
                SizedBox(
                  height: 6.h,
                ),
                // btn registrar
                RoundedLoadingButton(
                  color: Theme.of(context).primaryColor.withOpacity(.9),
                  width: 60.w,
                  height: 8.h,
                  borderRadius: 12,
                  elevation: 0,
                  child: Text(
                    'Acceder',
                    style: TextStyle(
                      color: textColorSecundary,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  controller: _btnController,
                  onPressed: () => onpressbtnsend(),
                ),
                SizedBox(
                  height: 2.h,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'login'),
                  child: Text(
                    "¿no tienes una cuenta?",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: textColorPrymari,
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
