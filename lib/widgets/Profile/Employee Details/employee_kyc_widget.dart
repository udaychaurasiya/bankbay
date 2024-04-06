
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/utils_method/uppercase_formate.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/Profile/employee_profile.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

class EmployeeKycWidget extends StatefulWidget {
  const EmployeeKycWidget({super.key});

  @override
  State<EmployeeKycWidget> createState() => _EmployeeKycWidgetState();
}

class _EmployeeKycWidgetState extends State<EmployeeKycWidget> {
  var controller = Get.find<PartnerController>();

  @override
  void initState() {
    saveDataKyc();
    super.initState();
  }
  saveDataKyc()async{
    bool status = await controller.getEmployeeDetailsNetworkApi(GetStorage().read(AppConstant.cust_id).toString());
    if(status==true){
      controller.emp_fName.text = controller.employeeDetails.value.data.basicDetails.empFname??"";
      controller.emp_PanCard.text = controller.employeeDetails.value.data.basicDetails.empPan??"";
      controller.emp_Aadhaar.text = controller.employeeDetails.value.data.basicDetails.empAadhar??"";
    }
  }

  @override
  Widget build(BuildContext context) {
  var partnerController = Get.find<PartnerController>();
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade50),
          ),
          height: Get.height-150, // Set the desired height
          child: GetBuilder<PartnerController>(
              builder: (controller) {
                return Column(
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
                                    controller: controller.emp_PanCard,
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
                                    controller: controller.emp_Aadhaar,
                                    hint: "Enter Aadhaar Number".tr,
                                    label: true,
                                    icon: true,
                                    type: TextInputType.number,
                                    length: 12,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    suffixIcon: controller.employeeDetails.value.data.basicDetails.aadhaarVerifyStatus=="yes"?Lottie.asset(Images.success, height: 25.r, width: 25.r,):Image.asset(Images.rejected,height: 20.r, width: 20.r,),
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
                    SizedBox(height: 40.r),
                    InkWell(
                      onTap: ()async{
                        bool status = await controller.employeeProfileKYCNetworkApi();
                        if (status == true) {
                          partnerController.getEmployeeDetailsNetworkApi(GetStorage().read(AppConstant.cust_id).toString());
                          employeeProfileTab.value = 3;
                        }
                      },
                      child: Container(
                        height: 40.h,
                        width: Get.width,
                        margin: EdgeInsets.symmetric(horizontal: 20.r),
                        decoration: BoxDecoration(
                            color: AllColors.darkBlue,
                            border: Border.all(color: AllColors.darkBlue)
                        ),
                        child: Center(
                          child: Text("Update",style: fontBold.copyWith(color: Colors.white),),
                        ),
                      ),
                    ),
                  ],
                );
              }
          ),
        ),
      ),
    );
  }
}
