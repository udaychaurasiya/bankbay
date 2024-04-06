// ignore_for_file: invalid_use_of_protected_member

import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_appbar.dart';
import 'package:bank_bay/widgets/Profile/Employee%20Details/employee_about_widget.dart';
import 'package:bank_bay/widgets/Profile/Employee%20Details/employee_docs_widget.dart';
import 'package:bank_bay/widgets/Profile/Employee%20Details/employee_kyc_widget.dart';
import 'package:bank_bay/widgets/Profile/Employee%20Details/employee_selfie.dart';
import 'package:bank_bay/widgets/dashboard.dart';
import 'package:bank_bay/widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

RxInt employeeProfileTab = 1.obs;
class EmployeeProfile extends StatefulWidget {
  const EmployeeProfile({super.key});

  @override
  State<EmployeeProfile> createState() => _EmployeeProfileState();
}

class _EmployeeProfileState extends State<EmployeeProfile> {
  var controller = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Get.offAll(()=> const DashboardScreen());
        controller.index.value=0;
        indexValue.value=1;
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.lightBlue.shade50,
        appBar: PreferredSize(
          preferredSize: Size(
            double.infinity,
            90.0.r,
          ),
          child: CustomAppBar(
            title: "Employee Profile".tr,
            leadingBool: false,
            back: true,
            onTab: () {
              Get.offAll(()=> const DashboardScreen());
              controller.index.value=0;
              indexValue.value=1;
            },
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(44.0),
              child: Container(
                height: 44.r,
                color: AllColors.lightGrey,
                padding: EdgeInsets.symmetric(horizontal: 5.r),
                child: Obx(() => employeeProfileTab.value!=-1 ?
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: ()=> employeeProfileTab.value=1,
                        child: AnimatedContainer(
                          curve: Curves.linearToEaseOut,
                          duration: const Duration(milliseconds: 200),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 20.r),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 3.r, color: employeeProfileTab.value==1?AllColors.themeColor:AllColors.none))
                          ),
                          child: Text("About".tr,
                            style:  fontBold.copyWith(fontSize: 14.r, wordSpacing: 0,letterSpacing: 0.4,color: employeeProfileTab.value==1?AllColors.black.withOpacity(0.8):AllColors.black.withOpacity(0.5)),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: ()=> employeeProfileTab.value=2,
                        child: AnimatedContainer(
                          curve: Curves.linearToEaseOut,
                          duration: const Duration(milliseconds: 200),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 20.r),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 3.r, color: employeeProfileTab.value==2?AllColors.themeColor:AllColors.none))
                          ),
                          child: Text("Photo".tr,
                            style:  fontBold.copyWith(fontSize: 14.r, wordSpacing: 0,letterSpacing: 0.4,color: employeeProfileTab.value==2?AllColors.black.withOpacity(0.8):AllColors.black.withOpacity(0.5)),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: ()=> employeeProfileTab.value=3,
                        child: AnimatedContainer(
                          curve: Curves.linearToEaseOut,
                          duration: const Duration(milliseconds: 200),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 20.r),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 3.r, color: employeeProfileTab.value==3?AllColors.themeColor:AllColors.none))
                          ),
                          child: Text("KYC".tr,
                            style:  fontBold.copyWith(fontSize: 14.r, wordSpacing: 0,letterSpacing: 0.4,color: employeeProfileTab.value==3?AllColors.black.withOpacity(0.8):AllColors.black.withOpacity(0.5)),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: ()=> employeeProfileTab.value=4,
                        child: AnimatedContainer(
                          curve: Curves.linearToEaseOut,
                          duration: const Duration(milliseconds: 200),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 20.r),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 3.r, color: employeeProfileTab.value==4?AllColors.themeColor:AllColors.none))
                          ),
                          child: Text("Docs".tr,
                            style:  fontBold.copyWith(fontSize: 14.r, wordSpacing: 0,letterSpacing: 0.4,color: employeeProfileTab.value==4?AllColors.black.withOpacity(0.8):AllColors.black.withOpacity(0.5)),
                          ),
                        ),
                      ),
                    ],
                  ) :
                  const SizedBox(),
                ),
              ),
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 15.r, vertical: 8.r),
          color: AllColors.white.withOpacity(0.9),
          child: SingleChildScrollView(
            child: Obx(() => employeeProfileTab.value!=-1 ?
              Column(
                children: [
                  SizedBox(height: 10.r),
                  if(employeeProfileTab.value==1)
                    const EmployeeAboutWidget(),
                  if(employeeProfileTab.value==2)
                    const EmployeeProfileSelfie(),
                  if(employeeProfileTab.value==3)
                    const EmployeeKycWidget(),
                  if(employeeProfileTab.value==4)
                    const EmployeeDocsWidget(),
                  SizedBox(height: 10.r),
                ],
              ) : const SizedBox(),
            ),
          ),
        ),
      ),
    );
  }

  void imageDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context,) {
        return AlertDialog(
          content: SizedBox(
            height: 180.r,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25.r, right: 25.r, top: 20.r),
                  child: Column(
                    children: [
                      Text(
                        "Choose Image",
                        style: fontBold.copyWith(fontSize: 18.r),
                      ),
                      SizedBox(height: 15.r),
                      Container(
                        height: 2.r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: AllColors.lightGrey.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.r),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        controller.empChooseImage(false,"empProfile");
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0.r),
                        child: Column(
                          children: [
                            Image.asset(
                              Images.gallery,
                              height: 50.r,
                              width: 50.r,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 5.r),
                            Text(
                              "Gallery",
                              style: fontMedium.copyWith(fontSize: 15.r),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 1.r,
                      height: 40.r,
                      color: AllColors.lightGrey.withOpacity(0.8),
                      margin: EdgeInsets.symmetric(vertical: 5.r),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        controller.empChooseImage(true,"empProfile");
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0.r),
                        child: Column(
                          children: [
                            Image.asset(
                              Images.camera,
                              height: 50.r,
                              width: 50.r,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 5.r),
                            Text(
                              "Camera",
                              style: fontMedium.copyWith(fontSize: 15.r),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
          contentPadding: EdgeInsets.zero,
          actionsOverflowButtonSpacing: 0,
          actionsOverflowDirection: VerticalDirection.down,
          actions: [
            Container(
              color: Colors.red,
            )
          ],
        );
      },
    );
  }
}