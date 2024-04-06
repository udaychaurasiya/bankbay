import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/models/employee_details_model.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmployeePushBackPayrollViewScreen extends StatelessWidget {
  final EmployeeDetailsData empData;
  const EmployeePushBackPayrollViewScreen({super.key, required this.empData});

  @override
  Widget build(BuildContext context) {
    TextEditingController supervisorId = TextEditingController();
    TextEditingController designation = TextEditingController();
    TextEditingController functionUnit = TextEditingController();
    TextEditingController brand = TextEditingController();
    TextEditingController joiningDate = TextEditingController();
    TextEditingController joiningSalary = TextEditingController();
    TextEditingController presentSalary = TextEditingController();
    TextEditingController resignDate = TextEditingController();
    TextEditingController lastWorkingDate = TextEditingController();
    TextEditingController relivingDate = TextEditingController();
    return GetBuilder<LoginController>(
      builder: (controller){
        supervisorId.text = empData.basicDetails.supId??"";
        designation.text = empData.basicDetails.empDesignation??"";
        functionUnit.text = empData.basicDetails.empFunction??"";
        brand.text = empData.basicDetails.empBand??"";
        joiningDate.text = "${empData.basicDetails.empJoinDate??""}";
        joiningSalary.text = "${empData.basicDetails.empJoinSalary??""}";
        presentSalary.text = "${empData.basicDetails.empPresentSalary??""}";
        resignDate.text = "${empData.basicDetails.empResignDate??""}";
        lastWorkingDate.text = "${empData.basicDetails.empLastWorkingDate??""}";
        relivingDate.text = "${empData.basicDetails.empRelivingDate??""}";
        return Column(
          children: [
            SizedBox(height: 10.r),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0.r),
              child: Column(
                children: [
                  UnderLineTextField(
                    labelText: "Supervisor ID".tr,
                    hint: "Supervisor ID".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: supervisorId,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 5.r),
                  UnderLineTextField(
                    labelText: "Designation".tr,
                    hint: "Designation".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: designation,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 5.r),
                  UnderLineTextField(
                    labelText: "Functional Unit".tr,
                    hint: "Functional Unit".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: functionUnit,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 5.r),
                  UnderLineTextField(
                    labelText: "Brand".tr,
                    hint: "Brand".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: brand,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 5.r),
                  UnderLineTextField(
                    labelText: "Joining Date".tr,
                    hint: "Joining Date".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: joiningDate,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 5.r),
                  UnderLineTextField(
                    labelText: "Joining Salary".tr,
                    hint: "Joining Salary".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: joiningSalary,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 5.r),
                  UnderLineTextField(
                    labelText: "Present Salary".tr,
                    hint: "Present Salary".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: presentSalary,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 15.r),
                  CustomerCountView(
                    title: "Salary Revision Count".tr,
                    count: "${empData.basicDetails.empSalaryRevisionCount??"00"}",
                  ),
                  SizedBox(height: 15.r),
                  CustomerCountView(
                    title: "Brand Increase Count".tr,
                    count:  "${empData.basicDetails.empDesignationRevisionCount??"00"}",
                  ),
                  SizedBox(height: 15.r),
                  UnderLineTextField(
                    labelText: "Resign Date".tr,
                    hint: "Resign Date".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: resignDate,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 5.r),
                  UnderLineTextField(
                    labelText: "Last Working Date".tr,
                    hint: "Last Working Date".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: lastWorkingDate,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 5.r),
                  UnderLineTextField(
                    labelText: "Reliving Date".tr,
                    hint: "Reliving Date".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: relivingDate,
                    type: TextInputType.text,
                    length: 30,
                  ),
                ],
              ),
            ),
            // SizedBox(height: 15.r),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal:15.0.r),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       CustomButton(
            //         title: "Approve".tr,
            //         width: 120.r,
            //         bgColor: AllColors.green,
            //         background: false,
            //         height: 35.r,
            //         radius: 0,
            //         onTap: (){
            //           print("add emp type 1");
            //         },
            //       ),
            //       CustomButton(
            //         title: "Push back".tr,
            //         width: 120.r,
            //         // bgColor: AllColors.green,
            //         background: true,
            //         height: 35.r,
            //         radius: 0,
            //         onTap: ()async{
            //           print("add emp type 2");
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 20.r),
          ],
        );
      },
    );
  }
}

class CustomerCountView extends StatelessWidget {
  final String title;
  final String? count;
  final String? changes;
  const CustomerCountView({Key? key, required this.title, this.count="", this.changes=""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 10.r),
      color: AllColors.grey.withOpacity(0.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("$title : ",style: fontRegular.copyWith(fontSize: 12.r),),
          Text(count.toString(),style: fontBold.copyWith(fontSize: 12.r),),
          Text(changes.toString(),style: fontMedium.copyWith(fontSize: 12.r),),
        ],
      ),
    );
  }
}

