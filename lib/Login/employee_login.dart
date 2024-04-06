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

class EmployeeLogin extends StatelessWidget {
  final String value;
  const EmployeeLogin({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<LoginController>();
    var formKeyEMPLogin = GlobalKey<FormState>(debugLabel: "_empLogin");

    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => const DashboardScreen());
        controller.index.value = 0;
        indexValue.value = 1;
        return true;
      },
      child: Scaffold(
        backgroundColor: AllColors.themeColor,
        appBar: PreferredSize(
          preferredSize: Size(
            double.infinity,
            55.0.r,
          ),
          child: CustomAppBar(
            title: "BankBay".tr,
            leadingBool: false,
            centerTitle: true,
            back: true,
            onTab: () {
              Get.offAll(() => const DashboardScreen());
              controller.index.value = 0;
              indexValue.value = 1;
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.r),
            child: Form(
              key: formKeyEMPLogin,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 1.r,
                    width: Get.width,
                    color: AllColors.white.withOpacity(0.2),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.0.r),
                    child: Image.asset(
                      Images.logo,
                      fit: BoxFit.cover,
                      height: 90.r,
                      width: 90.r,
                    ),
                  ),
                  Text(
                    "Employee Login",
                    style: fontMedium.copyWith(
                        fontSize: 18.r,
                        color: AllColors.white.withOpacity(0.8)),
                  ),
                  SizedBox(height: 15.r),
                  CustomUnderLineTextField(
                    controller: controller.empID,
                    type: TextInputType.text,
                    hintColor: Colors.white.withOpacity(0.6),
                    prefixIconColor: Colors.white.withOpacity(0.6),
                    isPassword: false,
                    autofillHints: "number",
                    hint: "Enter Employee ID or Mobile No.",
                    prefixIcon: Icons.person_pin_outlined,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Please enter employee ID or mobile number";
                      }
                      return null;
                    },
                    length: 10,
                  ),
                  SizedBox(height: 10.r),
                  CustomUnderLineTextField(
                    controller: controller.empPassword,
                    type: TextInputType.text,
                    prefixIconColor: Colors.white.withOpacity(0.6),
                    hintColor: Colors.white.withOpacity(0.6),
                    isPassword: true,
                    hint: "Enter Password",
                    prefixIcon: Icons.lock_open_outlined,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Please enter employee Password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30.r),
                  CustomButton(
                    title: "Login".tr,
                    background: false,
                    bgColor: AllColors.darkBlue,
                    width: Get.width - 50.r,
                    height: 45.r,
                    radius: 2.r,
                    onTap: () async {
                      if (formKeyEMPLogin.currentState != null && formKeyEMPLogin.currentState!.validate()) {
                        controller.employeeLoginNetworkApi(context, value);
                        // if (status == true) {
                        //   if(value=="userHome") {
                        //     Get.offAll(() => const DashboardScreen());
                        //     controller.index.value=0;
                        //     indexValue.value=5;
                        //   }else if(value=="leadScreen") {
                        //     Get.offAll(() => const DashboardScreen());
                        //     controller.index.value=1;
                        //     screenValue.value=1;
                        //     indexValue.value=5;
                        //   }else if(value=="home") {
                        //     Get.offAll(() => const DashboardScreen());
                        //     controller.index.value=0;
                        //     indexValue.value = 1;
                        //   }
                        // }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
