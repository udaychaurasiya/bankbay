// ignore_for_file: invalid_use_of_protected_member, unnecessary_null_comparison, use_build_context_synchronously
import 'dart:convert';

import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_dropdown.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/widgets/Customer%20details/Employee%20Details/employee_push_back_details.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker_widget/flutter_holo_date_picker_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EmployeePushBackAboutScreen extends StatefulWidget {
  final String pageName;
  final String empId;
  const EmployeePushBackAboutScreen({super.key, required this.pageName, required this.empId});

  @override
  State<EmployeePushBackAboutScreen> createState() => _EmployeePushBackAboutScreenState();
}

class _EmployeePushBackAboutScreenState extends State<EmployeePushBackAboutScreen> {
var controller = Get.find<LoginController>();
var partnerController = Get.find<PartnerController>();
  TextEditingController remarks = TextEditingController();
  RxInt gradeValueTabEdit = 1.obs;
  TextEditingController gradeEdit = TextEditingController();
  TextEditingController percentageEdit = TextEditingController();
  GlobalKey<FormState> formKeyGradeEdit = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyPercentageEdit = GlobalKey<FormState>();

  @override
  void initState() {
    controller.employeeRefreshList();
    saveData();
    super.initState();
  }

  saveData() async {
    bool status = await partnerController.getEmployeeDetailsNetworkApi(widget.empId.toString());
    if(status==true){
      controller.emp_pushback_fName.text=partnerController.employeeDetails.value.data.basicDetails.empFname??"";
      controller.emp_pushback_lName.text=partnerController.employeeDetails.value.data.basicDetails.empLname??"";
      controller.emp_pushback_dob.text=partnerController.employeeDetails.value.data.basicDetails.empDob??"";
      controller.emp_pushback_phone.text=partnerController.employeeDetails.value.data.basicDetails.empPhone??"";
      controller.emp_pushback_email.text=partnerController.employeeDetails.value.data.basicDetails.empEmail??"";
      controller.emp_pushback_present_address_pin.text=partnerController.employeeDetails.value.data.basicDetails.empPresentAddressPin??"";
      controller.emp_pushback_present_address.text=partnerController.employeeDetails.value.data.basicDetails.empPresentAddress??"";
      controller.emp_pushback_PanCard.text=partnerController.employeeDetails.value.data.basicDetails.empPan??"";
      controller.emp_pushback_Aadhaar.text=partnerController.employeeDetails.value.data.basicDetails.empAadhar??"";
      saveSocialMedia();
      controller.employeeRefreshList();
      controller.empPushbackEducationFieldList.clear();
      if(partnerController.employeeDetails.value.data.education.isNotEmpty) {
        for (var element in  partnerController.employeeDetails.value.data.education) {
          controller.empPushbackEducationFieldList.add({
            "emp_institute_name": TextEditingController(text: element.empInstituteName),
            "emp_course_name":  TextEditingController(text: element.empCourseName),
            "emp_course_type": controller.employeeCourseTypeList[controller.employeeCourseTypeList.indexWhere((element2) => element2==element.empCourseType)!=-1?
            controller.employeeCourseTypeList.indexWhere((element2) => element2==element.empCourseType):0],
            "emp_course_start":  TextEditingController(text: element.empCourseStart),
            "emp_course_end":  TextEditingController(text: element.empCourseEnd),
            "emp_course_grade": TextEditingController(text: element.empCourseGrade),
            "emp_skills":  TextEditingController(text: element.empSkills),
          });
        }
      }
      else{
        controller.empPushbackEducationFieldList.value.add({
          "emp_course_name": TextEditingController(),
          "emp_institute_name":  TextEditingController(),
          "emp_course_type": null,
          "emp_course_grade": TextEditingController(),
          "emp_course_start": TextEditingController(),
          "emp_course_end": TextEditingController(),
          "emp_skills": TextEditingController(),
        });
      }
      controller.empPushbackExperienceFieldList.clear();
      if(partnerController.employeeDetails.value.data.exprience.isNotEmpty) {
        for (var element in partnerController.employeeDetails.value.data.exprience) {
          controller.empPushbackExperienceFieldList.add({
            "emp_designation": TextEditingController(text: element.empDesignation),
            "emp_company":  TextEditingController(text: element.empCompany),
            "emp_function": controller.employeeExperienceJobLevelList[controller.employeeExperienceJobLevelList.indexWhere((element2) => element2==element.empFunction)!=-1?
            controller.employeeExperienceJobLevelList.indexWhere((element2) => element2==element.empFunction):0],
            "emp_industry": controller.employeeExperienceIndustryList[controller.employeeExperienceIndustryList.indexWhere((element2) => element2==element.empIndustry)!=-1?
            controller.employeeExperienceIndustryList.indexWhere((element2) => element2==element.empIndustry):0],
            "emp_company_size": controller.employeeCompanySizeList[controller.employeeCompanySizeList.indexWhere((element2) => element2==element.empCompanySize)!=-1?
            controller.employeeCompanySizeList.indexWhere((element2) => element2==element.empCompanySize):0],
            "emp_joining_salary":   TextEditingController(text: element.empJoiningSalary.toString()),
            "emp_last_salary":  TextEditingController(text: element.empLastSalary.toString()),
            "emp_job_start_date":  TextEditingController(text: element.empJobStartDate),
            "emp_job_end_date":  TextEditingController(text: element.empJobEndDate),
          });
        }
      }
      else{
        controller.empPushbackExperienceFieldList.value.add({
          "emp_designation":  TextEditingController(),
          "emp_company": TextEditingController(),
          "emp_function": null,
          "emp_industry": null,
          "emp_company_size": null,
          "emp_joining_salary": TextEditingController(),
          "emp_last_salary": TextEditingController(),
          "emp_job_start_date": TextEditingController(),
          "emp_job_end_date": TextEditingController(),
        });
      }
    }
  }

  saveSocialMedia()async{
    if(partnerController.employeeDetails.value.data.basicDetails.empSocial!=null&&
        partnerController.employeeDetails.value.data.basicDetails.empSocial!=""){
      String data=  partnerController.employeeDetails.value.data.basicDetails.empSocial.toString();
      List<Map<String, dynamic>> empSocialList = List<Map<String, dynamic>>.from(json.decode(data));
      String facebookValue = empSocialList.firstWhere((element) => element.containsKey('fb'), orElse: () => {})['fb'] ?? '';
      String linkedinValue = empSocialList.firstWhere((element) => element.containsKey('insta'), orElse: () => {})['insta'] ?? '';
      String twitterValue = empSocialList.firstWhere((element) => element.containsKey('twitter'), orElse: () => {})['twitter'] ?? '';
      controller.emp_pushback_facebook.text = facebookValue.toString();
      controller.emp_pushback_linkedin.text = twitterValue.toString();
      // Print or use the extracted values
      print('Facebook: $facebookValue');
      print('Instagram: $linkedinValue');
      print('Twitter: $twitterValue');
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.employeeRefreshList();
    saveSocialMedia();
    Rx<String?> pushbackGender = (partnerController.employeeDetails.value.data.basicDetails.empGender!=""&&partnerController.employeeDetails.value.data.basicDetails.empGender!=null?partnerController.employeeDetails.value.data.basicDetails.empGender.toString().capitalize:"Male").obs;
    Rx<String?> pushbackMarital = (partnerController.employeeDetails.value.data.basicDetails.empMaritalStatus!=""&&partnerController.employeeDetails.value.data.basicDetails.empMaritalStatus!=null?partnerController.employeeDetails.value.data.basicDetails.empMaritalStatus.toString().capitalize:"Married").obs;
    Rx<String?> pushbackQualification = (partnerController.employeeDetails.value.data.basicDetails.empEducation!=""&&partnerController.employeeDetails.value.data.basicDetails.empEducation!=null?partnerController.employeeDetails.value.data.basicDetails.empEducation.toString().capitalize:"High School").obs;
    return Column(
      children: [
        SizedBox(height: 15.r),
        TitleWidget(
          count: 1,
          title: "Basic Details".tr,
          icon: true,
          children: [
            UnderLineTextField(
              labelText: "First Name".tr,
              hint: "First Name".tr,
              label: true,
              controller: controller.emp_pushback_fName,
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
              controller: controller.emp_pushback_lName,
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
              controller: controller.emp_pushback_dob,
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
                controller.emp_pushback_dob.text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString()));
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
                    pushbackGender.value=value;
                  },
                );
              }).toList(),
              onChanged: (String? newValue) {
                pushbackGender.value = newValue ?? "Male";
                print("gender = ${pushbackGender.value}");
              },
              value: pushbackGender.value,
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
                    pushbackMarital.value=value;
                  },
                );
              }).toList(),
              onChanged: (String? newValue) {
                pushbackMarital.value = newValue ?? "Married";
                print("pushbackMarital = ${pushbackMarital.value}");
              },
              value: pushbackMarital.value,
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
                    pushbackQualification.value=value;
                  },
                );
              }).toList(),
              onChanged: (String? newValue) {
                pushbackQualification.value = newValue ?? "High School";
                print("qualification = ${pushbackQualification.value}");
              },
              value: pushbackQualification.value,
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
              controller: controller.emp_pushback_email,
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
              controller: controller.emp_pushback_facebook,
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
              controller: controller.emp_pushback_linkedin,
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
              controller: controller.emp_pushback_present_address_pin,
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
              controller: controller.emp_pushback_present_address,
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
              controller: controller.emp_pushback_phone,
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

          ],
        ),
        SizedBox(height: 15.r),
        TitleWidget(
          count: 2,
          title: "Education".tr,
          icon: true,
          children: [
            GetBuilder<LoginController>(
                builder: (controller)
                {
                  return ListView.builder(
                      itemCount: controller.empPushbackEducationFieldList.value.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                      controller.emp_course_type.value=controller.empPushbackEducationFieldList.value[index]['emp_course_type']??"Select Course Type";
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
                              controller: controller.empPushbackEducationFieldList.value[index]['emp_course_name'],
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
                              controller: controller.empPushbackEducationFieldList.value[index]['emp_institute_name'],
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
                                if(value=="Select Course Type"){
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
                                controller.empPushbackEducationFieldList.value[index]['emp_course_type']=newValue??"Select Course Type";
                                controller.emp_course_type.value=controller.empPushbackEducationFieldList.value[index]['emp_course_type'];
                                controller.empPushbackEducationFieldList.refresh();
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
                            //   items: controller.employeeGradeTypeList.map((String value) {
                            //     if(value=="Select Grade"){
                            //       return DropdownMenuItem<String>(
                            //         value: value,
                            //         enabled: false,
                            //         child: Text(value.toString(),style: fontRegular.copyWith(color: AllColors.grey,wordSpacing: 0, letterSpacing: 0),),
                            //       );
                            //     }else{
                            //       return DropdownMenuItem<String>(
                            //         value: value,
                            //         child: Text(value),
                            //       );
                            //     }
                            //   }).toList(),
                            //   onChanged: (String? newValue) {
                            //     print("jhkh $newValue");
                            //     controller.empPushbackEducationFieldList.value[index]['emp_course_grade']=newValue??"Select Grade";
                            //     controller.emp_grade.value=controller.empPushbackEducationFieldList.value[index]['emp_course_grade'];
                            //     controller.empPushbackEducationFieldList.refresh();
                            //   },
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return 'Please select marital status';
                            //     }
                            //     return null;
                            //   },
                            //   value: controller.emp_grade.value,
                            //   hint: "Company Size",
                            // ),
                            UnderLineTextField(
                              controller: controller.empPushbackEducationFieldList.value[index]['emp_course_grade'],
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
                                gradeEdit.clear();
                                percentageEdit.clear();
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
                                                        gradeEdit.clear();
                                                        percentageEdit.clear();
                                                        gradeValueTabEdit.value=1;
                                                      },
                                                      child: AnimatedContainer(
                                                        curve: Curves.linearToEaseOut,
                                                        duration: const Duration(milliseconds: 200),
                                                        alignment: Alignment.center,
                                                        padding: EdgeInsets.symmetric(horizontal: 16.r),
                                                        decoration: BoxDecoration(
                                                          color: gradeValueTabEdit.value==1?AllColors.themeColor:AllColors.none,
                                                          // border: Border(bottom: BorderSide(width: 3.r, ))
                                                        ),
                                                        child: Text("Grade".tr,
                                                          style:  fontMedium.copyWith(fontSize: 14.r, wordSpacing: 0,letterSpacing: 0.4,color: gradeValueTabEdit.value==1?AllColors.white.withOpacity(0.9):AllColors.themeColor),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: (){
                                                        gradeEdit.clear();
                                                        percentageEdit.clear();
                                                        gradeValueTabEdit.value=2;
                                                      },
                                                      child: AnimatedContainer(
                                                        curve: Curves.linearToEaseOut,
                                                        duration: const Duration(milliseconds: 200),
                                                        alignment: Alignment.center,
                                                        padding: EdgeInsets.symmetric(horizontal: 16.r),
                                                        decoration: BoxDecoration(
                                                          color: gradeValueTabEdit.value==2?AllColors.themeColor:AllColors.none,
                                                        ),
                                                        child: Text("Percentage".tr,
                                                          style:  fontMedium.copyWith(fontSize: 14.r, wordSpacing: 0,letterSpacing: 0.4,color: gradeValueTabEdit.value==2?AllColors.white.withOpacity(0.9):AllColors.themeColor),
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
                                                  if(gradeValueTabEdit.value==1){
                                                    return Form(
                                                      key: formKeyGradeEdit,
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
                                                              gradeEdit.text = newValue ?? "Select Grade";
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
                                                              if (formKeyGradeEdit.currentState != null && formKeyGradeEdit.currentState!.validate()) {
                                                                //   print("object ${grade.text.toString()}");
                                                                Navigator.pop(context);
                                                                controller.empPushbackEducationFieldList.value[index]['emp_course_grade'].text = gradeEdit.text.toString();
                                                                print("jhjd ${controller.empPushbackEducationFieldList.value[index]['emp_course_grade'].text}");
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }else if(gradeValueTabEdit.value==2){
                                                    return Form(
                                                      key: formKeyPercentageEdit,
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
                                                            controller: percentageEdit,
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
                                                              if (formKeyPercentageEdit.currentState != null && formKeyPercentageEdit.currentState!.validate()) {
                                                                // print("object ${percentage.text.toString()}");
                                                                Navigator.pop(context);
                                                                controller.empPushbackEducationFieldList.value[index]['emp_course_grade'].text = "${percentageEdit.text}%";
                                                                // print("jhjd ${controller.empPushbackEducationFieldList.value[index]['emp_course_grade'].text}");
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
                                    controller: controller.empPushbackEducationFieldList.value[index]['emp_course_start'],
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
                                      controller.empPushbackEducationFieldList.value[index]['emp_course_start'].text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString()));
                                      controller.emp_start_date.value=controller.empPushbackEducationFieldList.value[index]['emp_course_start'];
                                      controller.empPushbackEducationFieldList.refresh();
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
                                      controller: controller.empPushbackEducationFieldList.value[index]['emp_course_end'],
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
                                        controller.empPushbackEducationFieldList.value[index]['emp_course_end'].text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString()));
                                        controller.emp_end_date.value=controller.empPushbackEducationFieldList.value[index]['emp_course_end'];
                                        controller.empPushbackEducationFieldList.refresh();
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
                      });
                }),
            SizedBox(height: 20.r),
            Container(
              padding: EdgeInsets.only(right: 5.r),
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: (){
                  print("object");
                  controller.empPushbackEducationAddField();
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
          ],
        ),
        SizedBox(height: 15.r),
        TitleWidget(
          count: 3,
          title: "Experience".tr,
          icon: true,
          children: [
            GetBuilder<LoginController>(builder:(controller) {
              return ListView.builder(
                itemCount:  controller.empPushbackExperienceFieldList.value.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  controller.emp_function.value=controller.empPushbackExperienceFieldList.value[index]['emp_function']??"Select Job Level";
                  controller.emp_industry.value=controller.empPushbackExperienceFieldList.value[index]['emp_industry']??"Select Industry";
                  controller.emp_company_size.value=controller.empPushbackExperienceFieldList.value[index]['emp_company_size']??"Select Company Size";
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
                        controller: controller.empPushbackExperienceFieldList.value[index]['emp_designation'],
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
                        controller: controller.empPushbackExperienceFieldList.value[index]['emp_company'],
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
                          if(value=="Select Job Level"){
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
                          controller.empPushbackExperienceFieldList.value[index]['emp_function']=newValue??"Select Job Level";
                          controller.emp_function.value=controller.empPushbackExperienceFieldList.value[index]['emp_function'];
                          controller.empPushbackExperienceFieldList.refresh();
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
                          if(value=="Select Industry"){
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
                          controller.empPushbackExperienceFieldList.value[index]['emp_industry']=newValue??"Select Industry";
                          controller.emp_industry.value=controller.empPushbackExperienceFieldList.value[index]['emp_industry'];
                          controller.empPushbackExperienceFieldList.refresh();
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
                        items: controller.employeeCompanySizeList.map((String value) {
                          if(value=="Select Company Size"){
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
                          controller.empPushbackExperienceFieldList.value[index]['emp_company_size']=newValue??"Select Company Size";
                          controller.emp_company_size.value=controller.empPushbackExperienceFieldList.value[index]['emp_company_size'];
                          controller.empPushbackExperienceFieldList.refresh();
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
                              controller: controller.empPushbackExperienceFieldList.value[index]['emp_joining_salary'],
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
                              controller: controller.empPushbackExperienceFieldList.value[index]['emp_last_salary'],
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
                              controller: controller.empPushbackExperienceFieldList.value[index]['emp_job_start_date'],
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
                                controller.empPushbackExperienceFieldList.value[index]['emp_job_start_date'].text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString())).toString();
                                controller.emp_join_start_date.value=controller.empPushbackExperienceFieldList.value[index]['emp_job_start_date'].text;
                                controller.empPushbackExperienceFieldList.refresh();
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
                                controller: controller.empPushbackExperienceFieldList.value[index]['emp_job_end_date'],
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
                                  controller.empPushbackExperienceFieldList.value[index]['emp_job_end_date'].text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString())).toString();
                                  controller.emp_join_end_date.value=controller.empPushbackExperienceFieldList.value[index]['emp_job_end_date'].text;
                                  controller.empPushbackExperienceFieldList.refresh();
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
              );
            }),
            SizedBox(height: 20.r),
            Container(
              padding: EdgeInsets.only(right: 5.r),
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: (){
                  controller.empPushbackExperienceAddField();
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
          ],
        ),
        SizedBox(height: 20.r),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0.r),
          child: CustomButton(
            title: "Next".tr,
            // bgColor: AllColors.green,
            background: true,
            height: 35.r,
            radius: 0,
            onTap: ()async{
              bool status = await controller.employeePushBackAboutUpdateNetworkApi(
                  widget.empId.toString(), pushbackGender.value,
                  pushbackMarital.value, pushbackQualification.value
              );
              if (status == true) {
                partnerController.getEmployeeDetailsNetworkApi(partnerController.employeeDetails.value.data.basicDetails.eid.toString());
                employeePushBackDetailsTab.value = 2;
              }
            },
          ),
        ),
        SizedBox(height: 15.r),
        ListView.builder(
          itemCount: partnerController.employeeDetails.value.data.remark.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var remarksData = partnerController.employeeDetails.value.data.remark[index];
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(15.r),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.r, color: AllColors.grey.withOpacity(0.7)),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 10.r),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: remarksData.updateByName??"NA",
                            style: fontSmall.copyWith(fontWeight: FontWeight.w500, color: AllColors.themeColor, fontSize: 12.5.r,wordSpacing: 0, letterSpacing: 0,),
                            children: [
                              TextSpan(text: " (${remarksData.remarkUpdateBy??"NA"})", style: fontSmall.copyWith(fontWeight: FontWeight.w400,  fontSize: 12.r,color: AllColors.black.withOpacity(0.6),wordSpacing: 0, letterSpacing: 0, overflow: TextOverflow.ellipsis,)),
                            ],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2.r),
                        RichText(
                          text: TextSpan(
                            text: "Date : ",
                            style: fontSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),wordSpacing: 0, letterSpacing: 0, fontSize: 11.r, overflow: TextOverflow.ellipsis),
                            children: [
                              TextSpan(text: "${remarksData.remarkDateTime??""}", style: fontSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),wordSpacing: 0, letterSpacing: 0, fontSize: 11.r, overflow: TextOverflow.ellipsis)),
                            ],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(width: 1.r),
                        Text(remarksData.remark??"", style: fontSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),wordSpacing: 0, letterSpacing: 0),),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },),
        SizedBox(height: 20.r),
      ],
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
              controller.empPushbackExperienceDeleteField(index);
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
              controller.empPushbackEducationDeleteField(index);
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


class TitleWidget extends StatefulWidget {
  final String title;
  final bool? icon;
  final List<Widget> children;
  final int count;

  const TitleWidget(
      {super.key, required this.title, this.icon, required this.children, required this.count});

  @override
  State<TitleWidget> createState() => _TitleWidgetState();
}
RxBool obscureText1 = true.obs;
class _TitleWidgetState extends State<TitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: _toggle,
          child: Container(
            decoration: BoxDecoration(
                color: AllColors.lightTeal.withOpacity(0.3),
                border: Border.symmetric(horizontal: BorderSide(
                  width: 1.r, color: AllColors.black.withOpacity(0.1),))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                RichText(
                  text: TextSpan(
                    text: "::",
                    style: fontBold.copyWith(fontSize: 12.r,
                        color: AllColors.black.withOpacity(0.6)),
                    children: [
                      TextSpan(text: " ${widget.title} ",
                          style: fontBold.copyWith(fontSize: 12.r)),
                      TextSpan(text: "::",
                          style: fontBold.copyWith(fontSize: 12.r,
                              color: AllColors.black.withOpacity(0.6))),
                    ],
                  ),
                ),
                if(widget.icon == true)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 3.r),
                    color: AllColors.lightGrey,
                    child: Icon(obscureText1.value ?
                    Icons.keyboard_arrow_up_outlined:
                    Icons.keyboard_arrow_down_outlined,
                      size: 25.r,
                      color: AllColors.black,
                    ),
                  ),
              ],
            ),
          ),
        ),
        if(obscureText1.value)
          SizedBox(height: 10.r),
        if(obscureText1.value)
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:10.0.r),
              child: Column(
                children: widget.children,
              ),
            ),
          ),
      ],
    );
  }

  void _toggle() {
    setState(() {
      obscureText1.value = !obscureText1.value;
    });
  }
}
