import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailsLoanDetail extends StatefulWidget {
  final String? leadId;
  const DetailsLoanDetail({super.key, required this.leadId});

  @override
  State<DetailsLoanDetail> createState() => _DetailsLoanDetailState();
}

class _DetailsLoanDetailState extends State<DetailsLoanDetail> {
  var controller = Get.find<PartnerController>();
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
    saveDetails();
    super.initState();
  }
  saveDetails()async{
    bool status = await controller.getLeadDetailsNetworkApi(widget.leadId);
    if(status==true){
      name.text = controller.getLeadDetails.value.data.custName??"";
      gender.text = controller.getLeadDetails.value.data.custGender??"";
      marital.text = controller.getLeadDetails.value.data.custMaritalStatus??"";
      highQualification.text = controller.getLeadDetails.value.data.custEducation??"";
      eMail.text = controller.getLeadDetails.value.data.custEmail??"";
      panNumber.text = controller.getLeadDetails.value.data.custPan??"";
      phone.text = controller.getLeadDetails.value.data.custPhone??"";
      netSalary.text = "${controller.getLeadDetails.value.data.custNetSalary??""}";
      companyName.text = controller.getLeadDetails.value.data.custCompany??"";
      loanAmount.text = "${controller.getLeadDetails.value.data.loanAmount??""}";
      loanTenure.text = "${controller.getLeadDetails.value.data.loanTurner??""}";
    }
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
                      label: true,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 3.0.r),
                        child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                      ),
                      icon: true,
                      isRead: true,
                      controller: panNumber,
                      type: TextInputType.text,
                      length: 30,
                    ),
                    SizedBox(height: 5.r),
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
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                      preIcon: true,
                    ),

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
