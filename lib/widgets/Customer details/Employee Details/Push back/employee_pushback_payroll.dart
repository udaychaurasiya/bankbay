// ignore_for_file: unnecessary_null_comparison

import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_dropdown.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/utils_method/uppercase_formate.dart';
import 'package:bank_bay/widgets/Customer%20details/Employee%20Details/employee_push_back_details.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker_widget/flutter_holo_date_picker_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EmployeePushBackPayrollScreen extends StatefulWidget {
  final String empId;
  const EmployeePushBackPayrollScreen({super.key, required this.empId});

  @override
  State<EmployeePushBackPayrollScreen> createState() => _EmployeePushBackPayrollScreenState();
}
var controller = Get.find<LoginController>();
var partnerController = Get.find<PartnerController>();

class _EmployeePushBackPayrollScreenState extends State<EmployeePushBackPayrollScreen> {
  var formKeyEMPPushbackCheckSupId = GlobalKey<FormState>(debugLabel: "_formKeyPushbackCheckSupId");
  TextEditingController empPushbackSupervisorId = TextEditingController();

  @override
  void initState() {
    saveData();
    controller.employeeRefreshList();
    super.initState();
  }

  saveData()async{
    bool status = await partnerController.getEmployeeDetailsNetworkApi(widget.empId.toString());
    if(status==true){
    controller.unit.value = controller.functionUnitList[controller.functionUnitList.indexWhere((element2) => element2==partnerController.employeeDetails.value.data.basicDetails.empFunction)!=-1?
    controller.functionUnitList.indexWhere((element2) => element2==partnerController.employeeDetails.value.data.basicDetails.empFunction):0];
    controller.brand.value = controller.bandList[controller.bandList.indexWhere((element2) => element2==partnerController.employeeDetails.value.data.basicDetails.empBand)!=-1?
    controller.bandList.indexWhere((element2) => element2==partnerController.employeeDetails.value.data.basicDetails.empBand):0];
    empPushbackSupervisorId.text = partnerController.employeeDetails.value.data.basicDetails.supId??"";
    controller.empPushbackDesignation.text = partnerController.employeeDetails.value.data.basicDetails.empDesignation??"";
    controller.empPushbackJoiningSalary.text = "${partnerController.employeeDetails.value.data.basicDetails.empJoinSalary??""}";
    controller.empPushbackPresentSalary.text = "${partnerController.employeeDetails.value.data.basicDetails.empPresentSalary??""}";
    controller.empPushbackJoiningDate.text = partnerController.employeeDetails.value.data.basicDetails.empJoinDate??"";
    controller.empPushbackResignDate.text = partnerController.employeeDetails.value.data.basicDetails.empRelivingDate??"";
    controller.empPushbackLastWorkingDate.text = partnerController.employeeDetails.value.data.basicDetails.empLastWorkingDate??"";
    controller.empPushbackRelivingDate.text = partnerController.employeeDetails.value.data.basicDetails.empRelivingDate??"";

    }
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller){
        controller.employeeRefreshList();
        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0.r),
              child: Column(
                children: [
                  SizedBox(height: 10.r),
                  Form(
                    key: formKeyEMPPushbackCheckSupId,
                    child: TextFormField(
                      controller: empPushbackSupervisorId,
                      keyboardType: TextInputType.text,
                      // maxLength: 10,
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
                            if (formKeyEMPPushbackCheckSupId.currentState != null && formKeyEMPPushbackCheckSupId.currentState!.validate()) {
                              partnerController.checkSupIdExistNetworkApi(empPushbackSupervisorId.text);
                            }
                          },
                          child: Text("Check", style: fontBold.copyWith(color: AllColors.themeColor),),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.r),
                  UnderLineTextField(
                    controller: controller.empPushbackDesignation,
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
                    items: controller.functionUnitList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.unit.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                      controller.unit.value=newValue??"No";
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select functional Unit';
                      }
                      return null;
                    },
                    value: controller.unit.value,
                    hint: "Functional Unit",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: controller.bandList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          controller.brand.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                      controller.brand.value=newValue??"E1";
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select brand';
                      }
                      return null;
                    },
                    value: controller.brand.value,
                    hint: "Brand",
                  ),
                  SizedBox(height: 15.r),
                  UnderLineTextField(
                    controller: controller.empPushbackJoiningDate,
                    hint: "Joining Date".tr,
                    label: true,
                    icon: true,
                    isRead: true,
                    type: TextInputType.text,
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
                      controller.empPushbackJoiningDate.text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString()));
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter joining date';
                      }
                      return null;
                    },
                  ),
                  UnderLineTextField(
                    controller: controller.empPushbackJoiningSalary,
                    hint: "Joining Salary".tr,
                    label: true,
                    type: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter joining salary';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    controller: controller.empPushbackPresentSalary,
                    hint: "Present Salary".tr,
                    label: true,
                    type: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                    count: "${partnerController.employeeDetails.value.data.basicDetails.empSalaryRevisionCount??0}",
                  ),
                  SizedBox(height: 15.r),
                  CustomerCountView(
                    title: "Brand Increase Count".tr,
                    count: "${partnerController.employeeDetails.value.data.basicDetails.empDesignationRevisionCount??0}",
                  ),
                  SizedBox(height: 15.r),
                  UnderLineTextField(
                    controller: controller.empPushbackResignDate,
                    hint: "Resign Date".tr,
                    label: true,
                    icon: true,
                    isRead: true,
                    type: TextInputType.text,
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
                      controller.empPushbackResignDate.text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString()));
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
                    controller: controller.empPushbackLastWorkingDate,
                    hint: "Last Working Date".tr,
                    label: true,
                    icon: true,
                    isRead: true,
                    type: TextInputType.text,
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
                      controller.empPushbackLastWorkingDate.text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString()));
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
                    controller: controller.empPushbackRelivingDate,
                    hint: "Reliving Date".tr,
                    label: true,
                    icon: true,
                    isRead: true,
                    type: TextInputType.text,
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
                      controller.empPushbackRelivingDate.text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString()));
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
            SizedBox(height: 30.r),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.r),
              child: CustomButton(
                title: "Next".tr,
                background: false,
                bgColor: AllColors.green,
                height: 38.r,
                radius: 0,
                onTap: ()async{
                  if((empPushbackSupervisorId.text!=null&&empPushbackSupervisorId.text!="")&&
                  (partnerController.check_supId_exist_model.value.data.isNotEmpty&&partnerController.check_supId_exist_model.value.data[0].eid!=null)){
                    bool status = await  controller.employeePushBackPayrollUpdateNetworkApi(
                        partnerController.employeeDetails.value.data.basicDetails.id,
                        partnerController.check_supId_exist_model.value.data.isNotEmpty?
                        partnerController.check_supId_exist_model.value.data[0].eid:""
                    );
                    if (status == true) {
                      partnerController.check_supId_exist_model.value.data.clear();
                      employeePushBackDetailsTab.value = 5;
                    }
                  }else{
                    BaseController().errorSnack("Please fill supervisor Id and check it !!");
                  }
                },
              ),
            ),
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

