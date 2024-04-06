// ignore_for_file: invalid_use_of_protected_member

import 'package:bank_bay/models/get_lead_details_model.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyLoanHistoryDetailsLoanDetail extends StatefulWidget {
  final LeadDetailsData leadDetailsData;
  const MyLoanHistoryDetailsLoanDetail({super.key, required this.leadDetailsData});

  @override
  State<MyLoanHistoryDetailsLoanDetail> createState() => _MyLoanHistoryDetailsLoanDetailState();
}

class _MyLoanHistoryDetailsLoanDetailState extends State<MyLoanHistoryDetailsLoanDetail> {
    var controller =  Get.find<PartnerController>();
    TextEditingController name = TextEditingController();
    TextEditingController gender = TextEditingController();
    TextEditingController marital = TextEditingController();
    TextEditingController highQualification = TextEditingController();
    TextEditingController eMail = TextEditingController();
    TextEditingController panNumber = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController netSalary = TextEditingController();
    TextEditingController companyName = TextEditingController();
    TextEditingController loanAmount = TextEditingController();
    TextEditingController loanTenure = TextEditingController();
    @override
    void initState() {
      controller.loanHistoryFieldList.clear();
      if(widget.leadDetailsData.custActiveLoan.isNotEmpty) {
        for (var element in widget.leadDetailsData.custActiveLoan) {
          controller.loanHistoryFieldList.add({
            "loan_type": TextEditingController(text: element.loanType),
            "tenure": TextEditingController(text: element.tenure),
            "month": TextEditingController(text: element.month),
            "loan_amt": TextEditingController(text: element.loanAmt),
            "roi": TextEditingController(text: element.roi),
          });
        }
      }
      name.text = widget.leadDetailsData.custName??"";
      gender.text = widget.leadDetailsData.custGender??"";
      marital.text = widget.leadDetailsData.custMaritalStatus??"";
      highQualification.text = widget.leadDetailsData.custEducation??"";
      eMail.text = widget.leadDetailsData.custEmail??"";
      panNumber.text = widget.leadDetailsData.custPan??"";
      phone.text = widget.leadDetailsData.custPhone??"";
      netSalary.text = widget.leadDetailsData.nextFollowupTime??"";
      companyName.text = widget.leadDetailsData.custCompany??"";
      loanAmount.text = "${widget.leadDetailsData.loanAmount??""}";
      loanTenure.text = "${widget.leadDetailsData.loanTurner??""}";
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0.r),
      child: GetBuilder<PartnerController>(
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.r),
                child: Column(
                  children: [
                    UnderLineTextField(
                      labelText: "Name".tr,
                      hint: "Name".tr,
                      label: true,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 3.0.r),
                        child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                      ),
                      icon: true,
                      isRead: true,
                      controller: name,
                      type: TextInputType.text,
                    ),
                    UnderLineTextField(
                      labelText: "Gender".tr,
                      hint: "Gender".tr,
                      controller: gender,
                      label: true,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 3.0.r),
                        child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                      ),
                      icon: true,
                      type: TextInputType.text,
                      length: 20,
                      isRead: true,
                    ),
                    SizedBox(height: 5.r),
                    UnderLineTextField(
                      labelText: "Marital".tr,
                      hint: "Marital".tr,
                      controller: marital,
                      label: true,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 3.0.r),
                        child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                      ),
                      icon: true,
                      type: TextInputType.text,
                      length: 20,
                      isRead: true,
                    ),
                    SizedBox(height: 5.r),
                    UnderLineTextField(
                      labelText: "Please highest qualification".tr,
                      hint: "Please highest qualification".tr,
                      controller: highQualification,
                      label: true,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 3.0.r),
                        child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                      ),
                      icon: true,
                      type: TextInputType.text,
                      length: 20,
                      isRead: true,
                    ),
                    SizedBox(height: 5.r),
                    UnderLineTextField(
                      labelText: "Email ID".tr,
                      hint: "Email ID".tr,
                      label: true,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 3.0.r),
                        child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                      ),
                      icon: true,
                      isRead: true,
                      controller: eMail,
                      type: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 5.r),
                    UnderLineTextField(
                      labelText: "Pan Number".tr,
                      hint: "Pan Number".tr,
                      controller: panNumber,
                      label: true,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 3.0.r),
                        child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                      ),
                      icon: true,
                      isRead: true,
                      type: TextInputType.text,
                      length: 30,
                    ),
                    SizedBox(height: 5.r),
                    UnderLineTextField(
                      controller: netSalary,
                      hint: "Net Salary".tr,
                      labelText: "Net Salary".tr,
                      label: true,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 3.0.r),
                        child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                      ),
                      icon: true,
                      isRead: true,
                      type: TextInputType.text,
                      length: 30,
                    ),
                    SizedBox(height: 5.r),
                    UnderLineTextField(
                      controller: companyName,
                      hint: "Company Name".tr,
                      labelText: "Company Name".tr,
                      label: true,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 3.0.r),
                        child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                      ),
                      icon: true,
                      isRead: true,
                      type: TextInputType.text,
                      length: 30,
                    ),
                    SizedBox(height: 5.r),
                    UnderLineTextField(
                      controller: loanAmount,
                      hint: "Loan Amount".tr,
                      labelText: "Loan Amount".tr,
                      label: true,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 3.0.r),
                        child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                      ),
                      icon: true,
                      isRead: true,
                      type: TextInputType.text,
                      length: 30,
                    ),
                    SizedBox(height: 5.r),
                    UnderLineTextField(
                      controller: loanTenure,
                      hint: "Loan Tenure".tr,
                      labelText: "Loan Tenure".tr,
                      label: true,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 3.0.r),
                        child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                      ),
                      icon: true,
                      isRead: true,
                      type: TextInputType.text,
                      length: 30,
                    ),
                    SizedBox(height: 5.r),
                    UnderLineTextField(
                      controller: phone,
                      hint: "Phone Number".tr,
                      labelText: "Phone Number".tr,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 3.0.r),
                        child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                      ),
                      icon: true,
                      isRead: true,
                      length: 15,
                      type: TextInputType.number,
                      preIcon: false,
                    ),
                    SizedBox(height: 5.r),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.r),
                      color: AllColors.lightTeal.withOpacity(0.4),
                      width: Get.width,
                      alignment: Alignment.center,
                      child: Text("Active Loan Details", style: fontMedium.copyWith()),
                    ),
                    SizedBox(height: 5.r),
                    GetBuilder<PartnerController>(
                      builder: (controller){
                        return ListView.builder(
                            itemCount: controller.loanHistoryFieldList.value.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(bottom: 10.r),
                            itemBuilder: (context, index){
                              return Container(
                                margin: EdgeInsets.only(top: 10.r),
                                child: Column(
                                  children: [
                                    if(index!=0)
                                      DottedDashedLine(
                                        height: 1.r,
                                        width: Get.width,
                                        axis: Axis.horizontal,
                                        dashColor: AllColors.red.withOpacity(0.5),
                                      ),
                                    if(index!=0)
                                      SizedBox(height: 12.r),
                                    UnderLineTextField(
                                      controller: controller.loanHistoryFieldList.value[index]['loan_type'],
                                      hint: "All Loan".tr,
                                      labelText: "All Loan".tr,
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.only(right: 3.0.r),
                                        child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                                      ),
                                      icon: true,
                                      isRead: true,
                                      length: 30,
                                      type: TextInputType.text,
                                      preIcon: false,
                                    ),
                                    SizedBox(height: 5.r),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: UnderLineTextField(
                                            controller: controller.loanHistoryFieldList.value[index]['tenure'],
                                            hint: "Year".tr,
                                            labelText: "Year".tr,
                                            suffixIcon: Padding(
                                              padding: EdgeInsets.only(right: 3.0.r),
                                              child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                                            ),
                                            icon: true,
                                            isRead: true,
                                            length: 30,
                                            type: TextInputType.text,
                                            preIcon: false,
                                          ),
                                        ),
                                        SizedBox(width: 15.r),
                                        Expanded(
                                          child: UnderLineTextField(
                                            controller: controller.loanHistoryFieldList.value[index]['month'],
                                            hint: "Month".tr,
                                            labelText: "Month".tr,
                                            suffixIcon: Padding(
                                              padding: EdgeInsets.only(right: 3.0.r),
                                              child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                                            ),
                                            icon: true,
                                            isRead: true,
                                            length: 30,
                                            type: TextInputType.text,
                                            preIcon: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.r),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: UnderLineTextField(
                                            controller: controller.loanHistoryFieldList.value[index]['loan_amt'],
                                            hint: "Loan amount".tr,
                                            labelText: "Loan amount".tr,
                                            suffixIcon: Padding(
                                              padding: EdgeInsets.only(right: 3.0.r),
                                              child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                                            ),
                                            icon: true,
                                            isRead: true,
                                            length: 30,
                                            type: TextInputType.text,
                                            preIcon: false,
                                          ),
                                        ),
                                        SizedBox(width: 15.r),
                                        Expanded(
                                          child: UnderLineTextField(
                                            controller: controller.loanHistoryFieldList.value[index]['roi'],
                                            hint: "EMI".tr,
                                            labelText: "EMI".tr,
                                            suffixIcon: Padding(
                                              padding: EdgeInsets.only(right: 3.0.r),
                                              child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                                            ),
                                            icon: true,
                                            isRead: true,
                                            length: 30,
                                            type: TextInputType.text,
                                            preIcon: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.r),
            ],
          );
        }
      ),
    );
  }
}