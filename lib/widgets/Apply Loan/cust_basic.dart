import 'package:bank_bay/controllers/create_customer_controller.dart';
import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_dropdown.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker_widget/flutter_holo_date_picker_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'create_customer.dart';

class CustBasicScreen extends StatefulWidget {
  const CustBasicScreen({super.key});

  @override
  State<CustBasicScreen> createState() => _CustBasicScreenState();
}

class _CustBasicScreenState extends State<CustBasicScreen> {
  var controller = Get.find<LoginController>();
  var createCustController = Get.put(CreateCustomerController());
  GlobalKey<FormState> formKeyLoan = GlobalKey<FormState>(debugLabel: '_homeScreenKey');

  @override
  Widget build(BuildContext context) {
    createCustController.refreshDropdownList();
    return SingleChildScrollView(
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 10.r),
        color: AllColors.white.withOpacity(0.9),
        child: Form(
          key: formKeyLoan,
          child: Column(
            children: [
              UnderLineTextField(
                labelText: "First Name".tr,
                hint: "Enter first name".tr,
                label: true,
                controller: createCustController.custFName,
                onTap: () {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter first name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 5.r),
              UnderLineTextField(
                labelText: "Last Name".tr,
                hint: "Enter last name".tr,
                label: true,
                controller: createCustController.custLName,
                onTap: () {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter  last name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 5.r),
              UnderLineTextField(
                labelText: "Date of Birth".tr,
                hint: "Date of Birth".tr,
                label: true,
                controller: createCustController.custDob,
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
                  createCustController.custDob.text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString()));
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter date of birth';
                  }
                  return null;
                },
              ),
              SizedBox(height: 5.r),
              CustomUnderlineDropdownField(
                items: createCustController.genderList.map((String value) {
                  if(value=="Select Gender"){
                    return DropdownMenuItem<String>(
                      value: value,
                      enabled: false,
                      child: Text(value.toString(),style: fontRegular.copyWith(color: AllColors.grey,wordSpacing: 0, letterSpacing: 0),),
                      onTap: (){
                        print("value $value");
                        createCustController.custGender.value=value;
                      },
                    );
                  }else{
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                      onTap: (){
                        print("value $value");
                        createCustController.custGender.value=value;
                      },
                    );
                  }
                }).toList(),
                onChanged: (String? newValue) {
                  createCustController.custGender.value = newValue ?? "Select Gender";
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select gender';
                  }else if (value == "Select Gender") {
                    return 'Please select gender';
                  }
                  return null;
                },
                value: createCustController.custGender.value,
                hint: "Gender",
              ),
              SizedBox(height: 5.r),
              CustomUnderlineDropdownField(
                items: createCustController.maritalStatusList.map((String value) {
                  if(value=="Select Marital"){
                    return DropdownMenuItem<String>(
                      value: value,
                      enabled: false,
                      child: Text(value.toString(),style: fontRegular.copyWith(color: AllColors.grey,wordSpacing: 0, letterSpacing: 0),),
                      onTap: (){
                        print("value $value");
                        createCustController.custMaritalStatus.value = value;
                      },
                    );
                  }else{
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                      onTap: () {
                        print("value $value");
                        createCustController.custMaritalStatus.value = value;
                      },
                    );
                  }
                }).toList(),
                value: createCustController.custMaritalStatus.value, // Set the default value here
                onChanged: (String? newValue) {
                  createCustController.custMaritalStatus.value = newValue ?? "Select Marital Status";
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select marital status';
                  }else if (value == "Select Marital") {
                    return 'Please select marital status';
                  }
                  return null;
                },
                hint: "Marital Status",
              ),
              SizedBox(height: 5.r),
              CustomUnderlineDropdownField(
                items: createCustController.qualificationList.map((String value) {
                  if(value=="Select Qualification"){
                    return DropdownMenuItem<String>(
                      value: value,
                      enabled: false,
                      child: Text(value.toString(),style: fontRegular.copyWith(color: AllColors.grey,wordSpacing: 0, letterSpacing: 0),),
                      onTap: (){
                        print("value $value");
                        createCustController.custQualification.value=value;
                      },
                    );
                  }else{
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                      onTap: () {
                        print("value $value");
                        createCustController.custQualification.value=value;
                      },
                    );
                  }
                }).toList(),
                onChanged:  (String? newValue) {
                  createCustController.custQualification.value = newValue ?? "Select Qualification";
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please highest qualification';
                  }else if (value == "Select Qualification") {
                    return 'Please highest qualification';
                  }
                  return null;
                },
                value: createCustController.custQualification.value,
                hint:  "Highest Qualification",
              ),
              SizedBox(height: 10.r),
              UnderLineTextField(
                labelText: "Pin code".tr,
                hint: "Enter Pin code".tr,
                label: true,
                controller: createCustController.custPinCode,
                type: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                length: 6,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter pin code';
                  }
                  return null;
                },
              ),
              SizedBox(height: 5.r),
              UnderLineTextField(
                labelText: "Address".tr,
                hint: "Enter Address".tr,
                label: true,
                controller: createCustController.custAddress,
                type: TextInputType.text,
                length: 30,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
              ),
              UnderLineTextField(
                labelText: "Email ID".tr,
                hint: "Email ID".tr,
                label: true,
                controller: createCustController.custEmail,
                type: TextInputType.emailAddress,
                onTap: () {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email ID';
                  }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                    return 'Please enter valid email ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 5.r),
              UnderLineTextField(
                hint: "Phone Number".tr,
                controller: createCustController.custPhone,
                onTap: () {},
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }else if (value.length != 10){
                    return 'Mobile Number must be of 10 digit';
                  }
                  return null;
                },
                isRead: false,
                length: 10,
                type: TextInputType.number,
                preIcon: true,
                prefixIcon: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "+91  |  ",
                    style: fontRegular.copyWith(
                      wordSpacing: 0.2,
                      letterSpacing: 0.8,
                      fontSize: 18.r,
                      color: AllColors.black.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.r),
              CustomButton(
                title: "Next".tr,
                background: true,
                radius: 5.r,
                height: 35.r,
                width: Get.width - 200,
                onTap: () async {
                  if (formKeyLoan.currentState != null && formKeyLoan.currentState!.validate()) {
                    bool status = await createCustController.registrationNetworkApi();
                    if(status==true){
                      createCustIndex.value=2;
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
