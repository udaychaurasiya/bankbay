
import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/Login/login_home.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPassword extends StatefulWidget {
  final String value;
  const LoginPassword({super.key, required this.value});

  @override
  State<LoginPassword> createState() => _LoginPasswordState();
}

class _LoginPasswordState extends State<LoginPassword> {
  LoginController controller = Get.find<LoginController>();
  GlobalKey<FormState> formKeyAadhaarLogin = GlobalKey<FormState>();
  TextEditingController userAadhaar = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    userAadhaar.clear();
    password.clear();
    return Form(
      key: formKeyAadhaarLogin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal:25.r),
            child: CustomUnderLineTextField(
              controller: userAadhaar,
              type: TextInputType.number,
              hintColor: Colors.white.withOpacity(0.6),
              prefixIconColor: Colors.white.withOpacity(0.6),
              isPassword: false,
              hint: "Enter Aadhaar Number",
              autofillHints: "Aadhaar number",
              prefixIcon: Icons.credit_card_rounded,
              // prefixIcon: Icons.phone_android_outlined,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value.toString().isEmpty) {
                  return "Please enter aadhaar number";
                }
                return null;
              },
              length: 12,
            ),
          ),
          SizedBox(height: 10.r),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:25.r),
            child: CustomUnderLineTextField(
              controller: password,
              type: TextInputType.text,
              prefixIconColor: Colors.white.withOpacity(0.6),
              hintColor: Colors.white.withOpacity(0.6),
              isPassword: true,
              autofillHints: "password",
              hint: "Enter Password",
              prefixIcon: Icons.lock_open_outlined,
              validator: (value) {
                if (value.toString().isEmpty) {
                  return "Please enter your Password";
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 15.r),
          CustomButton(
            title: "Login".tr,
            background: false,
            bgColor: AllColors.darkBlue,
            width: Get.width - 50.r,
            height: 45.r,
            radius: 2.r,
            onTap: () async {
              if (formKeyAadhaarLogin.currentState != null && formKeyAadhaarLogin.currentState!.validate()) {
                controller.userLoginNetworkApi(
                  context, widget.value,
                  userAadhaar.text.toString().trim(),
                  password.text.toString().trim(),
                );
              }
            },
          ),
          SizedBox(height: 25.r),
          InkWell(
            onTap: (){
              controller.generateNumber.clear();
              passwordValue.value=2;
            },
            child: Text(
              "Forgot Password?",
              style: fontRegular.copyWith(color: AllColors.white.withOpacity(0.8),wordSpacing: 0,letterSpacing: 0.2),
            ),
          ),
        ],
      ),
    );
  }
}
