// ignore_for_file: unnecessary_null_comparison

import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_dropdown.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/utils_method/uppercase_formate.dart';
import 'package:bank_bay/widgets/Employee/create_employee.dart';
import 'package:bank_bay/widgets/Employee/employee_home.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PayrollScreen extends StatefulWidget {
  const PayrollScreen({super.key});

  @override
  State<PayrollScreen> createState() => _PayrollScreenState();
}

class _PayrollScreenState extends State<PayrollScreen> {
  var controller = Get.find<LoginController>();
  final PartnerController partnerController = Get.find<PartnerController>();
  GlobalKey<FormState> formKeyPayroll = GlobalKey<FormState>(debugLabel: "_addEMPPayroll");

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AllColors.white,
      child: Column(
        children: [
          SizedBox(height: 5.r),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0.r),
            child: Form(
              key: formKeyPayroll,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.pSupervisorId,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return  "Please fill supervisor ID";
                      }
                      return null;
                    },
                    maxLines: 1,
                    minLines: 1,
                    inputFormatters: [UpperCaseTextFormatter()],
                    decoration: InputDecoration(
                      hintText: "Supervisor ID",
                      labelText: "Supervisor ID",
                      hintStyle: fontRegular.copyWith(color: AllColors.black.withOpacity(0.6), fontSize: 13.r, wordSpacing: 0, letterSpacing: 0),
                      isDense: true,
                      // filled: true,
                      // fillColor: AllColors.white.withOpacity(0.9),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 5.h),
                      labelStyle: fontRegular.copyWith(color: AllColors.black.withOpacity(0.6), fontSize: 13.r, wordSpacing: 0, letterSpacing: 0),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                      ),
                      focusedBorder:  UnderlineInputBorder(
                          borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                      ),
                      errorBorder:   UnderlineInputBorder(
                          borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                      ),
                      suffixIcon: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: (){
                          if (formKeyPayroll.currentState != null && formKeyPayroll.currentState!.validate()) {
                            partnerController.checkSupIdExistNetworkApi(controller.pSupervisorId.text);
                          }
                        },
                        child: Text("Check", style: fontBold.copyWith(color: AllColors.themeColor),),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.r),
                  UnderLineTextField(
                    controller: controller.pDesignation,
                    hint: "Designation".tr,
                    label: true,
                    type: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter designation';
                      }
                      return null;
                    },
                  ),
                  CustomUnderlineDropdownField(
                    items: ["Administration", "Audit","Finance","Legal","Quality","Training"," IT-Software","IT-Network","Operations","Sales", "Marketing"].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.pFunctionUnit.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select functional Unit';
                      }
                      return null;
                    },
                    hint: "Functional Unit",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["E1", "E2", "E3", "E4", "E5", "E6", "E7", "E8"].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.pBrand.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select brand';
                      }
                      return null;
                    },
                    hint: "Band",
                  ),
                  SizedBox(height: 15.r),
                  UnderLineTextField(
                    controller: controller.pJoiningDate,
                    hint: "Joining Date".tr,
                    label: true,
                    icon: true,
                    type: TextInputType.text,
                    length: 10,
                    onTap: () async {
                      var datePicked = await DatePicker.showSimpleDatePicker(
                        context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        dateFormat: "yyyy-MM-dd",
                        locale: DateTimePickerLocale.en_us,
                        looping: true,
                      );
                      controller.pJoiningDate.text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString()));
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter joining date';
                      }
                      return null;
                    },
                  ),
                  UnderLineTextField(
                    controller: controller.pJoiningSalary,
                    hint: "Joining Salary".tr,
                    label: true,
                    type: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    length: 20,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter joining salary';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    controller: controller.pPresentSalary,
                    hint: "Present Salary".tr,
                    label: true,
                    type: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    length: 20,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter present Salary';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.r),
                  SizedBox(height: 15.r),
                  CustomerCountView(
                    title: "Salary Revision Count".tr,
                    count: "00",
                  ),
                  SizedBox(height: 15.r),
                  CustomerCountView(
                    title: "Brand Increase Count".tr,
                    count: "00",
                  ),
                  SizedBox(height: 15.r),
                  UnderLineTextField(
                    controller: controller.pResignDate,
                    hint: "Resign Date".tr,
                    label: true,
                    icon: true,
                    type: TextInputType.text,
                    length: 10,
                    onTap: () async {
                      var datePicked = await DatePicker.showSimpleDatePicker(
                        context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        dateFormat: "yyyy-MM-dd",
                        locale: DateTimePickerLocale.en_us,
                        looping: true,
                      );
                      controller.pResignDate.text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString()));
                    },
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter resign date';
                    //   }
                    //   return null;
                    // },
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    controller: controller.pLastWorkingDate,
                    hint: "Last Working Date".tr,
                    label: true,
                    icon: true,
                    type: TextInputType.text,
                    length: 10,
                    onTap: () async {
                      var datePicked = await DatePicker.showSimpleDatePicker(
                        context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        dateFormat: "yyyy-MM-dd",
                        locale: DateTimePickerLocale.en_us,
                        looping: true,
                      );
                      controller.pLastWorkingDate.text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString()));
                    },
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter last working date';
                    //   }
                    //   return null;
                    // },
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    controller: controller.pRelivingDate,
                    hint: "Reliving Date".tr,
                    label: true,
                    icon: true,
                    type: TextInputType.text,
                    length: 10,
                    onTap: () async {
                      var datePicked = await DatePicker.showSimpleDatePicker(
                        context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        dateFormat: "yyyy-MM-dd",
                        locale: DateTimePickerLocale.en_us,
                        looping: true,
                      );
                      controller.pRelivingDate.text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString()));
                    },
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter reliving date';
                    //   }
                    //   return null;
                    // },
                  ),

                ],
              ),
            ),
          ),
          SizedBox(height: 30.r),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                title: "Save Draft".tr,
                width: 140.r,
                bgColor: AllColors.green,
                background: false,
                height: 38.r,
                radius: 0,
                onTap: ()async{
                  if (formKeyPayroll.currentState != null && formKeyPayroll.currentState!.validate()) {
                    if((controller.pSupervisorId.text!=null&&controller.pSupervisorId.text!="")&&
                        (partnerController.check_supId_exist_model.value.data.isNotEmpty&&partnerController.check_supId_exist_model.value.data[0].eid!=null)){
                      bool status = await  controller.employeePayrollNetworkApi("1",
                          partnerController.check_supId_exist_model.value.data.isNotEmpty?
                          partnerController.check_supId_exist_model.value.data[0].eid:"");
                      if (status == true) {
                        partnerController.check_supId_exist_model.value.data.clear();
                        employeeHomeTab.value=3;
                      }
                    }else{
                      BaseController().errorSnack("Please fill supervisor Id and check it !!");
                    }
                  }
                },
              ),
              CustomButton(
                title: "Next".tr,
                width: 140.r,
                background: true,
                height: 38.r,
                radius: 0,
                onTap: ()async{
                  if (formKeyPayroll.currentState != null && formKeyPayroll.currentState!.validate()) {
                    if((controller.pSupervisorId.text!=null&&controller.pSupervisorId.text!="")&&
                        (partnerController.check_supId_exist_model.value.data.isNotEmpty&&partnerController.check_supId_exist_model.value.data[0].eid!=null)){
                      bool status = await  controller.employeePayrollNetworkApi("2",
                          partnerController.check_supId_exist_model.value.data.isNotEmpty?
                          partnerController.check_supId_exist_model.value.data[0].eid:"");
                      if (status == true) {
                        partnerController.check_supId_exist_model.value.data.clear();
                        addEMPTab.value = 5;
                      }
                    }else{
                      BaseController().errorSnack("Please fill supervisor Id and check it !!");
                    }
                  }
                },
              )
            ],
          ),
          SizedBox(height: 20.r),
        ],
      ),
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

