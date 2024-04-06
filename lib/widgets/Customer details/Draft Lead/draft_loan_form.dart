// ignore_for_file: invalid_use_of_protected_member

import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_dropdown.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/Customer%20details/my_loan_history_details.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerDraftLoanForm extends StatefulWidget {
  final String? leadId;
  const CustomerDraftLoanForm({super.key, required this.leadId});

  @override
  State<CustomerDraftLoanForm> createState() => _CustomerDraftLoanFormState();
}

class _CustomerDraftLoanFormState extends State<CustomerDraftLoanForm> {
  GlobalKey<FormState> formKeyDraftLoan = GlobalKey<FormState>(debugLabel: '_formKeyDraftLoan');
  Rx<String?> gender = "Select Gender".obs;
  Rx<String?> marital = "Select Marital".obs;
  Rx<String?> qualification = "Select Qualification".obs;
  Rx<String?> companyType = "Select Company".obs;
  RxInt loanActiveStatus = 1.obs;
  var controller =  Get.find<PartnerController>();

  @override
  void initState() {
    controller.refreshDropdownList();
    saveLeadData();
    super.initState();
  }

  saveLeadData()async{
    bool status = await controller.getLeadDetailsNetworkApi(widget.leadId);
    if(status==true){
      controller.draftLoanName.text = controller.getLeadDetails.value.data.custName??"";
      gender.value = controller.genderList[controller.genderList.indexWhere((element2) => element2==controller.getLeadDetails.value.data.custGender.toString().capitalize)!=-1?
      controller.genderList.indexWhere((element2) => element2==controller.getLeadDetails.value.data.custGender.toString().capitalize):0];
      marital.value = controller.maritalStatusList[controller.maritalStatusList.indexWhere((element2) => element2==controller.getLeadDetails.value.data.custMaritalStatus.toString().capitalize)!=-1?
      controller.maritalStatusList.indexWhere((element2) => element2==controller.getLeadDetails.value.data.custMaritalStatus.toString().capitalize):0];
      qualification.value = controller.highestQualificationList[controller.highestQualificationList.indexWhere((element2) => element2==controller.getLeadDetails.value.data.custEducation.toString().capitalize)!=-1?
      controller.highestQualificationList.indexWhere((element2) => element2==controller.getLeadDetails.value.data.custEducation.toString().capitalize):0];
      companyType.value = controller.draftCompanyType[controller.draftCompanyType.indexWhere((element2) => element2==controller.getLeadDetails.value.data.custCompanyType.toString().capitalize)!=-1?
      controller.draftCompanyType.indexWhere((element2) => element2==controller.getLeadDetails.value.data.custCompanyType.toString().capitalize):0];
      controller.draftLoanEMail.text = controller.getLeadDetails.value.data.custEmail??"";
      controller.draftLoanPhone.text = controller.getLeadDetails.value.data.custPhone??"";
      controller.draftLoanNetSalary.text = "${controller.getLeadDetails.value.data.custNetSalary??""}";
      controller.draftLoanCompanyName.text = controller.getLeadDetails.value.data.custCompany??"";
      controller.draftLoanAmount.text = "${controller.getLeadDetails.value.data.loanAmount??""}";
      controller.draftLoanTenure.text = "${controller.getLeadDetails.value.data.loanTurner??""}";
      controller.refreshDropdownList();
      controller.custDraftLoanList.clear();
      if(controller.getLeadDetails.value.data.custActiveLoan.isNotEmpty) {
        for (var element in controller.getLeadDetails.value.data.custActiveLoan) {
          print("jshbx ${element.loanType.toString().capitalize}");
          print("sjbx ${element.tenure.toString().capitalize}");
          print("jshbshxx ${element.month.toString().capitalize}");
          controller.custDraftLoanList.value.add({
            "loan_type": controller.draftLoanTypeList[controller.draftLoanTypeList.indexWhere((element2) => element2== controller.loanTypeEncode(element.loanType.toString()))!=-1?
            controller.draftLoanTypeList.indexWhere((element2) => element2==controller.loanTypeEncode(element.loanType.toString())):0],
            "tenure": controller.draftLoanYearList[controller.draftLoanYearList.indexWhere((element2) => element2==element.tenure)!=-1?
            controller.draftLoanYearList.indexWhere((element2) => element2==element.tenure):0],
            "month": controller.draftLoanMonthList[controller.draftLoanMonthList.indexWhere((element2) => element2== extractNumber(element.month.toString()))!=-1?
            controller.draftLoanMonthList.indexWhere((element2) => element2==extractNumber(element.month.toString())):0],
            "loan_amt": TextEditingController(text: element.loanAmt),
            "roi": TextEditingController(text: element.roi),
          });
        }
      }
      else{
        controller.custDraftLoanList.value.add({
          "loan_type": null,
          "tenure": null,
          "month": null,
          "loan_amt": TextEditingController(),
          "roi": TextEditingController(),
        });
      }
    }
  }

  String? extractNumber(String input) {
    RegExp regex = RegExp(r'\b(\d+)\b');
    RegExpMatch? match = regex.firstMatch(input);

    if (match != null) {
      // Extract the matched number
      String? result = match.group(1);
      return result;
    }
    return null;
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
                        controller: controller.draftLoanName,
                        type: TextInputType.text,
                      ),
                      SizedBox(height: 2.r),
                      CustomUnderlineDropdownField(
                        items: controller.genderList.map((String value) {
                          if(value=="Select Gender"){
                            return DropdownMenuItem<String>(
                              value: value,
                              enabled: false,
                              child: Text(value.toString(),style: fontRegular.copyWith(color: AllColors.grey,wordSpacing: 0, letterSpacing: 0),),
                            );
                          }else{
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }
                        }).toList(),
                        onChanged: (String? newValue) {
                          gender.value = newValue ?? "Select Gender";
                          print("gender = ${gender.value}");
                        },
                        value: gender.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select gender';
                          }
                          return null;
                        },
                        hint: "Gender",
                      ),
                      SizedBox(height: 8.r),
                      CustomUnderlineDropdownField(
                        items: controller.maritalStatusList.map((String value) {
                          if(value=="Select Marital"){
                            return DropdownMenuItem<String>(
                              value: value,
                              enabled: false,
                              child: Text(value.toString(),style: fontRegular.copyWith(color: AllColors.grey,wordSpacing: 0, letterSpacing: 0),),
                            );
                          }else{
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }
                        }).toList(),
                        onChanged: (String? newValue) {
                          marital.value = newValue ?? "Select Marital";
                          print("marital = ${marital.value}");
                        },
                        value: marital.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select marital status';
                          }
                          return null;
                        },
                        hint: "Marital Status",
                      ),
                      SizedBox(height: 8.r),
                      CustomUnderlineDropdownField(
                        items: controller.highestQualificationList.map((String value) {
                          if(value=="Select Qualification"){
                            return DropdownMenuItem<String>(
                              value: value,
                              enabled: false,
                              child: Text(value.toString(),style: fontRegular.copyWith(color: AllColors.grey,wordSpacing: 0, letterSpacing: 0),),
                            );
                          }else{
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }
                        }).toList(),
                        onChanged: (String? newValue) {
                          qualification.value = newValue ?? "Select Qualification";
                          print("qualification = ${qualification.value}");
                        },
                        value: qualification.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please highest qualification';
                          }
                          return null;
                        },
                        hint: "Highest Qualification",
                      ),
                      SizedBox(height: 5.r),
                      UnderLineTextField(
                        labelText: "Email ID".tr,
                        hint: "Email ID".tr,
                        label: true,
                        controller: controller.draftLoanEMail,
                        type: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 5.r),
                      UnderLineTextField(
                        controller: controller.draftLoanNetSalary,
                        hint: "Net Salary".tr,
                        labelText: "Net Salary".tr,
                        label: true,
                        type: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        length: 30,
                      ),
                      SizedBox(height: 5.r),
                      UnderLineTextField(
                        controller: controller.draftLoanCompanyName,
                        hint: "Company Name".tr,
                        labelText: "Company Name".tr,
                        label: true,
                        type: TextInputType.text,
                        length: 30,
                      ),
                      SizedBox(height: 5.r),
                      UnderLineTextField(
                        controller: controller.draftLoanAmount,
                        hint: "Company Type".tr,
                        labelText: "Company Type".tr,
                        label: true,
                        type: TextInputType.text,
                        length: 30,
                      ),
                      SizedBox(height: 5.r),
                      CustomUnderlineDropdownField(
                        items: controller.draftCompanyType.map((String value) {
                          if(value=="Select Company"){
                            return DropdownMenuItem<String>(
                              value: value,
                              enabled: false,
                              child: Text(value.toString(),style: fontRegular.copyWith(color: AllColors.grey,wordSpacing: 0, letterSpacing: 0),),
                            );
                          }else{
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }
                        }).toList(),
                        onChanged: (String? newValue) {
                          print("jhkh $newValue");
                          companyType.value=newValue??"Select Company";
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select company type';
                          }
                          return null;
                        },
                        value: companyType.value,
                        hint: "Company type",
                      ),
                      SizedBox(height: 5.r),
                      UnderLineTextField(
                        controller: controller.draftLoanTenure,
                        hint: "Loan Tenure".tr,
                        labelText: "Loan Tenure".tr,
                        label: true,
                        type: TextInputType.text,
                        length: 30,
                      ),
                      SizedBox(height: 5.r),
                      UnderLineTextField(
                        controller: controller.draftLoanPhone,
                        hint: "Phone Number".tr,
                        labelText: "Phone Number".tr,
                        length: 15,
                        type: TextInputType.number,
                        icon: controller.getLeadDetails.value.data.otpPhoneStatus.toString().toLowerCase()=="yes"?true:false,
                        isRead: controller.getLeadDetails.value.data.otpPhoneStatus.toString().toLowerCase()=="yes"?true:false,
                        suffixIcon: controller.getLeadDetails.value.data.otpPhoneStatus.toString().toLowerCase()=="yes"? Padding(
                          padding: EdgeInsets.only(right: 3.0.r),
                          child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                        ) : null,
                      ),
                      SizedBox(height: 20.r),
                      Row(
                        children: [
                          Text("Do you have any active Loan ?",
                            style: fontSmall.copyWith(
                                color: AllColors.black.withOpacity(0.7)),
                          ),
                          SizedBox(width: 15.r),
                          Expanded(
                            child: Obx(() => loanActiveStatus.value != -1 ?
                              SizedBox(
                                height: 20.r,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          loanActiveStatus.value = 1;
                                          controller.refreshDropdownList();
                                          print("object ${loanActiveStatus.value}");
                                        },
                                        child: Container(
                                          height: 20.r,
                                          width: 40.r,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: loanActiveStatus.value == 1 ? AllColors
                                                .lightTeal : AllColors.lightGrey,
                                          ),
                                          child: Text("Yes", style: fontSmall.copyWith(
                                              color: AllColors.black.withOpacity(0.7)),),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          loanActiveStatus.value = 2;
                                          controller.refreshDropdownList();
                                          controller.custDraftLoanList.value.clear();
                                          controller.custDraftLoanList.value.add({
                                            "loan_type": null,
                                            "tenure": null,
                                            "month": null,
                                            "loan_amt": TextEditingController(),
                                            "roi": TextEditingController(),
                                          });
                                          print("object ${loanActiveStatus.value}");
                                        },
                                        child: Container(
                                          width: 40.r,
                                          height: 20.r,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: loanActiveStatus.value == 2 ? AllColors
                                                .lightTeal : AllColors.lightGrey,
                                          ),
                                          child: Text("No", style: fontSmall.copyWith(
                                              color: AllColors.black.withOpacity(0.7)),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ):
                              const SizedBox(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25.r),
                      Obx(() => loanActiveStatus.value == 1?
                        DottedBorder(
                          borderType: BorderType.Rect,
                          radius: Radius.circular(5.r),
                          strokeWidth: 1.5.r,
                          dashPattern: const [5, 4],
                          color: AllColors.black.withOpacity(0.5),
                          child: GetBuilder<PartnerController>(
                            builder: (controller){

                              return Form(
                                key: formKeyDraftLoan,
                                child: Column(
                                  children: [
                                    ListView.builder(
                                        itemCount: controller.custDraftLoanList.value.length,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.only(bottom: 12.r),
                                        itemBuilder: (context, index){
                                          controller.refreshDropdownList();
                                          controller.draftLoanType.value = controller.custDraftLoanList.value[index]['loan_type']??"select loan";
                                          controller.draftTenure.value = controller.custDraftLoanList.value[index]['tenure']??"select year";
                                          controller.draftMonth.value = controller.custDraftLoanList.value[index]['month']??"select month";
                                          return Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10.r,),
                                            margin: EdgeInsets.only(top: 8.r),
                                            child: Column(
                                              children: [
                                                if(index!=0)
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Expanded(
                                                        child: DottedDashedLine(
                                                          height: 1.r,
                                                          width: Get.width,
                                                          axis: Axis.horizontal,
                                                          dashColor: AllColors.red.withOpacity(0.5),
                                                        ),
                                                      ),
                                                      SizedBox(width: 5.r),
                                                      InkWell(
                                                        onTap: ()=> confirmationAlertDialog(context,index),
                                                        child: Icon(
                                                          Icons.close,
                                                          size: 18.r,
                                                          color: AllColors.red,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                if(index!=0)
                                                  SizedBox(height: 12.r),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: CustomUnderlineDropdownField(
                                                        items: controller.draftLoanTypeList.map((String value) {
                                                          if(value=="select loan"){
                                                            return DropdownMenuItem<String>(
                                                              value: value,
                                                              enabled: false,
                                                              child: Text(value.toString(),style: fontRegular.copyWith(color: AllColors.grey,wordSpacing: 0, letterSpacing: 0),),
                                                            );
                                                          }else{
                                                            return DropdownMenuItem<String>(
                                                              value: value,
                                                              child: Text(value,overflow: TextOverflow.ellipsis),
                                                            );
                                                          }
                                                        }).toList(),
                                                        onChanged: (String? newValue) {
                                                          print("jhkh $newValue");
                                                          controller.custDraftLoanList.value[index]['loan_type']=newValue??"select loan";
                                                          controller.draftLoanType.value = controller.custDraftLoanList.value[index]['loan_type'];
                                                        },
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return 'Please select company type';
                                                          }else if (value == "select loan") {
                                                            return 'Please select company type';
                                                          }else {
                                                            return null;
                                                          }
                                                        },
                                                        value: controller.draftLoanType.value,
                                                        hint: "All Loan",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: CustomUnderlineDropdownField(
                                                        items: controller.draftLoanYearList.map((String value) {
                                                          if(value=="select year"){
                                                            return DropdownMenuItem<String>(
                                                              value: value,
                                                              enabled: false,
                                                              child: Text(value.toString(),style: fontRegular.copyWith(color: AllColors.grey,wordSpacing: 0, letterSpacing: 0),),
                                                            );
                                                          }else{
                                                            return DropdownMenuItem<String>(
                                                              value: value,
                                                              child: Text(value,overflow: TextOverflow.ellipsis),
                                                            );
                                                          }
                                                        }).toList(),
                                                        onChanged: (String? newValue) {
                                                          print("jhkh $newValue");
                                                          controller.custDraftLoanList.value[index]['tenure']=newValue??"select year";
                                                          controller.draftTenure.value = controller.custDraftLoanList.value[index]['tenure'];
                                                        },
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return 'Please select Year';
                                                          }else if (value == "select year") {
                                                            return 'Please select Year';
                                                          }else {
                                                            return null;
                                                          }
                                                        },
                                                        value: controller.draftTenure.value,
                                                        hint: "Year",
                                                      ),
                                                    ),
                                                    SizedBox(width: 15.r),
                                                    Expanded(
                                                      child: CustomUnderlineDropdownField(
                                                        items: controller.draftLoanMonthList.map((String value) {
                                                          if(value=="select month"){
                                                            return DropdownMenuItem<String>(
                                                              value: value,
                                                              enabled: false,
                                                              child: Text(value.toString(),style: fontRegular.copyWith(color: AllColors.grey,wordSpacing: 0, letterSpacing: 0),),
                                                            );
                                                          }else{
                                                            return DropdownMenuItem<String>(
                                                              value: value,
                                                              child: Text(value,overflow: TextOverflow.ellipsis),
                                                            );
                                                          }
                                                        }).toList(),
                                                        onChanged: (String? newValue) {
                                                          print("jhkh $newValue");
                                                          controller.custDraftLoanList.value[index]['month']=newValue??"select month";
                                                          controller.draftMonth.value = controller.custDraftLoanList.value[index]['month'];
                                                        },
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return 'Please select Month';
                                                          }else if (value == "select month") {
                                                            return 'Please select Month';
                                                          }else {
                                                            return null;
                                                          }
                                                        },
                                                        value: controller.draftMonth.value,
                                                        hint: "Month",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10.r),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: UnderLineTextField(
                                                        controller: controller.custDraftLoanList.value[index]['loan_amt'],
                                                        labelText: "Loan amount".tr,
                                                        hint: "Loan amount".tr,
                                                        type: TextInputType.number,
                                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                        onTap: () {},
                                                        validator: (value) {
                                                          if (value.toString().isEmpty) {
                                                            return "Please enter loan amount.";
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(width: 15.r),
                                                    Expanded(
                                                      child: UnderLineTextField(
                                                        controller: controller.custDraftLoanList.value[index]['roi'],
                                                        labelText: "EMI".tr,
                                                        hint: "EMI".tr,
                                                        type: TextInputType.number,
                                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                        onTap: () {},
                                                        validator: (value) {
                                                          if (value.toString().isEmpty) {
                                                            return "Please enter EMI";
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                    Container(
                                      padding: EdgeInsets.only(right: 15.r),
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: (){
                                          if (formKeyDraftLoan.currentState != null && formKeyDraftLoan.currentState!.validate()) {
                                            controller.userAddField();
                                          }
                                        },
                                        child: Container(
                                          width: 65.r,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(vertical: 4.r),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(2.r),
                                            color: AllColors.green,
                                          ),
                                          child: Text("Add More",
                                            style: fontExtraSmall.copyWith(
                                              color: AllColors.white.withOpacity(0.9),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15.r),
                                  ],
                                ),
                              );
                            },
                          ),
                        ) :
                      const SizedBox()
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.r),
                CustomButton(
                  title: "Update".tr,
                  background: true,
                  radius: 5.r,
                  height: 35.r,
                  width: Get.width - 60,
                  onTap: () async{
                    bool status = await controller.draftLoanLeadUpdateNetworkApi(
                      controller.getLeadDetails.value.data.leadId??"",
                      gender.value.toString(),
                      marital.value.toString(),
                      qualification.value.toString(),
                      companyType.value.toString(),
                    );
                    if(status==true){
                      myLoanHistoryDetailsTab.value = 3;
                    }
                  },
                ),
                SizedBox(height: 10.r),
              ],
            );
          }
      ),
    );
  }

  confirmationAlertDialog(BuildContext context, index) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Remove", style:fontBold.copyWith(fontSize: 18.r),),
      content: Text("Are you sure?, Do you want to remove this loan?", style: fontMedium.copyWith(fontSize: 15.r, wordSpacing: 0, letterSpacing: 0.2),),
      actions: [
        CustomButton(
          title: "No".tr,
          width: 70.r,
          background: false,
          border:false,
          bgColor: null,
          onTap:  () => Get.back(),
        ),
        CustomButton(
          title: "Yes".tr,
          width: 70.r,
          border:false,
          bgColor: null,
          background: false,
          onTap: (){
            Navigator.pop(context);
            controller.userDeleteField(index);
          },
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: Future.value,
          child: alert,
        );
      },
    );
  }
}