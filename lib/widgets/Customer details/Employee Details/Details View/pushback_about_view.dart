// ignore_for_file: invalid_use_of_protected_member, unnecessary_null_comparison, use_build_context_synchronously
import 'dart:convert';

import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/edit_text_field.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/widgets/Employee/employee_home.dart';
import 'package:bank_bay/widgets/dashboard.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EmployeePushBackAboutViewScreen extends StatefulWidget {
  final String? empId;
  final String pageName;
  const EmployeePushBackAboutViewScreen({super.key, required this.empId, required this.pageName});

  @override
  State<EmployeePushBackAboutViewScreen> createState() => _EmployeePushBackAboutViewScreenState();
}

class _EmployeePushBackAboutViewScreenState extends State<EmployeePushBackAboutViewScreen> {
  var controller = Get.find<LoginController>();
  var partnerController = Get.find<PartnerController>();
  final _employeePushbackRemarksFormKey = GlobalKey<FormState>(debugLabel: '_formKeyAddPartnerForm');
  /// education
  RxList<Map> educationFieldList=<Map>[{
    "emp_course_name": TextEditingController(),
    "emp_institute_name":  TextEditingController(),
    "emp_course_type": TextEditingController(),
    "emp_course_grade": TextEditingController(),
    "emp_course_start": TextEditingController(),
    "emp_course_end": TextEditingController(),
    "emp_skills": TextEditingController(),
  }].obs;

  /// experience
  RxList<Map> experienceFieldList=<Map>[{
    "emp_designation":  TextEditingController(),
    "emp_company": TextEditingController(),
    "emp_function": TextEditingController(),
    "emp_industry": TextEditingController(),
    "emp_company_size": TextEditingController(),
    "emp_joining_salary": TextEditingController(),
    "emp_last_salary": TextEditingController(),
    "emp_job_start_date": TextEditingController(),
    "emp_job_end_date": TextEditingController(),
  }].obs;
  TextEditingController remarks = TextEditingController();
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController marital = TextEditingController();
  TextEditingController highQualification = TextEditingController();
  TextEditingController eMail = TextEditingController();
  TextEditingController facebook = TextEditingController();
  TextEditingController linkedin = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();


  @override
  void initState() {
    saveData();
    super.initState();
  }

  saveData() async {
    bool status = await partnerController.getEmployeeDetailsNetworkApi(widget.empId.toString());
    if(status==true){
      fName.text = partnerController.employeeDetails.value.data.basicDetails.empFname??"";
      lName.text = partnerController.employeeDetails.value.data.basicDetails.empLname??"";
      dob.text = partnerController.employeeDetails.value.data.basicDetails.empDob??"";
      gender.text = partnerController.employeeDetails.value.data.basicDetails.empGender??"";
      marital.text = partnerController.employeeDetails.value.data.basicDetails.empMaritalStatus??"";
      highQualification.text = partnerController.employeeDetails.value.data.basicDetails.empEducation??"";
      eMail.text = partnerController.employeeDetails.value.data.basicDetails.empEmail??"";
      // facebook.text = partnerController.employeeDetails.value.data.basicDetails.empFname??"";
      // linkedin.text = partnerController.employeeDetails.value.data.basicDetails.empFname??"";
      country.text = partnerController.employeeDetails.value.data.basicDetails.empCountryId??"";
      state.text = partnerController.employeeDetails.value.data.basicDetails.empStateId??"";
      pincode.text = partnerController.employeeDetails.value.data.basicDetails.empPresentAddressPin??"";
      address.text = partnerController.employeeDetails.value.data.basicDetails.empPresentAddress??"";
      password.text = partnerController.employeeDetails.value.data.basicDetails.empPassword??"";
      phone.text = partnerController.employeeDetails.value.data.basicDetails.empPhone??"";
      saveFaceBookData();
    }
  }

  saveFaceBookData()async{
    if(partnerController.employeeDetails.value.data.basicDetails.empSocial!=null&&
        partnerController.employeeDetails.value.data.basicDetails.empSocial!=""){
      String data=  partnerController.employeeDetails.value.data.basicDetails.empSocial.toString();
      List<Map<String, dynamic>> empSocialList = List<Map<String, dynamic>>.from(json.decode(data));
      String facebookValue = empSocialList.firstWhere((element) => element.containsKey('fb'), orElse: () => {})['fb'] ?? '';
      String linkedinValue = empSocialList.firstWhere((element) => element.containsKey('insta'), orElse: () => {})['insta'] ?? '';
      String twitterValue = empSocialList.firstWhere((element) => element.containsKey('twitter'), orElse: () => {})['twitter'] ?? '';
      facebook.text = facebookValue.toString();
      linkedin.text = twitterValue.toString();
      // Print or use the extracted values
      print('Facebook: $facebookValue');
      print('Instagram: $linkedinValue');
      print('Twitter: $twitterValue');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder:(controller){
      saveFaceBookData();
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
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 3.0.r),
                  child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                ),
                icon: true,
                controller: fName,
                type: TextInputType.text,
              ),
              SizedBox(height: 5.r),
              UnderLineTextField(
                labelText: "Last Name".tr,
                hint: "Last Name".tr,
                label: true,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 3.0.r),
                  child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                ),
                icon: true,
                isRead: true,
                controller:lName,
                type: TextInputType.text,
                length: 30,
              ),
              SizedBox(height: 5.r),
              UnderLineTextField(
                labelText: "Date of Birth".tr,
                hint: "Date of Birth".tr,
                controller: dob,
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
                labelText: "Facebook Link".tr,
                hint: "Facebook Link".tr,
                label: true,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 3.0.r),
                  child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                ),
                icon: true,
                isRead: true,
                controller:facebook,
                type: TextInputType.text,
                length: 30,
              ),
              SizedBox(height: 5.r),
              UnderLineTextField(
                labelText: "Linkedin Link".tr,
                hint: "Linkedin Link".tr,
                label: true,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 3.0.r),
                  child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                ),
                icon: true,
                isRead: true,
                controller: linkedin,
                type: TextInputType.text,
                length: 30,
              ),
              // SizedBox(height: 5.r),
              // UnderLineTextField(
              //   labelText: "Country".tr,
              //   hint: "Country".tr,
              //   label: true,
              //   suffixIcon: Padding(
              //     padding: EdgeInsets.only(right: 3.0.r),
              //     child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
              //   ),
              //   icon: true,
              //   isRead: true,
              //   controller: country,
              //   type: TextInputType.text,
              //   length: 30,
              // ),
              // SizedBox(height: 5.r),
              // UnderLineTextField(
              //   labelText: "State".tr,
              //   hint: "State".tr,
              //   label: true,
              //   suffixIcon: Padding(
              //     padding: EdgeInsets.only(right: 3.0.r),
              //     child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
              //   ),
              //   icon: true,
              //   isRead: true,
              //   controller: state,
              //   type: TextInputType.text,
              //   length: 30,
              // ),
              SizedBox(height: 5.r),
              UnderLineTextField(
                labelText: "Pin code".tr,
                hint: "Pin code".tr,
                label: true,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 3.0.r),
                  child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                ),
                icon: true,
                isRead: true,
                controller: pincode,
                type: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                length: 6,
              ),
              SizedBox(height: 5.r),
              UnderLineTextField(
                labelText: "Line Address".tr,
                hint: "Line Address".tr,
                label: true,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 3.0.r),
                  child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                ),
                icon: true,
                isRead: true,
                controller: address,
                type: TextInputType.text,
                length: 40,
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
          SizedBox(height: 15.r),
          TitleWidget(
            count: 2,
            title: "Education".tr,
            icon: true,
            children: [
              GetBuilder<LoginController>(
                  builder: (controller)
                  {
                    educationFieldList.addAll(List.generate(
                        partnerController.employeeDetails.value.data.education.length,
                            (index) => {
                          "emp_course_name": TextEditingController(
                              text:  partnerController.employeeDetails.value.data.education[index].empCourseName ?? ""),
                          "emp_institute_name": TextEditingController(
                              text:  partnerController.employeeDetails.value.data.education[index].empInstituteName ?? ""),
                          "emp_course_type": TextEditingController(
                              text:  partnerController.employeeDetails.value.data.education[index].empCourseType ?? ""),
                          "emp_course_grade": TextEditingController(
                              text:  partnerController.employeeDetails.value.data.education[index].empCourseGrade ?? ""),
                          "emp_course_start": TextEditingController(
                              text:  partnerController.employeeDetails.value.data.education[index].empCourseStart ?? ""),
                          "emp_course_end": TextEditingController(
                              text:  partnerController.employeeDetails.value.data.education[index].empCourseEnd ?? ""),
                          "emp_skills": TextEditingController(),
                        }));
                    if (educationFieldList.isNotEmpty) {
                      educationFieldList.removeAt(0);
                    }
                    return ListView.builder(
                      itemCount: educationFieldList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(index!=0)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0.r),
                                child: DottedDashedLine(
                                  height: 1.r,
                                  width: Get.width,
                                  axis: Axis.horizontal,
                                  dashColor: AllColors.red.withOpacity(0.5),
                                ),
                              ),
                            UnderLineTextField(
                              controller: educationFieldList.value[index]['emp_course_name'],
                              labelText: "Course Name".tr,
                              hint: "Course Name".tr,
                              label: true,
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(right: 3.0.r),
                                child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                              ),
                              icon: true,
                              isRead: true,
                              type: TextInputType.text,
                            ),
                            SizedBox(height: 5.r),
                            UnderLineTextField(
                              controller: educationFieldList.value[index]['emp_institute_name'],
                              labelText: "Institute Name".tr,
                              hint: "Institute Name".tr,
                              label: true,
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(right: 3.0.r),
                                child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                              ),
                              icon: true,
                              isRead: true,
                              type: TextInputType.text,
                            ),
                            SizedBox(height: 5.r),
                            UnderLineTextField(
                              controller: educationFieldList.value[index]['emp_course_type'],
                              labelText: "Course Type".tr,
                              hint: "Course Type".tr,
                              label: true,
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(right: 3.0.r),
                                child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                              ),
                              icon: true,
                              isRead: true,
                              type: TextInputType.text,
                            ),
                            SizedBox(height: 5.r),
                            UnderLineTextField(
                              controller: educationFieldList.value[index]['emp_course_grade'],
                              labelText: "Grade (Percentage)".tr,
                              hint: "Grade (Percentage)".tr,
                              label: true,
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(right: 3.0.r),
                                child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                              ),
                              icon: true,
                              isRead: true,
                              type: TextInputType.text,
                            ),
                            SizedBox(height: 5.r),
                            Row(
                              children: [
                                Expanded(
                                  child: UnderLineTextField(
                                    controller: educationFieldList.value[index]['emp_course_start'],
                                    labelText: "Start Date".tr,
                                    hint: "Start Date".tr,
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
                                ),
                                SizedBox(width: 15.r),
                                Expanded(
                                    child: UnderLineTextField(
                                      controller: educationFieldList.value[index]['emp_course_end'],
                                      labelText: "End Date".tr,
                                      hint: "End Date".tr,
                                      label: true,
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.only(right: 3.0.r),
                                        child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                                      ),
                                      icon: true,
                                      isRead: true,
                                      type: TextInputType.text,
                                      length: 30,
                                    )
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  }),
            ],
          ),
          SizedBox(height: 15.r),
          TitleWidget(
            count: 3,
            title: "Experience".tr,
            icon: true,
            children: [
              GetBuilder<LoginController>(builder:(controller) {
                experienceFieldList.addAll(List.generate(
                    partnerController.employeeDetails.value.data.exprience.length,
                        (index) => {
                      "emp_designation":  TextEditingController(text:  partnerController.employeeDetails.value.data.exprience[index].empDesignation ?? ""),
                      "emp_company": TextEditingController(text:  partnerController.employeeDetails.value.data.exprience[index].empCompany ?? ""),
                      "emp_function": TextEditingController(text:  partnerController.employeeDetails.value.data.exprience[index].empFunction ?? ""),
                      "emp_industry": TextEditingController(text:  partnerController.employeeDetails.value.data.exprience[index].empIndustry ?? ""),
                      "emp_company_size": TextEditingController(text:  partnerController.employeeDetails.value.data.exprience[index].empCompanySize.toString()),
                      "emp_joining_salary": TextEditingController(text:  partnerController.employeeDetails.value.data.exprience[index].empJoiningSalary.toString()),
                      "emp_last_salary": TextEditingController(text:  partnerController.employeeDetails.value.data.exprience[index].empLastSalary.toString()),
                      "emp_job_start_date": TextEditingController(text:  partnerController.employeeDetails.value.data.exprience[index].empJobStartDate ?? ""),
                      "emp_job_end_date": TextEditingController(text:  partnerController.employeeDetails.value.data.exprience[index].empJobEndDate ?? ""),
                    }));
                if (experienceFieldList.isNotEmpty) {
                  experienceFieldList.removeAt(0);
                }
                return ListView.builder(
                  itemCount: experienceFieldList.value.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return Column(
                      children: [
                        if(index!=0)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0.r),
                            child: DottedDashedLine(
                              height: 1.r,
                              width: Get.width,
                              axis: Axis.horizontal,
                              dashColor: AllColors.red.withOpacity(0.5),
                            ),
                          ),
                        UnderLineTextField(
                          controller: experienceFieldList.value[index]['emp_designation'],
                          labelText: "Designation".tr,
                          hint: "Designation".tr,
                          label: true,
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 3.0.r),
                            child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                          ),
                          icon: true,
                          isRead: true,
                          type: TextInputType.text,
                        ),
                        SizedBox(height: 5.r),
                        UnderLineTextField(
                          controller: experienceFieldList.value[index]['emp_company'],
                          labelText: "Company Name".tr,
                          hint: "Company Name".tr,
                          label: true,
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 3.0.r),
                            child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                          ),
                          icon: true,
                          isRead: true,
                          type: TextInputType.text,
                          length: 50,
                        ),
                        SizedBox(height: 5.r),
                        UnderLineTextField(
                          controller: experienceFieldList.value[index]['emp_industry'],
                          labelText: "Industry".tr,
                          hint: "Industry".tr,
                          label: true,
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 3.0.r),
                            child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                          ),
                          icon: true,
                          isRead: true,
                          type: TextInputType.text,
                        ),
                        SizedBox(height: 5.r),
                        UnderLineTextField(
                          controller: experienceFieldList.value[index]['emp_company_size'],
                          labelText: "Company Size".tr,
                          hint: "Company Size".tr,
                          label: true,
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 3.0.r),
                            child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                          ),
                          icon: true,
                          isRead: true,
                          type: TextInputType.text,
                        ),
                        SizedBox(height: 5.r),
                        Row(
                          children: [
                            Expanded(
                              child: UnderLineTextField(
                                controller: experienceFieldList.value[index]['emp_joining_salary'],
                                labelText: "Joining Salary".tr,
                                hint: "Joining Salary".tr,
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
                            ),
                            SizedBox(width: 15.r),
                            Expanded(
                              child: UnderLineTextField(
                                controller: experienceFieldList.value[index]['emp_last_salary'],
                                labelText: "Last Salary".tr,
                                hint: "Last Salary".tr,
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
                            ),
                          ],
                        ),
                        SizedBox(height: 5.r),
                        Row(
                          children: [
                            Expanded(
                              child: UnderLineTextField(
                                controller: experienceFieldList.value[index]['emp_job_start_date'],
                                labelText: "Start Date".tr,
                                hint: "Start Date".tr,
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
                            ),
                            SizedBox(width: 15.r),
                            Expanded(
                                child: UnderLineTextField(
                                  controller: experienceFieldList.value[index]['emp_job_end_date'],
                                  labelText: "End Date".tr,
                                  hint: "End Date".tr,
                                  label: true,
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.only(right: 3.0.r),
                                    child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                                  ),
                                  icon: true,
                                  isRead: true,
                                  type: TextInputType.text,
                                  length: 30,
                                )
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              }),
            ],
          ),
          if(partnerController.employeeDetails.value.data.basicDetails.reqApproverId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim())
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(widget.pageName.toString()=="employeeRequest")
                  SizedBox(height: 15.r),
                if(widget.pageName.toString()=="employeeRequest")
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0.r),
                    child: Form(
                      key: _employeePushbackRemarksFormKey,
                      child: EditTextFiled(
                        controller: remarks,
                        hint: "Remarks".tr,
                        label: "Remarks",
                        validator: (value) {
                          if(value==null||value==""){
                            return "please fill remarks ";
                          } else{
                            return null;
                          }
                        },
                        keyboardtype: TextInputType.text,
                        maxline: 6,
                        minline: 1,
                        maxLength: 100,
                      ),
                    ),
                  ),
                if(widget.pageName.toString()=="employeeRequest")
                  SizedBox(height: 15.r),
                if(widget.pageName.toString()=="employeeRequest")
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal:15.0.r),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          title: "Approve".tr,
                          width: 120.r,
                          bgColor: AllColors.green,
                          background: false,
                          height: 35.r,
                          radius: 0,
                          onTap: ()async{
                            if (_employeePushbackRemarksFormKey.currentState != null && _employeePushbackRemarksFormKey.currentState!.validate()) {
                              bool status = await controller.updateEmployeeRequestNetworkApi(partnerController.employeeDetails.value.data.basicDetails.eid??"","active", remarks.text);
                              if(status==true){
                                controller.employeeRequestNetworkApi();
                                Get.off(()=> const DashboardScreen());
                                employeeHomeTab.value=2;
                              }
                            }
                          },
                        ),
                        CustomButton(
                          title: "Push back".tr,
                          width: 120.r,
                          // bgColor: AllColors.green,
                          background: true,
                          height: 35.r,
                          radius: 0,
                          onTap: ()async{
                            if (_employeePushbackRemarksFormKey.currentState != null && _employeePushbackRemarksFormKey.currentState!.validate()) {
                              bool status = await controller.updateEmployeeRequestNetworkApi(partnerController.employeeDetails.value.data.basicDetails.eid??"","push-back", remarks.text);
                              if(status==true){
                                controller.employeeRequestNetworkApi();
                                Get.off(()=> const DashboardScreen());
                                employeeHomeTab.value=2;
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
              ],
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
                                TextSpan(text: remarksData.remarkDateTime??"", style: fontSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),wordSpacing: 0, letterSpacing: 0, fontSize: 11.r, overflow: TextOverflow.ellipsis)),
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
