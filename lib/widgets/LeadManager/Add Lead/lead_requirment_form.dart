// ignore_for_file: invalid_use_of_protected_member
import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_dropdown.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/widgets/LeadManager/add_lead.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

LoginController controller = Get.find<LoginController>();
class LeadRequirmentForm extends StatelessWidget {
  const LeadRequirmentForm({super.key});

  @override
  Widget build(BuildContext context) {
    RxInt loanActive = 1.obs;
    GlobalKey<FormState> formKeyAddLeadLoan = GlobalKey<FormState>(debugLabel: "_formKeyAddLeadLoan");
    controller.leadFieldList.value.clear();
    controller.leadFieldList.value.add({
      "loan_type": null,
      "tenure": null,
      "month": null,
      "loan_amt": TextEditingController(),
      "roi": TextEditingController(),
    });
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 20.r),
      color: AllColors.white.withOpacity(0.9),
      child: Form(
        key: formKeyAddLeadLoan,
        child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Please tell us about your loan requirment",
                style: fontSmall.copyWith(color: Colors.black.withOpacity(0.7)),
              ),
              SizedBox(height: 25.r),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "How much loan do you need?",
                  style: fontExtraSmall.copyWith(
                      color: AllColors.black.withOpacity(0.7)),
                ),
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
                    ),
                  ),
                  Obx(() => Text(
                    controller.currentSliderValue.value.toString(),
                    style: fontMedium.copyWith(
                        fontSize: 16.r,
                        color: AllColors.black.withOpacity(0.6)),
                  )),
                  SizedBox(width: 5.r),
                  Text(
                    "Year",
                    style: fontMedium.copyWith(
                        fontSize: 16.r, color: AllColors.black.withOpacity(0.6)),
                  ),
                ],
              ),
              SizedBox(height: 10.r),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Loan Tenure?",
                  style: fontExtraSmall.copyWith(
                      color: AllColors.black.withOpacity(0.7)),
                ),
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
                    ),
                  ),
                  Obx(() => Text(
                    controller.loanTenure.value.toString(),
                    style: fontMedium.copyWith(
                        fontSize: 16.r,
                        color: AllColors.black.withOpacity(0.6)),
                  )),
                  SizedBox(width: 5.r),
                  Text(
                    "Lakh",
                    style: fontMedium.copyWith(
                        fontSize: 16.r, color: AllColors.black.withOpacity(0.6)),
                  ),
                ],
              ),
              UnderLineTextField(
                labelText: "Name of the company".tr,
                hint: "Name of the company".tr,
                controller: controller.leadCompanyName,
                onTap: () {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill company name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 5.r),
              CustomUnderlineDropdownField(
                items: [
                  "Private Limited",
                  "Public Limited",
                  "Proprietorship",
                  "Partnership",
                  "LLP",
                  "OPC",
                  "NGO",
                  "Government"
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                    onTap: () {
                      print("value $value");
                      controller.companyType.value = value.toLowerCase();
                    },
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  print("jhkh $newValue");
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select company type';
                  }
                  return null;
                },
                hint: "Company type",
              ),
              SizedBox(height: 8.r),
              UnderLineTextField(
                labelText: "Monthly Net Salary".tr,
                hint: "Monthly Net Salary".tr,
                controller: controller.leadMonthlyAmount,
                type: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onTap: () {},
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
                  Text(
                    "Do you have any active Loan ?",
                    style: fontSmall.copyWith(
                        color: AllColors.black.withOpacity(0.7)),
                  ),
                  SizedBox(width: 8.r),
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
                                  print("object ${loanActive.value}");
                                },
                                child: Container(
                                  height: 20.r,
                                  width: 40.r,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: loanActive.value == 1
                                        ? AllColors.lightTeal
                                        : AllColors.lightGrey,
                                  ),
                                  child: Text(
                                    "Yes",
                                    style: fontSmall.copyWith(
                                        color: AllColors.black.withOpacity(0.7)),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  loanActive.value = 2;
                                  controller.leadFieldList.value.clear();
                                  controller.leadFieldList.value.add({
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
                                    color: loanActive.value == 2
                                        ? AllColors.lightTeal
                                        : AllColors.lightGrey,
                                  ),
                                  child: Text(
                                    "No",
                                    style: fontSmall.copyWith(
                                        color: AllColors.black.withOpacity(0.7)),
                                  ),
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
              if (loanActive.value == 1) SizedBox(height: 25.r),
              if (loanActive.value == 1)
                DottedBorder(
                  borderType: BorderType.Rect,
                  radius: Radius.circular(5.r),
                  strokeWidth: 1.5.r,
                  dashPattern: const [5, 4],
                  color: AllColors.black.withOpacity(0.5),
                  child: GetBuilder<LoginController>(
                    builder: (controller) {
                      return Column(
                        children: [
                          ListView.builder(
                              itemCount: controller.leadFieldList.value.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(bottom: 12.r),
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.r,
                                  ),
                                  margin: EdgeInsets.only(top: 8.r),
                                  child: Column(
                                    children: [
                                      if (index != 0)
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: DottedDashedLine(
                                                height: 1.r,
                                                width: Get.width,
                                                axis: Axis.horizontal,
                                                dashColor: AllColors.red
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            SizedBox(width: 5.r),
                                            InkWell(
                                              onTap: () => confirmationAlertDialog(context, index),
                                              child: Icon(
                                                Icons.close,
                                                size: 18.r,
                                                color: AllColors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (index != 0) SizedBox(height: 12.r),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomUnderlineDropdownField(
                                              items: controller.leadLoanTypeList.map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                  ),
                                                  onTap: () {
                                                    print("value $value");
                                                    controller.leadFieldList.value[index]
                                                    ['loan_type'] = value ==
                                                        "Personal Loan"
                                                        ? "PL"
                                                        : value == "Business Loan"
                                                        ? "BL"
                                                        : value ==
                                                        "Self-Employed Loan"
                                                        ? "SEL"
                                                        : "";
                                                    controller.loan_type2.value = controller.leadFieldList.value[index]['loan_type'];
                                                    print(controller.loan_type2.value);
                                                    controller.leadFieldList.refresh();
                                                  },
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                print("jhkh $newValue");
                                              },
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please select company type';
                                                }
                                                return null;
                                              },
                                              hint: "All Loan",
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.r),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomUnderlineDropdownField(
                                              items: controller.leadLoanYearList.map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                  ),
                                                  onTap: () {
                                                    print("value $value");
                                                    controller.leadFieldList
                                                        .value[index]
                                                    ['tenure'] = value;
                                                    controller.tenure2.value =
                                                    controller.leadFieldList
                                                        .value[index]
                                                    ['tenure'];
                                                    controller.leadFieldList
                                                        .refresh();
                                                  },
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                print("jhkh $newValue");
                                              },
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
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
                                              items: controller.leadLoanMonthList.map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                  ),
                                                  onTap: () {
                                                    print("value $value");
                                                    controller.leadFieldList.value[index]['month'] = "$value month";
                                                    controller.month2.value = controller.leadFieldList.value[index]['month'];
                                                    controller.leadFieldList.refresh();
                                                  },
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                print("jhkh $newValue");
                                              },
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
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
                                              controller: controller.leadFieldList.value[index]['loan_amt'],
                                              labelText: "Loan amount".tr,
                                              hint: "Loan amount".tr,
                                              type: TextInputType.number,
                                              inputFormatters: [
                                                FilteringTextInputFormatter.digitsOnly
                                              ],
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
                                              controller: controller.leadFieldList.value[index]['roi'],
                                              labelText: "EMI".tr,
                                              hint: "EMI".tr,
                                              type: TextInputType.number,
                                              inputFormatters: [
                                                FilteringTextInputFormatter.digitsOnly
                                              ],
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
                              onTap: () {
                                if (formKeyAddLeadLoan.currentState != null && formKeyAddLeadLoan.currentState!.validate()) {
                                  controller.addField();
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
                                child: Text(
                                  "Add More",
                                  style: fontExtraSmall.copyWith(
                                    color: AllColors.white.withOpacity(0.9),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.r),
                        ],
                      );
                    },
                  ),
                ),
              SizedBox(height: 30.r),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LightCustomButton(
                    title: "Back".tr,
                    height: 28.r,
                    width: 100.r,
                    background: false,
                    onTap: () {
                      screenValue.value = 1;
                      controller.leadFieldList.clear();
                      controller.leadFieldList.value.add({
                        "loan_type": null,
                        "tenure": null,
                        "month": null,
                        "loan_amt": TextEditingController(),
                        "roi": TextEditingController(),
                      });
                    },
                  ),
                  SizedBox(width: 15.r),
                  CustomButton(
                    title: "Next".tr,
                    background: true,
                    radius: 30.r,
                    height: 30.r,
                    width: Get.width - 240,
                    onTap: () async {
                      if (formKeyAddLeadLoan.currentState != null && formKeyAddLeadLoan.currentState!.validate()) {
                        bool status = await controller.leadCustomerLoanLeadNetworkApi(loanValue.value == 1
                            ? "PL"
                            : loanValue.value == 2
                            ? "BL"
                            : loanValue.value == 1
                            ? "SEL"
                            : "PL");
                        if (status == true) {
                          screenValue.value = 6;
                        }
                      }
                    },
                  ),
                ],
              ),
            ],
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
            controller.deleteField(index);
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
