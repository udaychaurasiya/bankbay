import 'package:bank_bay/Login/login_home.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class LoginPin extends StatelessWidget {
  final String value;
  const LoginPin({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKeyPinLogin = GlobalKey<FormState>();
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

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 32.0.r),
          alignment: Alignment.centerLeft,
          child: Text(
            "Enter your PIN",
            style: fontMedium.copyWith(
                fontSize: 16.r, color: AllColors.white),
          ),
        ),
        SizedBox(height: 25.r),
        Form(
          key: formKeyPinLogin,
          child: Pinput(
            // controller: controller.userPin,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            submittedPinTheme: submittedPinTheme,
            errorPinTheme: errorPinTheme,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your PIN';
              }
              return null;
            },
            pinputAutovalidateMode:
            PinputAutovalidateMode.onSubmit,
            showCursor: true,
            onCompleted: (pin) async{
              // bool status = await controller.userPinLoginNetworkApi();
              // if (status == true) {
              //   Get.to(()=> const DashboardScreen());
              //   indexValue.value=5;
              // }
            },
          ),
        ),
        SizedBox(height: 25.r),
        CustomButton(
          title: "Login".tr,
          background: false,
          bgColor: AllColors.darkBlue,
          width: Get.width - 60.r,
          height: 45.r,
          radius: 2.r,
          onTap: () async {
            if (formKeyPinLogin.currentState != null && formKeyPinLogin.currentState!.validate()) {
              // controller.userPinLoginNetworkApi(context, value);
            }
          },
        ),
        SizedBox(height: 25.r),
        InkWell(
          onTap: () {
            pinValue.value = 2;
            print(pinValue.value);
          },
          child: Text(
            "Create PIN",
            style: fontRegular.copyWith(
                color: AllColors.white.withOpacity(0.8),
                wordSpacing: 0,
                letterSpacing: 0.2),
          ),
        ),
      ],
    );
  }
}
