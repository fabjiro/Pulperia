import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:pulperia/dio.dart';
import 'package:pulperia/snackMessage.dart';
import 'package:sizer/sizer.dart';

class PageOPTRegister extends StatelessWidget {
  const PageOPTRegister({
    Key? key,
    required this.pageController,
    required this.indexjump,
  }) : super(key: key);

  final PageController pageController;
  final int indexjump;
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  final res = await dio.post('/api/registerpulperia', data: {
                    'otpcode': text,
                  });

                  if (res.data['status'] == 200) {
                    pageController.jumpToPage(indexjump);
                  } else {
                    showSnack(context, res.data['smg']);
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
    );
  }
}
