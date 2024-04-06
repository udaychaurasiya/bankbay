import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/Login/login_home.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class CreatePasswordOtp extends StatelessWidget {
  const CreatePasswordOtp({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.find<LoginController>();
    GlobalKey<FormState> formKeyPasswordOTP = GlobalKey<FormState>();
    RxString otpVerify = "".obs;
    controller.otpVerify.clear();
    final defaultPinTheme = PinTheme(
      width: 56.r,
      height: 56.r,
      margin: EdgeInsets.symmetric(horizontal: 8.r),
      textStyle: fontMedium.copyWith(
          fontSize: 25.r,
          color: AllColors.black.withOpacity(0.8),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: AllColors.blueDem, width: 2.r),
        color: AllColors.lightBlue,
      ),
    );
    final errorPinTheme = PinTheme(
      width: 56.r,
      height: 56.r,
      margin: EdgeInsets.symmetric(horizontal: 8.r),
      textStyle: fontMedium.copyWith(
          fontSize: 25.r,
          color: AllColors.black.withOpacity(0.8),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: AllColors.red, width: 2.r),
        color: AllColors.lightBlue,
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AllColors.blueDem, width: 2.r),
      color: AllColors.white,
    );
    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: AllColors.white,
        border: Border.all(color: AllColors.blueDem, width: 2.r),
      ),
    );

    return Form(
      key: formKeyPasswordOTP,
      child: Column(
        children: [
          RichText(
            text:  TextSpan(
              text: "Enter OTP ",
              style: fontRegular.copyWith(color: AllColors.white.withOpacity(0.6),fontSize: 16.r),
              children:[
                TextSpan(
                  text: "(send to ${controller.generateNumber.text}) ",
                  style: fontRegular.copyWith(color: AllColors.white.withOpacity(0.6)),
                ),
                TextSpan(
                  text: "edit",
                  style: fontSmall.copyWith(color: AllColors.white,fontSize: 12.r),
                  recognizer: TapGestureRecognizer()..onTap = () => passwordValue.value=2,
                ),
              ],
            ),
          ),
          SizedBox(height: 25.r),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Pinput(
                controller: controller.otpVerify,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                errorPinTheme: errorPinTheme,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter OTP';
                  }
                  return null;
                },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin)async {
                  otpVerify.value=pin;
                  print(pin);
                  bool status =await controller.phoneOtpVerifyNetworkAPI(pin);
                  if(status==true){
                    passwordValue.value = 4;
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 25.r),
          CustomButton(
            title: "Validate".tr,
            background: false,
            bgColor: AllColors.darkBlue,
            width: Get.width - 60.r,
            height: 45.r,
            radius: 2.r,
            onTap: () async {
              if (formKeyPasswordOTP.currentState != null && formKeyPasswordOTP.currentState!.validate()) {
                bool status = await controller.phoneOtpVerifyNetworkAPI(otpVerify.value);
                if (status == true) {
                  passwordValue.value = 4;
                }
              }
            },
          ),
          SizedBox(height: 25.r),
          InkWell(
            onTap: () => passwordValue.value = 1,
            child: Text(
              "I know my PIN",
              style: fontRegular.copyWith(color: AllColors.white.withOpacity(0.8),wordSpacing: 0,letterSpacing: 0.2),
            ),
          ),
        ],
      ),
    );
  }
}
