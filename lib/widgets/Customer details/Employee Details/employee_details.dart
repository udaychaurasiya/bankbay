import 'package:bank_bay/models/employee_details_model.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'Details View/employee_photo_view.dart';
import 'Details View/employee_pushback_access_view.dart';
import 'Details View/employee_pushback_docs_view.dart';
import 'Details View/employee_pushback_kyc_view.dart';
import 'Details View/employee_pushback_payroll_view.dart';
import 'Details View/pushback_about_view.dart';

RxInt employeeDetailsTab = 1.obs;
class EmployeeDetails extends StatefulWidget {
  final EmployeeDetailsData empData;
  final String pageName;
  final String? employeeId;
  const EmployeeDetails({super.key, required this.empData, required this.pageName, this.employeeId});

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => employeeDetailsTab.value!=-1 ?
        Container(
          color: AllColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: AllColors.lightBlue.withOpacity(0.1),
                height: 40.r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: ()=> employeeDetailsTab.value=1,
                      child: AnimatedContainer(
                        curve: Curves.linearToEaseOut,
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 10.r),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 3.r, color: employeeDetailsTab.value==1? AllColors.themeColor:AllColors.none))
                        ),
                        child: Text("About".tr,
                          style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color:  AllColors.themeColor),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: ()=> employeeDetailsTab.value=2,
                      child: AnimatedContainer(
                        curve: Curves.linearToEaseOut,
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 10.r),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 3.r, color: employeeDetailsTab.value==2? AllColors.themeColor:AllColors.none))
                        ),
                        child: Text("Photo".tr,
                          style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color:  AllColors.themeColor),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: ()=> employeeDetailsTab.value=3,
                      child: AnimatedContainer(
                        curve: Curves.linearToEaseOut,
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 10.r),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 3.r, color: employeeDetailsTab.value==3? AllColors.themeColor:AllColors.none))
                        ),
                        child: Text("KYC".tr,
                          style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color:  AllColors.themeColor),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: ()=> employeeDetailsTab.value=4,
                      child: AnimatedContainer(
                        curve: Curves.linearToEaseOut,
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 10.r),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 3.r, color: employeeDetailsTab.value==4? AllColors.themeColor:AllColors.none))
                        ),
                        child: Text("Docs".tr,
                          style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color: AllColors.themeColor),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: ()=> employeeDetailsTab.value=5,
                      child: AnimatedContainer(
                        curve: Curves.linearToEaseOut,
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 10.r),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 3.r, color: employeeDetailsTab.value==5?AllColors.themeColor:AllColors.none))
                        ),
                        child: Text("Payroll".tr,
                          style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color: AllColors.themeColor),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: ()=> employeeDetailsTab.value=6,
                      child: AnimatedContainer(
                        curve: Curves.linearToEaseOut,
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 10.r),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 3.r, color: employeeDetailsTab.value==6?AllColors.themeColor:AllColors.none))
                        ),
                        child: Text("Access".tr,
                          style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color: AllColors.themeColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if(employeeDetailsTab.value == 1)
                EmployeePushBackAboutViewScreen(empId: widget.employeeId, pageName: widget.pageName),
              if(employeeDetailsTab.value == 2)
                EmployeePhotoView(empId: widget.employeeId, pageName: widget.pageName),
              if(employeeDetailsTab.value == 3)
                EmployeePushBackKYCViewScreen(empId: widget.employeeId, pageName: widget.pageName),
              if(employeeDetailsTab.value == 4)
                EmployeePushBackDocsViewScreen(empData: widget.empData),
              if(employeeDetailsTab.value == 5)
                EmployeePushBackPayrollViewScreen(empData: widget.empData),
              if(employeeDetailsTab.value == 6)
                EmployeePushBackAccessViewScreen(empData: widget.empData),
              ],
          ),
        ) :
        const SizedBox(),
    );
  }
}
