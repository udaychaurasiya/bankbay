import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_appbar.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/widgets/dashboard.dart';
import 'package:bank_bay/widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {

  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var controller = Get.find<LoginController>();
  GlobalKey<FormState> keyChangePass = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColors.themeColor,
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          55.0.r,
        ),
        child: CustomAppBar(
          title: "BankBay".tr,
          leadingBool: false,
          back: true,
          onTab: () => Get.back(),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 1.r,
              width: Get.width,
              color: AllColors.white.withOpacity(0.2),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0.r),
              child: Image.asset(
                Images.logo,
                fit: BoxFit.cover,
                height: 80.r,
                width: 80.r,
              ),
            ),
            Text(
              "Change Password",
              style: fontBold.copyWith(
                fontSize: 18.r,
                wordSpacing: 0.0,
                letterSpacing: 0.0,
                color: AllColors.white.withOpacity(0.9),
              ),
            ),
            SizedBox(height: 25.r),
            Form(
              key: keyChangePass,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal:25.r),
                    child: CustomUnderLineTextField(
                      controller: controller.oldPassword,
                      type: TextInputType.text,
                      prefixIconColor: Colors.white.withOpacity(0.6),
                      hintColor: Colors.white.withOpacity(0.6),
                      isPassword: true,
                      hint: "Enter Old Password",
                      prefixIcon: Icons.lock_open_outlined,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return "Please enter old Password";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10.r),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal:25.r),
                    child: CustomUnderLineTextField(
                      controller: controller.oldNewPassword,
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
                      controller: controller.oldConfirmPassword,
                      type: TextInputType.text,
                      prefixIconColor: Colors.white.withOpacity(0.6),
                      hintColor: Colors.white.withOpacity(0.6),
                      isPassword: true,
                      hint: "Confirm Password",
                      prefixIcon: Icons.lock_open_outlined,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return "Please enter change password";
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
                    title: "Change Password".tr,
                    background: false,
                    bgColor: AllColors.darkBlue,
                    width: Get.width - 50.r,
                    height: 45.r,
                    radius: 2.r,
                    onTap: () async {
                      if (keyChangePass.currentState != null && keyChangePass.currentState!.validate()) {
                        bool status = await controller.changePasswordNetworkApi();
                        if (status == true) {
                          controller.oldPassword.clear();
                          controller.oldNewPassword.clear();
                          controller.oldConfirmPassword.clear();
                          Get.offAll(() => const DashboardScreen());
                          controller.index.value=0;
                          indexValue.value = 1;
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

