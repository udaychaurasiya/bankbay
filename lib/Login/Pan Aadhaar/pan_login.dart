
import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/Login/login_home.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/utils_method/uppercase_formate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PanLogin extends StatefulWidget {
  final String value;
  const PanLogin({super.key, required this.value});

  @override
  State<PanLogin> createState() => _PanLoginState();
}

class _PanLoginState extends State<PanLogin> {
  LoginController controller = Get.find<LoginController>();
  GlobalKey<FormState> formKeyPanLogin = GlobalKey<FormState>();
  TextEditingController userPan = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    userPan.clear();
    password.clear();
    return Form(
      key: formKeyPanLogin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal:25.r),
            child: CustomUnderLineTextField(
              controller: userPan,
              type: TextInputType.text,
              hintColor: Colors.white.withOpacity(0.6),
              prefixIconColor: Colors.white.withOpacity(0.6),
              isPassword: false,
              hint: "Enter PAN Number ",
              autofillHints: "Pan number",
              prefixIcon: Icons.credit_card,
              inputFormatters: [UpperCaseTextFormatter()],
              // validator: (value) {
              //   if (value.toString().isEmpty) {
              //     return "Please enter PAN number.";
              //   }else if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value)) {
              //     return 'Please enter valid PAN card';
              //   }
              //   return null;
              // },
              length: 10,
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
              // validator: (value) {
              //   if (value.toString().isEmpty) {
              //     return "Please enter your Password";
              //   }
              //   return null;
              // },
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
              if (formKeyPanLogin.currentState != null && formKeyPanLogin.currentState!.validate()) {
                controller.userLoginNetworkApi(
                  context, widget.value,
                  userPan.text.toString().trim(),
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
