import 'package:bank_bay/Login/login_home.dart';
import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateNewPassword extends StatelessWidget {
  const CreateNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.find<LoginController>();
    GlobalKey<FormState> formKeyPasswordCreate = GlobalKey<FormState>();
    controller.createPassword.clear();
    controller.rePassword.clear();
    return Form(
      key: formKeyPasswordCreate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal:25.r),
            child: CustomUnderLineTextField(
              controller: controller.createPassword,
              type: TextInputType.text,
              prefixIconColor: Colors.white.withOpacity(0.6),
              hintColor: Colors.white.withOpacity(0.6),
              isPassword: true,
              hint: "Enter New Password",
              prefixIcon: Icons.lock_open_outlined,
              validator: (passwordValue) {
                RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                var passNonNullValue=passwordValue??"";
                if(passNonNullValue.isEmpty){
                  return ("Password is required");
                }
                else if(passNonNullValue.length<6){
                  return ("Password Must be more than 5 characters");
                }
                else if(!regex.hasMatch(passNonNullValue)){
                  return ("Password should contain upper,lower,digit and Special character ");
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 10.r),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:25.r),
            child: CustomUnderLineTextField(
              controller: controller.rePassword,
              type: TextInputType.text,
              prefixIconColor: Colors.white.withOpacity(0.6),
              hintColor: Colors.white.withOpacity(0.6),
              isPassword: true,
              hint: "Confirm Password",
              prefixIcon: Icons.lock_open_outlined,
              length: 15,
              validator: (value) {
                if (value.toString().isEmpty) {
                  return "Please enter confirm password";
                }
                if (controller.createPassword.text!=controller.rePassword.text) {
                  return "The password confirmation doesn't match";
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
              if (formKeyPasswordCreate.currentState != null && formKeyPasswordCreate.currentState!.validate()) {
                bool status = await controller.newPasswordNetworkApi();
                if (status == true) {
                  controller.otpVerify.clear();
                  controller.createPassword.clear();
                  controller.rePassword.clear();
                  passwordValue.value = 1;
                }
              }
            },
          ),
          SizedBox(height: 25.r),
          InkWell(
            onTap: ()=> passwordValue.value=1,
            child: Text(
              "I remember my Password",
              style: fontRegular.copyWith(color: AllColors.white.withOpacity(0.8),wordSpacing: 0,letterSpacing: 0.2),
            ),
          ),
        ],
      ),
    );
  }
}
