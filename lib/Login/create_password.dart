import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/widgets/Apply%20Loan/create_customer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  var controller = Get.find<LoginController>();
  GlobalKey<FormState> keyCreatePass = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 45.r, top: 80.r),
            child: Text(
              "Create Password",
              style: fontBold.copyWith(
                fontSize: 18.r,
                wordSpacing: 0.0,
                letterSpacing: 0.0,
              ),
            ),
          ),
          Form(
            key: keyCreatePass,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:25.r),
                  child: CustomUnderLineTextField(
                    controller: controller.createPassword,
                    type: TextInputType.text,
                    // prefixIconColor: Colors.white.withOpacity(0.6),
                    // hintColor: Colors.white.withOpacity(0.6),
                    isPassword: true,
                    hint: "Enter Password",
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
                SizedBox(height: 18.r),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:25.r),
                  child: CustomUnderLineTextField(
                    controller: controller.rePassword,
                    type: TextInputType.text,
                    // prefixIconColor: Colors.white.withOpacity(0.6),
                    // hintColor: Colors.white.withOpacity(0.6),
                    isPassword: true,
                    hint: "Confirm Password",
                    prefixIcon: Icons.lock_open_outlined,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Please enter confirm password";
                      }
                      if (controller.oldNewPassword.text!=controller.oldConfirmPassword.text) {
                        return "The password confirmation doesn't match";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 40.r),
                CustomButton(
                  title: "Create Password".tr,
                  background: false,
                  bgColor: AllColors.darkBlue,
                  width: Get.width - 50.r,
                  height: 45.r,
                  radius: 2.r,
                  onTap: () async {
                    if (keyCreatePass.currentState != null && keyCreatePass.currentState!.validate()) {
                      bool status = await controller.newPasswordNetworkApi();
                      if (status == true) {
                        controller.otpVerify.clear();
                        controller.createPassword.clear();
                        controller.rePassword.clear();
                        createCustIndex.value=4;
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

