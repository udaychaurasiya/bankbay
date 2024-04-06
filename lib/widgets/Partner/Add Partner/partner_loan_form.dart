import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_dropdown.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/widgets/Partner/create_partner.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PartnerLoanForm extends StatefulWidget {
  const PartnerLoanForm({super.key});

  @override
  State<PartnerLoanForm> createState() => _PartnerLoanFormState();
}

class _PartnerLoanFormState extends State<PartnerLoanForm> {
PartnerController controller = Get.find<PartnerController>();
  GlobalKey<FormState> formKeyAddPartnerForm = GlobalKey<FormState>(debugLabel: '_formKeyAddPartnerForm');
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.r),
      margin: EdgeInsets.only(bottom: 10.r),
      color: AllColors.white.withOpacity(0.9),
      child: Form(
        key: formKeyAddPartnerForm,
        child: Column(
          children: [
            UnderLineTextField(
              labelText: "Name".tr,
              hint: "Full Name".tr,
              label: true,
              controller: controller.apName,
              onTap: () {},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter name';
                }
                return null;
              },
            ),
            SizedBox(height: 5.r),
            UnderLineTextField(
              labelText: "Date of Birth".tr,
              hint: "Date of Birth".tr,
              label: true,
              controller: controller.apDob,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2800));
                if (pickedDate != null) {
                  print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(formattedDate); //formatted date output using intl package =>  2021-03-16
                  controller.apDob.text = formattedDate;
                } else {}
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
              items: ["Select Gender","Male", "Female", "Other"].map((String value) {
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
                controller.gender.value = newValue ?? "Select Gender";
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select gender';
                }else if(value=="Select Gender"){
                  return 'Please select gender';
                }
                return null;
              },
              value: controller.gender.value,
              hint: "Gender",
            ),
            SizedBox(height: 5.r),
            CustomUnderlineDropdownField(
              items: ["Select Marital Status", "Married", "Single", "Divorced"].map((String value) {
                if(value=="Select Marital Status"){
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
              value: controller.maritalStatus.value, // Set the default value here
              onChanged: (String? newValue) {
                controller.maritalStatus.value = newValue ?? "Select Marital Status";
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select marital status';
                }else if(value=="Select Marital Status"){
                  return 'Please select marital status';
                }
                return null;
              },
              hint: "Marital Status",
            ),
            SizedBox(height: 5.r),
            CustomUnderlineDropdownField(
              items: ["Select Qualification", "High School", "Graduation", "Masters", "Phd", "Certificate", "Diploma","Mca"].map((String value) {
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
              onChanged:  (String? newValue) {
                controller.highestQualification.value = newValue ?? "Select Qualification";
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please highest qualification';
                }else if(value=="Select Qualification"){
                  return 'Please select highest qualification';
                }
                return null;
              },
              value: controller.highestQualification.value,
              hint:  "Highest Qualification",
            ),
            SizedBox(height: 10.r),
            UnderLineTextField(
              labelText: "Email ID".tr,
              hint: "Email ID".tr,
              label: true,
              controller: controller.apEmail,
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
            CustomUnderLineTextField(
              controller: controller.apPassword,
              type: TextInputType.text,
              prefixIconColor: AllColors.black.withOpacity(0.5),
              isPassword: true,
              boldNon: true,
              hint: "Enter Password",
              length: 15,
              prefixIcon: Icons.lock_open_outlined,
              validator: (passwordValue) {
                RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                var passNonNullValue=passwordValue??"";
                if(passNonNullValue.isEmpty){
                  return ("Password is required");
                }
                else if(passNonNullValue.length<8){
                  return ("Please enter 8 digit password");
                }
                else if(!regex.hasMatch(passNonNullValue)){
                  return ("Please enter valid password, ex - Example@123");
                }
                return null;
              },
            ),
            SizedBox(height: 5.r),
            UnderLineTextField(
              hint: "Phone Number".tr,
              // labelText: "Phone Number".tr,
              controller: controller.apNumber,
              onTap: () {},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter phone number';
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
            SizedBox(height: 10.r),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "We will send OTP to phone number you mention",
                style: fontExtraSmall.copyWith(
                    color: AllColors.black.withOpacity(0.5)),
              ),
            ),
            SizedBox(height: 30.r),
            CustomButton(
              title: "Next".tr,
              background: true,
              radius: 30.r,
              height: 30.r,
              width: Get.width - 240,
              onTap: () async {
                if (formKeyAddPartnerForm.currentState != null && formKeyAddPartnerForm.currentState!.validate()) {
                  addPartnerTab.value = 2;
                }
              },
            ),
            SizedBox(height: 20.r),
          ],
        ),
      ),
    );
  }
}
