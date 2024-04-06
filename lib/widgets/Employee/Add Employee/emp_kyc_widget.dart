import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/utils_method/uppercase_formate.dart';
import 'package:bank_bay/widgets/Employee/create_employee.dart';
import 'package:bank_bay/widgets/Employee/employee_home.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class KYCScreen extends StatelessWidget {
  const KYCScreen({super.key});

  @override
  Widget build(BuildContext context) {
  var controller = Get.find<LoginController>();
    return Container(
      color: AllColors.white,
      child: Column(
        children: [
          SizedBox(height: 20.r),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 150.r,
                margin: EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 10.r),
                padding: EdgeInsets.only(bottom: 10.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  shape: BoxShape.rectangle,
                ),
                child: DottedBorder(
                  borderType: BorderType.Rect,
                  radius: Radius.circular(5.r),
                  strokeWidth: 1.5.r,
                  dashPattern: const [4,3],
                  color: AllColors.blue.withOpacity(0.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0.r),
                        child: UnderLineTextField(
                          labelText: "Enter PAN Number".tr,
                          hint: "Enter PAN Number".tr,
                          label: true,
                          controller: controller.kPanCard,
                          type: TextInputType.text,
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                          length: 10,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter permanent account number (PAN)';
                            }else if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value)) {
                              return 'Please enter valid PAN card';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20.r),
                      Text(
                        "Request Customer OTP",
                        style: fontMedium.copyWith(
                          color: AllColors.themeColor,
                          fontSize: 12.r,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: Get.width/4-5.r,
                top: 12.r,
                child: Container(
                  padding: EdgeInsets.only(bottom: 10.r, left: 10.r, right: 10.r),
                  color: Colors.white,
                  child: Text(
                    "PAN Authentication",
                    style: fontMedium.copyWith(fontSize: 12.r),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.r),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 150.r,
                margin: EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 10.r),
                padding: EdgeInsets.only(bottom: 10.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  shape: BoxShape.rectangle,
                ),
                child: DottedBorder(
                  borderType: BorderType.Rect,
                  radius: Radius.circular(5.r),
                  strokeWidth: 1.5.r,
                  dashPattern: const [4,3],
                  color: AllColors.blue.withOpacity(0.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0.r),
                        child: UnderLineTextField(
                          controller: controller.kAadhaarCard,
                          hint: "Enter Aadhaar Number".tr,
                          label: true,
                          icon: true,
                          type: TextInputType.number,
                          length: 12,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          suffixIcon: Lottie.asset(Images.success, height: 25.r, width: 25.r,),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter aadhaar number';
                            }else if (!RegExp( r'^[2-9]{1}[0-9]{3}\\s[0-9]{4}\\s[0-9]{4}$').hasMatch(value)) {
                              return 'Please enter valid aadhaar card';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 5.r),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0.r),
                        child: UnderLineTextField(
                          // controller: controller.etPanCard,
                          hint: "Enter OTP".tr,
                          label: false,
                          icon: true,
                          type: TextInputType.text,
                          length: 10,
                          suffixIcon: Text("Verify OTP",style: fontMedium.copyWith(fontSize: 12.r,wordSpacing: 0,letterSpacing: 0),),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter OTP';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: Get.width/4-5.r,
                top: 12.r,
                child: Container(
                  padding: EdgeInsets.only(bottom: 10.r, left: 10.r, right: 10.r),
                  color: Colors.white,
                  child: Text(
                    "AADHAAR Authentication",
                    style: fontMedium.copyWith(fontSize: 12.r),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.r),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:15.0.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                CustomButton(
                  title: "Save Draft".tr,
                  width: 140.r,
                  bgColor: AllColors.green,
                  background: false,
                  height: 38.r,
                  radius: 0,
                  onTap: ()async{
                    bool status = await  controller.addEmployeeKYCNetworkApi("1");
                    if (status == true) {
                      employeeHomeTab.value=3;
                    }
                  },
                ),
                CustomButton(
                  title: "Next".tr,
                  width: 140.r,
                  // bgColor: AllColors.green,
                  background: true,
                  height: 38.r,
                  radius: 0,
                  onTap: ()async{
                    bool status = await controller.addEmployeeKYCNetworkApi("2");
                    if(status==true){
                      addEMPTab.value=3;
                    }
                  },
                )
              ],
            ),
          ),
          SizedBox(height: Get.height/4.7.r),
        ],
      ),
    );
  }
}
