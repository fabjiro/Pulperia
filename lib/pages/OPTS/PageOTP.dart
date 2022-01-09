import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:pulperia/dio.dart';
import 'package:pulperia/models/ReactData.dart';
import 'package:pulperia/sharedpreferences.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

class PageOTP extends StatefulWidget {
  PageOTP({Key? key}) : super(key: key);

  @override
  _PageOTPState createState() => _PageOTPState();
}

class _PageOTPState extends State<PageOTP> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return true;
      },
      child: Scaffold(
        body: Container(
          width: 100.w,
          height: 100.h,
          child: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  LottieBuilder.asset(
                    "assets/lottie/88963-send-sms.json",
                    height: 40.h,
                  ),
                  Container(
                    width: 80.w,
                    child: Text(
                      "Ingrese el codigo que le hemos enviado",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  OtpPinField(
                    otpPinFieldInputType: OtpPinFieldInputType.none,
                    onSubmit: (text) async {
                      final result = await dio.post('/api/chechcode', data: {
                        'otpcode': text,
                      });

                      if (result.data['status'] == 200) {
                        PreferenceShared.pref!
                            .setString('token', result.data['token']);
                        PreferenceShared.pref!
                            .setString('user', result.data['user']);

                        context.read<ReacData>().user = result.data['user'];
                        context.read<ReacData>().token = result.data['token'];

                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      }
                    },

                    otpPinFieldStyle: OtpPinFieldStyle(
                      defaultFieldBorderColor: Colors.grey,
                      activeFieldBorderColor: Colors.blue,
                      defaultFieldBackgroundColor: Colors.grey.withOpacity(.1),
                      activeFieldBackgroundColor: Colors.grey.withOpacity(.1),
                    ),
                    maxLength: 4, // no of pin field
                    highlightBorder:
                        true, // want to highlight focused/active Otp_Pin_Field
                    fieldWidth: 15.w, //to give width to your Otp_Pin_Field
                    fieldHeight: 7.h, //to give height to your Otp_Pin_Field
                    autoFocus: false, //want to open keyboard or not
                    otpPinFieldDecoration:
                        OtpPinFieldDecoration.defaultPinBoxDecoration,
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
