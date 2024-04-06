// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';
import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_dropdown.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/Profile/employee_profile.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker_widget/flutter_holo_date_picker_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class EmployeeAboutWidget extends StatefulWidget {
  const EmployeeAboutWidget({Key? key}) : super(key: key);

  @override
  State<EmployeeAboutWidget> createState() => _EmployeeAboutWidgetState();
}

class _EmployeeAboutWidgetState extends State<EmployeeAboutWidget> {
  Rx<String?> gender = "Male".obs;
  Rx<String?> marital = "Married".obs;
  Rx<String?> qualification = "High School".obs;
  var loginController = Get.find<LoginController>();
  var controller = Get.find<PartnerController>();
  RxInt profileGradeValueTab = 1.obs;
  TextEditingController profileGrade = TextEditingController();
  TextEditingController profilePercentage = TextEditingController();
  GlobalKey<FormState> formKeyGradeProfile = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyPercentageProfile = GlobalKey<FormState>();

  @override
  void initState() {
    saveDataAbout();
    controller.partnerRefreshList();
    super.initState();
  }
  saveDataAbout()async{
    bool status = await controller.getEmployeeDetailsNetworkApi(GetStorage().read(AppConstant.cust_id).toString());
    if(status==true){
      controller.partnerRefreshList();
      controller.emp_fName.text = controller.employeeDetails.value.data.basicDetails.empFname??"";
      controller.emp_lName.text = controller.employeeDetails.value.data.basicDetails.empLname??"";
      controller.emp_dob.text = controller.employeeDetails.value.data.basicDetails.empDob??"";
      controller.emp_phone.text = controller.employeeDetails.value.data.basicDetails.empPhone??"";
      controller.emp_email.text = controller.employeeDetails.value.data.basicDetails.empEmail??"";
      controller.emp_present_address_pin.text = controller.employeeDetails.value.data.basicDetails.empPresentAddressPin??"";
      controller.emp_present_address.text = controller.employeeDetails.value.data.basicDetails.empPresentAddress??"";
      gender.value = (controller.employeeDetails.value.data.basicDetails.empGender!=""&&controller.employeeDetails.value.data.basicDetails.empGender!=null?controller.employeeDetails.value.data.basicDetails.empGender.toString().capitalize:"Male");
      marital.value = (controller.employeeDetails.value.data.basicDetails.empMaritalStatus!=""&&controller.employeeDetails.value.data.basicDetails.empMaritalStatus!=null?controller.employeeDetails.value.data.basicDetails.empMaritalStatus.toString().capitalize:"Married");
      qualification.value = (controller.employeeDetails.value.data.basicDetails.empEducation!=""&&controller.employeeDetails.value.data.basicDetails.empEducation!=null?controller.employeeDetails.value.data.basicDetails.empEducation.toString().capitalize: "High School");
      saveSocialMedia();
      controller.empEducationFieldList.clear();
      if(controller.employeeDetails.value.data.education.isNotEmpty) {
        for (var element in controller.employeeDetails.value.data.education) {
          controller.empEducationFieldList.add({
            "emp_institute_name": TextEditingController(text: element.empInstituteName),
            "emp_course_name":  TextEditingController(text: element.empCourseName),
            "emp_course_type": controller.employeeCourseTypeList[controller.employeeCourseTypeList.indexWhere((element2) => element2==element.empCourseType.toString().capitalize)!=-1?
            controller.employeeCourseTypeList.indexWhere((element2) => element2==element.empCourseType.toString().capitalize):0],
            "emp_course_start":  TextEditingController(text: element.empCourseStart),
            "emp_course_end":  TextEditingController(text: element.empCourseEnd),
            "emp_course_grade": TextEditingController(text: element.empCourseGrade),
            // "emp_course_grade": controller.employeeCourseTypeList[controller.employeeCourseTypeList.indexWhere((element2) => element2==element.empCourseGrade.toString().capitalize)!=-1?
            // controller.employeeCourseTypeList.indexWhere((element2) => element2==element.empCourseGrade.toString().capitalize):0],
            "emp_skills":  TextEditingController(text: element.empSkills),
          });
        }
      }else{
        controller.empEducationFieldList.value.add({
          "emp_institute_name":  TextEditingController(),
          "emp_course_name": TextEditingController(),
          "emp_course_type": null,
          "emp_course_start": TextEditingController(),
          "emp_course_end": TextEditingController(),
          "emp_course_grade": TextEditingController(),
          "emp_skills": TextEditingController(),
        });
      }
      controller.empExperienceFieldList.clear();
      if(controller.employeeDetails.value.data.exprience.isNotEmpty) {
        for (var element in controller.employeeDetails.value.data.exprience) {
          controller.empExperienceFieldList.add({
            "emp_designation": TextEditingController(text: element.empDesignation),
            "emp_company":  TextEditingController(text: element.empCompany),
            "emp_function": controller.employeeExperienceJobLevelList[controller.employeeExperienceJobLevelList.indexWhere((element2) => element2==element.empFunction.toString().capitalize)!=-1?
            controller.employeeExperienceJobLevelList.indexWhere((element2) => element2==element.empFunction.toString().capitalize):0],
            "emp_industry": controller.employeeExperienceIndustryList[controller.employeeExperienceIndustryList.indexWhere((element2) => element2==element.empIndustry.toString().capitalize)!=-1?
            controller.employeeExperienceIndustryList.indexWhere((element2) => element2==element.empIndustry.toString().capitalize):0],
            "emp_company_size": controller.employeeExperienceJobFunctionList[controller.employeeExperienceJobFunctionList.indexWhere((element2) => element2==element.empCompanySize.toString().capitalize)!=-1?
            controller.employeeExperienceJobFunctionList.indexWhere((element2) => element2==element.empCompanySize.toString().capitalize):0],
            "emp_joining_salary":   TextEditingController(text: element.empJoiningSalary.toString()),
            "emp_last_salary":  TextEditingController(text: element.empLastSalary.toString()),
            "emp_job_start_date":  TextEditingController(text: element.empJobStartDate),
            "emp_job_end_date":  TextEditingController(text: element.empJobEndDate),
          });
        }
      }
    }
  }

  saveSocialMedia()async{
    if(controller.employeeDetails.value.data.basicDetails.empSocial!=null&&
        controller.employeeDetails.value.data.basicDetails.empSocial!=""){
      String data=  controller.employeeDetails.value.data.basicDetails.empSocial.toString();
      List<Map<String, dynamic>> empSocialList = List<Map<String, dynamic>>.from(json.decode(data));
      String facebookValue = empSocialList.firstWhere((element) => element.containsKey('fb'), orElse: () => {})['fb'] ?? '';
      String linkedinValue = empSocialList.firstWhere((element) => element.containsKey('insta'), orElse: () => {})['insta'] ?? '';
      String twitterValue = empSocialList.firstWhere((element) => element.containsKey('twitter'), orElse: () => {})['twitter'] ?? '';
      controller.emp_facebook.text = facebookValue.toString();
      controller.emp_linkedin.text = twitterValue.toString();
      // Print or use the extracted values
      print('Facebook: $facebookValue');
      print('Instagram: $linkedinValue');
      print('Twitter: $twitterValue');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.r),
      child: GetBuilder<PartnerController>(
        builder: (controller) {
        // saveSocialMedia();
          return Column(
            children: [
              Container(
                width: Get.width,
                alignment: Alignment.center,
                color: AllColors.lightTeal.withOpacity(0.3),
                padding: EdgeInsets.symmetric(vertical: 10.0.r),
                margin: EdgeInsets.only(bottom: 15.0.r),
                child: RichText(
                  text: TextSpan(
                    text: "::  ",
                    style: fontBold.copyWith(fontSize: 12.r,
                        color: AllColors.black.withOpacity(0.6)),
                    children: [
                      TextSpan(text: "Basic Details",
                          style: fontBold.copyWith(fontSize: 12.r)),
                      TextSpan(text: "  ::",
                        style: fontBold.copyWith(fontSize: 12.r,
                            color: AllColors.black.withOpacity(0.6)),
                      ),
                    ],
                  ),
                ),
              ),
              UnderLineTextField(
                labelText: "First Name".tr,
                hint: "First Name".tr,
                label: true,
                controller: controller.emp_fName,
                type: TextInputType.text,
                length: 30,
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
                hint: "Last Name".tr,
                label: true,
                controller: controller.emp_lName,
                type: TextInputType.text,
                length: 30,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter last name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 5.r),
              UnderLineTextField(
                labelText: "Date of Birth".tr,
                hint: "Date of Birth".tr,
                controller: controller.emp_dob,
                label: true,
                type: TextInputType.text,
                length: 20,
                icon: true,
                isRead: true,
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
                  controller.emp_dob.text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString()));
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please choose date of birth';
                  }
                  return null;
                },
              ),
              SizedBox(height: 2.r),
              CustomUnderlineDropdownField(
                items: ["Male", "Female", "Other"].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                    onTap: (){
                      gender.value=value;
                    },
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  gender.value = newValue ?? "Male";
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
                items: ["Married", "Single", "Divorced"].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                    onTap: (){
                      marital.value=value;
                    },
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  marital.value = newValue ?? "Married";
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
                items: ["High School", "Graduation", "Masters", "Phd", "Certificate", "Diploma","Mca"].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                    onTap: (){
                      qualification.value=value;
                    },
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  qualification.value = newValue ?? "High School";
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
              SizedBox(height: 8.r),
              UnderLineTextField(
                labelText: "Email ID".tr,
                hint: "Email ID".tr,
                label: true,
                controller: controller.emp_email,
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
                labelText: "Facebook Link".tr,
                hint: "Facebook Link".tr,
                label: true,
                controller: controller.emp_facebook,
                type: TextInputType.text,
                length: 30,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter facebook link';
                  }
                  return null;
                },
              ),
              SizedBox(height: 5.r),
              UnderLineTextField(
                labelText: "Linkedin Link".tr,
                hint: "Linkedin Link".tr,
                label: true,
                controller: controller.emp_linkedin,
                type: TextInputType.text,
                length: 30,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter linkedin link';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.r),
              UnderLineTextField(
                labelText: "Pin code".tr,
                hint: "Pin code".tr,
                label: true,
                controller: controller.emp_present_address_pin,
                type: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                labelText: "Line Address".tr,
                hint: "Line Address".tr,
                label: true,
                controller: controller.emp_present_address,
                type: TextInputType.text,
                length: 40,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
              ),
              UnderLineTextField(
                controller: controller.emp_phone,
                hint: "Phone Number".tr,
                labelText: "Phone Number".tr,
                onTap: () {},
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
                preIcon: false,
              ),
              Container(
                width: Get.width,
                alignment: Alignment.center,
                color: AllColors.lightTeal.withOpacity(0.3),
                padding: EdgeInsets.symmetric(vertical: 10.0.r),
                margin: EdgeInsets.symmetric(vertical: 15.0.r),
                child: RichText(
                  text: TextSpan(
                    text: "::  ",
                    style: fontBold.copyWith(fontSize: 12.r,
                        color: AllColors.black.withOpacity(0.6)),
                    children: [
                      TextSpan(text: "Education Details",
                          style: fontBold.copyWith(fontSize: 12.r)),
                      TextSpan(text: "  ::",
                        style: fontBold.copyWith(fontSize: 12.r,
                            color: AllColors.black.withOpacity(0.6)),
                      ),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                  itemCount: controller.empEducationFieldList.value.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(index!=0)
                          Padding(
                            padding: EdgeInsets.only(top: 12.0.r,bottom: 8.0.r,),
                            child: Row(
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
                                  onTap: ()=> educationConfirmationAlertDialog(context, index),
                                  child: Icon(
                                    Icons.close,
                                    size: 18.r,
                                    color: AllColors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        UnderLineTextField(
                          controller: controller.empEducationFieldList.value[index]['emp_course_name'],
                          labelText: "Course Name".tr,
                          hint: "Course Name".tr,
                          label: true,
                          type: TextInputType.text,
                          length: 30,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter course name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 5.r),
                        UnderLineTextField(
                          controller: controller.empEducationFieldList.value[index]['emp_institute_name'],
                          labelText: "Institute Name".tr,
                          hint: "Institute Name".tr,
                          label: true,
                          type: TextInputType.text,
                          length: 50,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter institute name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 2.r),
                        CustomUnderlineDropdownField(
                          items: controller.employeeCourseTypeList.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                              onTap: (){
                                print("value $value");
                                controller.empEducationFieldList.value[index]['emp_course_type']=value;
                                controller.emp_course_type.value=controller.empEducationFieldList.value[index]['emp_course_type'];
                                controller.empEducationFieldList.refresh();
                              },
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            print("jhkh $newValue");
                            controller.empEducationFieldList.value[index]['emp_course_type']=newValue??"MBA";
                            controller.emp_course_type.value=controller.empEducationFieldList.value[index]['emp_course_type'];
                            controller.empEducationFieldList.refresh();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select course type';
                            }
                            return null;
                          },
                          value: controller.emp_course_type.value,
                          hint: "Course Type",
                        ),
                        SizedBox(height: 8.r),
                        // CustomUnderlineDropdownField(
                        //   items: controller.employeeCourseGradeList.map((String value) {
                        //     return DropdownMenuItem<String>(
                        //       value: value,
                        //       child: Text(value),
                        //       onTap: (){
                        //         print("value $value");
                        //         controller.empEducationFieldList.value[index]['emp_course_grade']=value;
                        //         controller.emp_grade.value=controller.empEducationFieldList.value[index]['emp_course_grade'];
                        //         controller.empEducationFieldList.refresh();
                        //       },
                        //     );
                        //   }).toList(),
                        //   onChanged: (String? newValue) {
                        //     print("jhkh $newValue");
                        //     controller.empEducationFieldList.value[index]['emp_course_grade']=newValue??"Garde A";
                        //     controller.emp_grade.value=controller.empEducationFieldList.value[index]['emp_course_grade'];
                        //     controller.empEducationFieldList.refresh();
                        //   },
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please select marital status';
                        //     }
                        //     return null;
                        //   },
                        //   value: controller.emp_grade.value,
                        //   hint: "Grade (Percentage)",
                        // ),
                        UnderLineTextField(
                          controller: controller.empEducationFieldList.value[index]['emp_course_grade'],
                          labelText: "Grade (Percentage)".tr,
                          hint: "Grade (Percentage)".tr,
                          label: true,
                          isRead: true,
                          type: TextInputType.text,
                          length: 30,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select grade';
                            }
                            return null;
                          },
                          onTap: (){
                            profileGrade.clear();
                            profilePercentage.clear();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 15.r),
                                  title: const Text('Select Grade Type'),
                                  content: SizedBox(
                                    width: double.maxFinite,
                                    height: 200.r,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 35.r,
                                          margin: EdgeInsets.only(top: 10.r, left: 8.r, right: 8.r),
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 0.5.r, color: AllColors.themeColor)
                                          ),
                                          child: Obx(() => Row(
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: (){
                                                    profileGrade.clear();
                                                    profilePercentage.clear();
                                                    profileGradeValueTab.value=1;
                                                  },
                                                  child: AnimatedContainer(
                                                    curve: Curves.linearToEaseOut,
                                                    duration: const Duration(milliseconds: 200),
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.symmetric(horizontal: 16.r),
                                                    decoration: BoxDecoration(
                                                      color: profileGradeValueTab.value==1?AllColors.themeColor:AllColors.none,
                                                      // border: Border(bottom: BorderSide(width: 3.r, ))
                                                    ),
                                                    child: Text("Grade".tr,
                                                      style:  fontMedium.copyWith(fontSize: 14.r, wordSpacing: 0,letterSpacing: 0.4,color: profileGradeValueTab.value==1?AllColors.white.withOpacity(0.9):AllColors.themeColor),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: (){
                                                    profileGrade.clear();
                                                    profilePercentage.clear();
                                                    profileGradeValueTab.value=2;
                                                  },
                                                  child: AnimatedContainer(
                                                    curve: Curves.linearToEaseOut,
                                                    duration: const Duration(milliseconds: 200),
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.symmetric(horizontal: 16.r),
                                                    decoration: BoxDecoration(
                                                      color: profileGradeValueTab.value==2?AllColors.themeColor:AllColors.none,
                                                    ),
                                                    child: Text("Percentage".tr,
                                                      style:  fontMedium.copyWith(fontSize: 14.r, wordSpacing: 0,letterSpacing: 0.4,color: profileGradeValueTab.value==2?AllColors.white.withOpacity(0.9):AllColors.themeColor),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal:8.0.r),
                                            child: Obx(() {
                                              if(profileGradeValueTab.value==1){
                                                return Form(
                                                  key: formKeyGradeProfile,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 20.r),
                                                      CustomUnderlineDropdownField(
                                                        items: ["Select Grade", "A", "A+", "B", "B+", "C", "C+", "D", "D+"].map((String value) {
                                                          if(value=="Select Grade"){
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
                                                          profileGrade.text = newValue ?? "Select Grade";
                                                        },
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return 'Please select grade';
                                                          } else if (value == "Select Grade") {
                                                            return 'Please select grade';
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        hint: "Grade",
                                                      ),
                                                      SizedBox(height: 25.r),
                                                      CustomButton(
                                                        title: "Submit".tr,
                                                        width: 200,
                                                        bgColor: AllColors.green,
                                                        background: false,
                                                        height: 35.r,
                                                        radius: 0,
                                                        onTap: () async {
                                                          if (formKeyGradeProfile.currentState != null && formKeyGradeProfile.currentState!.validate()) {
                                                            //   print("object ${grade.text.toString()}");
                                                            Navigator.pop(context);
                                                            controller.empEducationFieldList.value[index]['emp_course_grade'].text = profileGrade.text.toString();
                                                            print("jhjd ${controller.empEducationFieldList.value[index]['emp_course_grade'].text}");
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }else if(profileGradeValueTab.value==2){
                                                return Form(
                                                  key: formKeyPercentageProfile,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 20.r),
                                                      UnderLineTextField(
                                                        labelText: "Percentage".tr,
                                                        hint: "Percentage 1-99".tr,
                                                        label: true,
                                                        type: TextInputType.number,
                                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                        length: 2,
                                                        controller: profilePercentage,
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return 'Please fill 1-99 percentage number';
                                                          }else {
                                                            return null;
                                                          }
                                                        },
                                                      ),
                                                      SizedBox(height: 25.r),
                                                      CustomButton(
                                                        title: "Submit".tr,
                                                        width: 200,
                                                        bgColor: AllColors.green,
                                                        background: false,
                                                        height: 35.r,
                                                        radius: 0,
                                                        onTap: ()async{
                                                          if (formKeyPercentageProfile.currentState != null && formKeyPercentageProfile.currentState!.validate()) {
                                                            // print("object ${percentage.text.toString()}");
                                                            Navigator.pop(context);
                                                            controller.empEducationFieldList.value[index]['emp_course_grade'].text = "${profilePercentage.text}%";
                                                            // print("jhjd ${controller.empEducationFieldList.value[index]['emp_course_grade'].text}");
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }else{
                                                return const SizedBox();
                                              }
                                            }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(height: 8.r),
                        Row(
                          children: [
                            Expanded(
                              child: UnderLineTextField(
                                controller: controller.empEducationFieldList.value[index]['emp_course_start'],
                                labelText: "Start Date".tr,
                                hint: "Start Date".tr,
                                label: true,
                                icon: true,
                                isRead: true,
                                type: TextInputType.text,
                                length: 30,
                                onTap: () async {
                                  var datePicked = await DatePicker.showSimpleDatePicker(
                                    context,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                    dateFormat: "yyyy-MM-dd",
                                    locale: DateTimePickerLocale.en_us,
                                    looping: true,
                                  );
                                  controller.empEducationFieldList.value[index]['emp_course_start'].text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString()));
                                  controller.emp_start_date.value=controller.empEducationFieldList.value[index]['emp_course_start'];
                                  controller.empEducationFieldList.refresh();
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select start date';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 15.r),
                            Expanded(
                                child: UnderLineTextField(
                                  controller: controller.empEducationFieldList.value[index]['emp_course_end'],
                                  labelText: "End Date".tr,
                                  hint: "End Date".tr,
                                  label: true,
                                  icon: true,
                                  isRead: true,
                                  type: TextInputType.text,
                                  length: 30,
                                  onTap: () async {
                                    var datePicked = await DatePicker.showSimpleDatePicker(
                                      context,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                      dateFormat: "yyyy-MM-dd",
                                      locale: DateTimePickerLocale.en_us,
                                      looping: true,
                                    );
                                    controller.empEducationFieldList.value[index]['emp_course_end'].text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString()));
                                    controller.emp_end_date.value=controller.empEducationFieldList.value[index]['emp_course_end'];
                                    controller.empEducationFieldList.refresh();
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select end date';
                                    }
                                    return null;
                                  },
                                )
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
              SizedBox(height: 20.r),
              Container(
                padding: EdgeInsets.only(right: 5.r),
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: (){
                    controller.empEducationAddField();
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
              Container(
                width: Get.width,
                alignment: Alignment.center,
                color: AllColors.lightTeal.withOpacity(0.3),
                padding: EdgeInsets.symmetric(vertical: 10.0.r),
                margin: EdgeInsets.symmetric(vertical: 15.0.r),
                child: RichText(
                  text: TextSpan(
                    text: "::  ",
                    style: fontBold.copyWith(fontSize: 12.r,
                        color: AllColors.black.withOpacity(0.6)),
                    children: [
                      TextSpan(text: "Experience Details",
                          style: fontBold.copyWith(fontSize: 12.r)),
                      TextSpan(text: "  ::",
                          style: fontBold.copyWith(fontSize: 12.r,
                              color: AllColors.black.withOpacity(0.6)),
                      ),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                itemCount:  controller.empExperienceFieldList.value.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return Column(
                    children: [
                      if(index!=0)
                        Padding(
                          padding: EdgeInsets.only(top: 12.0.r,bottom: 8.0.r),
                          child: Row(
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
                                onTap: ()=> experienceConfirmationAlertDialog(context, index),
                                child: Icon(
                                  Icons.close,
                                  size: 18.r,
                                  color: AllColors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      UnderLineTextField(
                        controller: controller.empExperienceFieldList.value[index]['emp_designation'],
                        labelText: "Designation".tr,
                        hint: "Designation".tr,
                        label: true,
                        type: TextInputType.text,
                        length: 30,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter designation';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 5.r),
                      UnderLineTextField(
                        controller: controller.empExperienceFieldList.value[index]['emp_company'],
                        labelText: "Company Name".tr,
                        hint: "Company Name".tr,
                        label: true,
                        type: TextInputType.text,
                        length: 50,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter company name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 2.r),
                      CustomUnderlineDropdownField(
                        items: controller.employeeExperienceJobLevelList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                            onTap: (){
                              print("value $value");
                              controller.empExperienceFieldList.value[index]['emp_function']=value;
                              controller.emp_function.value=controller.empExperienceFieldList.value[index]['emp_function'];
                              controller.empExperienceFieldList.refresh();
                            },
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          print("jhkh $newValue");
                          controller.empExperienceFieldList.value[index]['emp_function']=newValue??"IT-Software";
                          controller.emp_function.value=controller.empExperienceFieldList.value[index]['emp_function'];
                          controller.empExperienceFieldList.refresh();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select job level';
                          }
                          return null;
                        },
                        value: controller.emp_function.value,
                        hint: "Job Level",
                      ),
                      SizedBox(height: 8.r),
                      CustomUnderlineDropdownField(
                        items: controller.employeeExperienceIndustryList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                            onTap: (){
                              print("value $value");
                              controller.empEducationFieldList.value[index]['emp_industry']=value;
                              controller.emp_industry.value=controller.empEducationFieldList.value[index]['emp_industry'];
                              controller.empEducationFieldList.refresh();
                            },
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          print("jhkh $newValue");
                          controller.empEducationFieldList.value[index]['emp_industry']=newValue??"Telecom";
                          controller.emp_industry.value=controller.empEducationFieldList.value[index]['emp_industry'];
                          controller.empEducationFieldList.refresh();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select Industry';
                          }
                          return null;
                        },
                        value: controller.emp_industry.value,
                        hint: "Industry",
                      ),
                      SizedBox(height: 8.r),
                      CustomUnderlineDropdownField(
                        items: controller.employeeExperienceJobFunctionList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                            onTap: (){
                              print("value $value");
                              controller.empExperienceFieldList.value[index]['emp_company_size']=value;
                              controller.emp_company_size.value=controller.empExperienceFieldList.value[index]['emp_company_size'];
                              controller.empExperienceFieldList.refresh();
                            },
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          print("jhkh $newValue");
                          controller.empExperienceFieldList.value[index]['emp_company_size']=newValue??"Garde A";
                          controller.emp_company_size.value=controller.empExperienceFieldList.value[index]['emp_company_size'];
                          controller.empExperienceFieldList.refresh();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select job function';
                          }
                          return null;
                        },
                        value: controller.emp_company_size.value,
                        hint: "Job Function",
                      ),
                      SizedBox(height: 8.r),
                      Row(
                        children: [
                          Expanded(
                            child: UnderLineTextField(
                              controller: controller.empExperienceFieldList.value[index]['emp_joining_salary'],
                              labelText: "Joining Salary".tr,
                              hint: "Joining Salary".tr,
                              label: true,
                              type: TextInputType.number,
                              length: 30,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter joining salary';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 15.r),
                          Expanded(
                            child: UnderLineTextField(
                              controller: controller.empExperienceFieldList.value[index]['emp_last_salary'],
                              labelText: "Last Salary".tr,
                              hint: "Last Salary".tr,
                              label: true,
                              type: TextInputType.number,
                              length: 30,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter last salary';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.r),
                      Row(
                        children: [
                          Expanded(
                            child: UnderLineTextField(
                              controller: controller.empExperienceFieldList.value[index]['emp_job_start_date'],
                              labelText: "Start Date".tr,
                              hint: "Start Date".tr,
                              label: true,
                              icon: true,
                              type: TextInputType.text,
                              length: 30,
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
                                controller.empExperienceFieldList.value[index]['emp_job_start_date'].text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString())).toString();
                                controller.emp_join_start_date.value=controller.empExperienceFieldList.value[index]['emp_job_start_date'].text;
                                controller.empExperienceFieldList.refresh();
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select start date';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 15.r),
                          Expanded(
                              child: UnderLineTextField(
                                controller: controller.empExperienceFieldList.value[index]['emp_job_end_date'],
                                labelText: "End Date".tr,
                                hint: "End Date".tr,
                                label: true,
                                icon: true,
                                type: TextInputType.text,
                                length: 30,
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
                                  controller.empExperienceFieldList.value[index]['emp_job_end_date'].text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString())).toString();
                                  controller.emp_join_end_date.value=controller.empExperienceFieldList.value[index]['emp_job_end_date'].text;
                                  controller.empExperienceFieldList.refresh();
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select end date';
                                  }
                                  return null;
                                },
                              )
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 20.r),
              Container(
                padding: EdgeInsets.only(right: 5.r),
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: (){
                    controller.empExperienceAddField();
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
              SizedBox(height: 30.r),
              CustomButton(
                title: "Update".tr,
                bgColor: AllColors.green,
                background: false,
                height: 38.r,
                radius: 0,
                onTap: ()async{
                    bool status = await controller.employeeProfileUpdateAboutNetworkApi(gender.value, marital.value, qualification.value);
                    if (status == true) {
                      controller.getEmployeeDetailsNetworkApi(GetStorage().read(AppConstant.cust_id).toString());
                      employeeProfileTab.value = 2;
                    }
                },
              ),
            ],
          );
        }
      ),
    );
  }

  experienceConfirmationAlertDialog(BuildContext context, index) {
    AlertDialog alert = AlertDialog(
      title: Text("Remove", style:fontBold.copyWith(fontSize: 18.r),),
      content: Text("Are you sure?, Do you want to remove this experience form?", style: fontMedium.copyWith(fontSize: 15.r, wordSpacing: 0, letterSpacing: 0.2),),
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
            controller.empExperienceDeleteField(index);
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
  educationConfirmationAlertDialog(BuildContext context, index) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Remove", style:fontBold.copyWith(fontSize: 18.r),),
      content: Text("Are you sure?, Do you want to remove this education form?", style: fontMedium.copyWith(fontSize: 15.r, wordSpacing: 0, letterSpacing: 0.2),),
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
            controller.empEducationDeleteField(index);
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
