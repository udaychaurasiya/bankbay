// ignore_for_file: invalid_use_of_protected_member

import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_dropdown.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'self_employee_loan_document.dart';

class SelfEmployeeLoanForm extends StatefulWidget {
  final String loanType;
  const SelfEmployeeLoanForm({super.key, required this.loanType});

  @override
  State<SelfEmployeeLoanForm> createState() => _SelfEmployeeLoanFormState();
}

var controller = Get.find<LoginController>();
  var partnerController = Get.find<PartnerController>();
class _SelfEmployeeLoanFormState extends State<SelfEmployeeLoanForm> {
  RxInt loanActive = 1.obs;
  GlobalKey<FormState> formKeyLoanRequirment = GlobalKey<FormState>(debugLabel: '_homeScreenKey2');
  GlobalKey<FormState> formKeyLoanActive = GlobalKey<FormState>(debugLabel: '_formKeyLoanActive');
  @override
  void initState() {
     controller.employeeRefreshList();
     controller.userFieldList.value.clear();
     controller.userFieldList.value.add({
       "loan_type": null,
       "tenure": null,
       "month": null,
       "loan_amt": TextEditingController(),
       "roi": TextEditingController(),
     });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("iausu  ${widget.loanType}");
    controller.employeeRefreshList();
    return Scaffold(
      appBar: AppBar(title: const Text("Self Employee Loan"),),
      body: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 20.r),
        color: AllColors.white.withOpacity(0.9),
        child: SingleChildScrollView(
          child: GetBuilder<PartnerController>(
              builder: (partnerController) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.r),
                    Text(
                      "Please tell us about your loan requirement",
                      style: fontSmall.copyWith(color: Colors.black.withOpacity(0.7)),
                    ),
                    SizedBox(height: 25.r),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("How much loan do you need?",
                        style: fontExtraSmall.copyWith(
                            color: AllColors.black.withOpacity(0.7)),),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(() => Expanded(
                          child: Slider(
                            value: controller.currentSliderValue.value.toDouble(),
                            max: 10,
                            divisions: 5,
                            label: controller.currentSliderValue.round().toString(),
                            onChanged: (double value) {
                              controller.currentSliderValue.value = value.toInt();
                            },
                          ),
                        ),),
                        Obx(() => Text(controller.currentSliderValue.value.toString(),style: fontMedium.copyWith(fontSize: 16.r, color: AllColors.black.withOpacity(0.6)),)),
                        SizedBox(width: 5.r),
                        Text("Lakh",style: fontMedium.copyWith(fontSize: 16.r, color: AllColors.black.withOpacity(0.6)),),
                      ],
                    ),
                    SizedBox(height: 10.r),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Loan Tenure?",
                        style: fontExtraSmall.copyWith(
                            color: AllColors.black.withOpacity(0.7)),),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(() => Expanded(
                          child: Slider(
                            value: controller.loanTenure.value.toDouble(),
                            max: 10,
                            divisions: 5,
                            label: controller.loanTenure.round().toString(),
                            onChanged: (double value) {
                              controller.loanTenure.value = value.toInt();
                            },
                          ),
                        ),),
                        Obx(() => Text(controller.loanTenure.value.toString(),style: fontMedium.copyWith(fontSize: 16.r, color: AllColors.black.withOpacity(0.6)),)),
                        SizedBox(width: 5.r),
                        Text("Year",style: fontMedium.copyWith(fontSize: 16.r, color: AllColors.black.withOpacity(0.6)),),
                      ],
                    ),
                    Form(
                      key: formKeyLoanRequirment,
                      child: GetBuilder<PartnerController>(
                          builder: (partnerController) {
                            return Column(
                              children: [
                                UnderLineTextField(
                                  labelText: "Name of the company".tr,
                                  hint: "Name of the company".tr,
                                  controller: controller.etCompanyName,
                                  onTap: () {},
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please fill company name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10.r),
                                CustomUnderlineDropdownField(
                                  items: controller.userCompanyType.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                      onTap: (){
                                        print("value $value");
                                        controller.companyType.value=value;
                                      },
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    print("jhkh $newValue");
                                    controller.companyType.value=newValue??"Private Limited";
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select company type';
                                    }
                                    return null;
                                  },
                                  // value: controller.companyType.value,
                                  hint: "Company type",
                                ),
                                SizedBox(height: 30.r),
                                UnderLineTextField(
                                  labelText: "Monthly Net Salary".tr,
                                  hint: "Monthly Net Salary".tr,
                                  controller: controller.etMonthlyAmount,
                                  type: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please fill monthly salary';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 25.r),
                                Row(
                                  children: [
                                    Text("Do you have any active Loan ?",
                                      style: fontSmall.copyWith(
                                          color: AllColors.black.withOpacity(0.7)),
                                    ),
                                    SizedBox(width: 15.r),
                                    Expanded(
                                      child: Obx(() {
                                        return SizedBox(
                                          height: 20.r,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    loanActive.value = 1;
                                                    controller.employeeRefreshList();
                                                    print("object ${loanActive.value}");
                                                  },
                                                  child: Container(
                                                    height: 20.r,
                                                    width: 40.r,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: loanActive.value == 1 ? AllColors
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
                                                    loanActive.value = 2;
                                                    controller.employeeRefreshList();
                                                    controller.userFieldList.value.clear();
                                                    controller.userFieldList.value.add({
                                                      "loan_type": null,
                                                      "tenure": null,
                                                      "month": null,
                                                      "loan_amt": TextEditingController(),
                                                      "roi": TextEditingController(),
                                                    });
                                                    print("object ${loanActive.value}");
                                                  },
                                                  child: Container(
                                                    width: 40.r,
                                                    height: 20.r,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: loanActive.value == 2 ? AllColors
                                                          .lightTeal : AllColors.lightGrey,
                                                    ),
                                                    child: Text("No", style: fontSmall.copyWith(
                                                        color: AllColors.black.withOpacity(0.7)),),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 25.r),
                                Obx(() => loanActive.value == 1?
                                DottedBorder(
                                  borderType: BorderType.Rect,
                                  radius: Radius.circular(5.r),
                                  strokeWidth: 1.5.r,
                                  dashPattern: const [5, 4],
                                  color: AllColors.black.withOpacity(0.5),
                                  child: GetBuilder<LoginController>(
                                    builder: (controller){
                                      return Form(
                                        key: formKeyLoanActive,
                                        child: Column(
                                          children: [
                                            ListView.builder(
                                                itemCount: controller.userFieldList.value.length,
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                padding: EdgeInsets.only(bottom: 12.r),
                                                itemBuilder: (context, index){
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
                                                                items: controller.userLoanTypeList.map((String value) {
                                                                  return DropdownMenuItem<String>(
                                                                    value: value,
                                                                    child: Text(value,overflow: TextOverflow.ellipsis,),
                                                                    onTap: (){
                                                                      print("value $value");
                                                                      controller.userFieldList.value[index]['loan_type']=value=="Personal Loan"?"PL":value==
                                                                          "Business Loan"?"BL":value=="Self-Employed Loan"?"SEL":"";
                                                                      controller.user_loan_type.value = controller.userFieldList.value[index]['loan_type'];
                                                                    },
                                                                  );
                                                                }).toList(),
                                                                onChanged: (String? newValue) {
                                                                  print("jhkh $newValue");
                                                                  controller.userFieldList.value[index]['loan_type']=newValue;
                                                                  controller.user_loan_type.value = controller.userFieldList.value[index]['loan_type'];
                                                                },
                                                                validator: (value) {
                                                                  if (value == null || value.isEmpty) {
                                                                    return 'Please select company type';
                                                                  }
                                                                  return null;
                                                                },
                                                                hint: "All Loan",
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: CustomUnderlineDropdownField(
                                                                items: controller.userLoanYearList.map((String value) {
                                                                  return DropdownMenuItem<String>(
                                                                    value: value,
                                                                    child: Text(value,overflow: TextOverflow.ellipsis,),
                                                                    onTap: (){
                                                                      print("value $value");
                                                                      controller.userFieldList.value[index]['tenure']=value;
                                                                      controller.user_tenure.value = controller.userFieldList.value[index]['tenure'];
                                                                    },
                                                                  );
                                                                }).toList(),
                                                                onChanged: (String? newValue) {
                                                                  print("jhkh $newValue");
                                                                  controller.userFieldList.value[index]['tenure']=newValue;
                                                                  controller.user_tenure.value = controller.userFieldList.value[index]['tenure'];
                                                                },
                                                                validator: (value) {
                                                                  if (value == null || value.isEmpty) {
                                                                    return 'Please select Year';
                                                                  }
                                                                  return null;
                                                                },
                                                                hint: "Year",
                                                              ),
                                                            ),
                                                            SizedBox(width: 15.r),
                                                            Expanded(
                                                              child: CustomUnderlineDropdownField(
                                                                items: controller.userLoanMonthList.map((String value) {
                                                                  return DropdownMenuItem<String>(
                                                                    value: value,
                                                                    child: Text(value,overflow: TextOverflow.ellipsis,),
                                                                    onTap: (){
                                                                      print("value $value");
                                                                      controller.userFieldList.value[index]['month']=value.toLowerCase();
                                                                      controller.user_month.value = controller.userFieldList.value[index]['month'];
                                                                    },
                                                                  );
                                                                }).toList(),
                                                                onChanged: (String? newValue) {
                                                                  print("jhkh $newValue");
                                                                  controller.userFieldList.value[index]['month']=newValue;
                                                                  controller.user_month.value = controller.userFieldList.value[index]['month'];
                                                                },
                                                                validator: (value) {
                                                                  if (value == null || value.isEmpty) {
                                                                    return 'Please select Month';
                                                                  }
                                                                  return null;
                                                                },
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
                                                                controller: controller.userFieldList.value[index]['loan_amt'],
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
                                                                controller: controller.userFieldList.value[index]['roi'],
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
                                                  if (formKeyLoanActive.currentState != null && formKeyLoanActive.currentState!.validate()) {
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
                                SizedBox(height: 30.r),
                              ],
                            );
                          }
                      ),
                    ),
                    Center(
                      child: CustomButton(
                        title: "Next".tr,
                        background: true,
                        radius: 5.r,
                        height: 35.r,
                        width: Get.width - 200,
                        onTap: () async{
                          if(loanActive.value == 1){
                            if ((formKeyLoanRequirment.currentState != null && formKeyLoanRequirment.currentState!.validate())&&
                                (formKeyLoanActive.currentState != null && formKeyLoanActive.currentState!.validate())){
                              bool status = await controller.customerLoanLeadNetworkApi("SEL", partnerController.getLeadDetails.value.data.leadId??"", widget.loanType);
                              if(status==true){
                               Get.to(()=> const SelfEmployeeLoanDocument());
                              }
                            }
                          }else{
                            if ((formKeyLoanRequirment.currentState != null && formKeyLoanRequirment.currentState!.validate())){
                              bool status = await controller.customerLoanLeadNetworkApi("SEL", partnerController.getLeadDetails.value.data.leadId??"", widget.loanType);
                              if(status==true){
                               Get.to(()=> const SelfEmployeeLoanDocument());
                              }
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 20.r),
                  ],
                );
              }
          ),
        ),
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
