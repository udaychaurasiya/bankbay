// ignore_for_file: invalid_use_of_protected_member, unnecessary_null_comparison

import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_dropdown.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/widgets/Employee/create_employee.dart';
import 'package:bank_bay/widgets/Employee/employee_home.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  LoginController controller = Get.find<LoginController>();
  final _controller = Get.find<PartnerController>();
  GlobalKey<FormState> formKeyAddPartnerDetails = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyEducation = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyExperience = GlobalKey<FormState>();
  RxInt gradeValueTab = 1.obs;
  TextEditingController grade = TextEditingController();
  TextEditingController percentage = TextEditingController();
  GlobalKey<FormState> formKeyGrade = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyPercentage = GlobalKey<FormState>();

  @override
  void initState() {
    controller.getCountryNetworkApi(context);
    _controller.check_assign_approval_exist_model.value.data.clear();
    controller.educationFieldList.value.clear();
    controller.employeeRefreshList();
    controller.educationFieldList.value.add({
      "emp_institute_name":  TextEditingController(),
      "emp_course_name": TextEditingController(),
      "emp_course_type": null,
      "emp_course_start": TextEditingController(),
      "emp_course_end": TextEditingController(),
      "emp_course_grade": TextEditingController(),
      "emp_skills": TextEditingController(),
    });
    controller.experienceFieldList.clear();
    controller.experienceFieldList.value.add({
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
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AllColors.white,
      child: Column(
        children: [
          Form(
            key: formKeyAddPartnerDetails,
            child: TitleWidget(
              count: 1,
              title: "Basic Details".tr,
              icon: true,
              children: [
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
                        print("value $value");
                        controller.emp_gender.value=value.toLowerCase();
                      },
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    print("jhkh $newValue");
                  },
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
                        print("value $value");
                        controller.emp_marital_status.value=value.toLowerCase();
                      },
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    print("jhkh $newValue");
                  },
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
                  items: ["Select Qualification", "High School", "Graduation", "Masters", "Phd", "Certificate", "Diploma","Mca"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                      onTap: (){
                        print("value $value");
                        controller.emp_highest_qualification.value=value.toLowerCase();
                      },
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    print("jhkh $newValue");
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please qualification';
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
                ),
                SizedBox(height: 5.r),
                UnderLineTextField(
                  labelText: "Linkedin Link".tr,
                  hint: "Linkedin Link".tr,
                  label: true,
                  controller: controller.emp_linkedin,
                  type: TextInputType.text,
                ),
                SizedBox(height: 2.r),
                // Obx(() => DropdownButtonFormField(
                //     isExpanded: true,
                //     value: controller.selectCountry,
                //     items: controller.countryModel.value.data.map((CountryData items) {
                //       return DropdownMenuItem(
                //         value: items,
                //         child: Text(items.countryName.toString()),
                //       );
                //     }).toList(),
                //     hint: Text(
                //       "Country",
                //       style: fontSmall.copyWith(
                //         wordSpacing: 0.2,
                //         letterSpacing: 0.8,
                //         fontWeight: FontWeight.w400,
                //         color: AllColors.black.withOpacity(0.7),
                //         overflow: TextOverflow.ellipsis,
                //       ),
                //     ),
                //     onChanged: (dynamic newValue) {
                //       controller.selectCountry = newValue;
                //       controller.emp_country.text = newValue.countryName.toString();
                //       controller.countryModel.refresh();
                //       print("countrydsds ${newValue.id.toString()}");
                //       controller.selectState = null;
                //       controller.getStateNetworkApi(controller.selectCountry.id.toString());
                //     },
                //   )),
                // SizedBox(height: 8.r),
                // Obx(() => controller.stateModel.value.data.isNotEmpty
                //       ? DropdownButtonFormField(
                //         value: controller.selectState,
                //         items: controller.stateModel.value.data.map((StateData items){
                //           return DropdownMenuItem(
                //             value: items,
                //             child: Text(items.stateName.toString()),
                //           );
                //         }).toList(),
                //         hint: Text("State",style: fontSmall.copyWith(
                //           wordSpacing: 0.2,
                //           letterSpacing: 0.8,
                //           fontWeight: FontWeight.w400,
                //           color: AllColors.black.withOpacity(0.7),
                //           overflow: TextOverflow.ellipsis,
                //         ),),
                //         onChanged: (dynamic newValue) {
                //           controller.selectState=newValue;
                //           print("state ${newValue.id}");
                //           controller.emp_state.text= newValue.stateName.toString();
                //           controller.stateModel.refresh();
                //         },
                //       )
                //       : Container()),
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
                CustomUnderLineTextField(
                  controller: controller.emp_password,
                  type: TextInputType.text,
                  prefixIconColor: AllColors.black.withOpacity(0.5),
                  isPassword: true,
                  boldNon: true,
                  hint: "Enter Password",
                  prefixIcon: Icons.lock_open_outlined,
                  validator: (passwordValue) {
                    RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                    var passNonNullValue=passwordValue??"";
                    if(passNonNullValue.isEmpty){
                      return ("Password is required");
                    }
                    else if(passNonNullValue.length < 8){
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
                  preIcon: true,
                ),

              ],
            ),
          ),
          SizedBox(height: 15.r),
          Form(
            key: formKeyEducation,
            child: TitleWidget(
              count: 2,
              title: "Education".tr,
              icon: true,
              children: [
                GetBuilder<LoginController>(builder:(controller){
                  return ListView.builder(
                      itemCount: controller.educationFieldList.value.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(index!=0)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0.r),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(index.toString(),
                                      style: fontBold.copyWith(color: Colors.red, fontSize:12.r),),
                                    SizedBox(width: 5.r),
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
                              controller: controller.educationFieldList.value[index]['emp_course_name'],
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
                              controller: controller.educationFieldList.value[index]['emp_institute_name'],
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
                              items: ["Select Course Type", "MBA", "B.Tech", "M.Tech", "High School", "Graduation", "Masters", "Phd", "Certificate", "Diploma","Mca"].map((String value) {
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
                                controller.educationFieldList.value[index]['emp_course_type']=newValue??"Select Course Type";
                                controller.emp_add_course_type.value=controller.educationFieldList.value[index]['emp_course_type'];
                                controller.educationFieldList.refresh();
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select course type';
                                }
                                return null;
                              },
                              hint: "Course Type",
                            ),
                            SizedBox(height: 8.r),
                            // CustomUnderlineDropdownField(
                            //   items: ["Select Grade", "Garde A", "Grade B", "Grade C"].map((String value) {
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
                            //     controller.educationFieldList.value[index]['emp_course_grade']=newValue??"Select Grade";
                            //     controller.emp_add_grade.value=controller.educationFieldList.value[index]['emp_course_grade'];
                            //     controller.educationFieldList.refresh();
                            //   },
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return 'Please select marital status';
                            //     }
                            //     return null;
                            //   },
                            //   hint: "Grade (Percentage)",
                            // ),
                            UnderLineTextField(
                              controller: controller.educationFieldList.value[index]['emp_course_grade'],
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
                                grade.clear();
                                percentage.clear();
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
                                                        grade.clear();
                                                        percentage.clear();
                                                        gradeValueTab.value=1;
                                                      },
                                                      child: AnimatedContainer(
                                                        curve: Curves.linearToEaseOut,
                                                        duration: const Duration(milliseconds: 200),
                                                        alignment: Alignment.center,
                                                        padding: EdgeInsets.symmetric(horizontal: 16.r),
                                                        decoration: BoxDecoration(
                                                          color: gradeValueTab.value==1?AllColors.themeColor:AllColors.none,
                                                          // border: Border(bottom: BorderSide(width: 3.r, ))
                                                        ),
                                                        child: Text("Grade".tr,
                                                          style:  fontMedium.copyWith(fontSize: 14.r, wordSpacing: 0,letterSpacing: 0.4,color: gradeValueTab.value==1?AllColors.white.withOpacity(0.9):AllColors.themeColor),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: (){
                                                        grade.clear();
                                                        percentage.clear();
                                                        gradeValueTab.value=2;
                                                      },
                                                      child: AnimatedContainer(
                                                        curve: Curves.linearToEaseOut,
                                                        duration: const Duration(milliseconds: 200),
                                                        alignment: Alignment.center,
                                                        padding: EdgeInsets.symmetric(horizontal: 16.r),
                                                        decoration: BoxDecoration(
                                                          color: gradeValueTab.value==2?AllColors.themeColor:AllColors.none,
                                                        ),
                                                        child: Text("Percentage".tr,
                                                          style:  fontMedium.copyWith(fontSize: 14.r, wordSpacing: 0,letterSpacing: 0.4,color: gradeValueTab.value==2?AllColors.white.withOpacity(0.9):AllColors.themeColor),
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
                                                  if(gradeValueTab.value==1){
                                                    return Form(
                                                      key: formKeyGrade,
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
                                                              grade.text = newValue ?? "Select Grade";
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
                                                              if (formKeyGrade.currentState != null && formKeyGrade.currentState!.validate()) {
                                                                //   print("object ${grade.text.toString()}");
                                                                Navigator.pop(context);
                                                                controller.educationFieldList.value[index]['emp_course_grade'].text = grade.text.toString();
                                                                print("jhjd ${controller.educationFieldList.value[index]['emp_course_grade'].text}");
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }else if(gradeValueTab.value==2){
                                                    return Form(
                                                      key: formKeyPercentage,
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
                                                            controller: percentage,
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
                                                              if (formKeyPercentage.currentState != null && formKeyPercentage.currentState!.validate()) {
                                                                // print("object ${percentage.text.toString()}");
                                                                Navigator.pop(context);
                                                                controller.educationFieldList.value[index]['emp_course_grade'].text = "${percentage.text}%";
                                                                // print("jhjd ${controller.educationFieldList.value[index]['emp_course_grade'].text}");
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
                                    controller: controller.educationFieldList.value[index]['emp_course_start'],
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
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                        dateFormat: "yyyy-MM-dd",
                                        locale: DateTimePickerLocale.en_us,
                                        looping: true,
                                      );
                                      controller.educationFieldList.value[index]['emp_course_start'].text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString()));
                                      controller.emp_start_date.value=controller.educationFieldList.value[index]['emp_course_start'];
                                      controller.educationFieldList.refresh();
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
                                      controller: controller.educationFieldList.value[index]['emp_course_end'],
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
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2030),
                                          dateFormat: "yyyy-MM-dd",
                                          locale: DateTimePickerLocale.en_us,
                                          looping: true,
                                        );
                                        controller.educationFieldList.value[index]['emp_course_end'].text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString()));
                                        controller.emp_end_date.value=controller.educationFieldList.value[index]['emp_course_end'];
                                        controller.educationFieldList.refresh();
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
                },
                ),
                SizedBox(height: 20.r),
                Container(
                  padding: EdgeInsets.only(right: 5.r),
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: (){
                      if (formKeyEducation.currentState != null && formKeyEducation.currentState!.validate()) {
                        controller.educationAddField();
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
              ],
            ),
          ),
          SizedBox(height: 15.r),
          Form(
            key: formKeyExperience,
            child: TitleWidget(
              count: 3,
              title: "Experience".tr,
              icon: true,
              children: [
                GetBuilder<LoginController>(builder:(controller){
                  return ListView.builder(
                    itemCount: controller.experienceFieldList.value.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      controller.employeeRefreshList();
                      return Column(
                        children: [
                          if(index!=0)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0.r),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(index.toString(),
                                    style: fontBold.copyWith(color: Colors.red, fontSize:12.r),),
                                  SizedBox(width: 5.r),
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
                            controller: controller.experienceFieldList.value[index]['emp_designation'],
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
                            controller: controller.experienceFieldList.value[index]['emp_company'],
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
                            items: ["Select Job Level", "IT-Software", "Finance", "Operations", "Other"].map((String value) {
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
                              controller.experienceFieldList.value[index]['emp_function']=newValue??"Select Job Level";
                              controller.emp_add_function.value=controller.experienceFieldList.value[index]['emp_function'];
                              controller.experienceFieldList.refresh();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select job level';
                              }
                              return null;
                            },
                            hint: "Job Level",
                          ),
                          SizedBox(height: 8.r),
                          CustomUnderlineDropdownField(
                            items: ["Select Industry", "Telecom", "ITES", "Plastics","Retail","Textile","Other"].map((String value) {
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
                              controller.educationFieldList.value[index]['emp_industry']=newValue??"Select Industry";
                              controller.emp_add_industry.value=controller.educationFieldList.value[index]['emp_industry'];
                              controller.educationFieldList.refresh();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select Industry';
                              }
                              return null;
                            },
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
                              controller.experienceFieldList.value[index]['emp_company_size']=newValue??"Select Company Size";
                              controller.emp_add_company_size.value=controller.experienceFieldList.value[index]['emp_company_size'];
                              controller.experienceFieldList.refresh();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select company size';
                              }
                              return null;
                            },
                            hint: "Company Size",
                          ),
                          SizedBox(height: 8.r),
                          Row(
                            children: [
                              Expanded(
                                child: UnderLineTextField(
                                  controller: controller.experienceFieldList.value[index]['emp_joining_salary'],
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
                                  controller: controller.experienceFieldList.value[index]['emp_last_salary'],
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
                                  controller: controller.experienceFieldList.value[index]['emp_job_start_date'],
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
                                    controller.experienceFieldList.value[index]['emp_job_start_date'].text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString())).toString();
                                    controller.emp_join_start_date.value=controller.experienceFieldList.value[index]['emp_job_start_date'].text;
                                    controller.experienceFieldList.refresh();
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
                                    controller: controller.experienceFieldList.value[index]['emp_job_end_date'],
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
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2030),
                                        dateFormat: "yyyy-MM-dd",
                                        locale: DateTimePickerLocale.en_us,
                                        looping: true,
                                      );
                                      controller.experienceFieldList.value[index]['emp_job_end_date'].text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString())).toString();
                                      controller.emp_join_end_date.value=controller.experienceFieldList.value[index]['emp_job_end_date'].text;
                                      controller.experienceFieldList.refresh();
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
                      if (formKeyExperience.currentState != null && formKeyExperience.currentState!.validate()) {
                        controller.experienceAddField();
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
              ],
            ),
          ),
          SizedBox(height: 20.r),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:15.0.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  title: "Save Draft".tr,
                  width: 140.r,
                  bgColor: AllColors.green,
                  background: false,
                  height: 38.r,
                  radius: 0,
                  onTap: ()async{
                    bool status = await  controller.addEmployeeAboutNetworkApi("1");
                    if (status == true) {
                      employeeHomeTab.value=4;
                    }
                  },
                ),
                CustomButton(
                  title: "Next".tr,
                  width: 140.r,
                  // bgColor: AllColors.green,
                  background: true,
                  height: 38.r,
                  radius: 0,
                  onTap: ()async{
                    if ((formKeyAddPartnerDetails.currentState != null && formKeyAddPartnerDetails.currentState!.validate())||
                        (formKeyEducation.currentState != null && formKeyEducation.currentState!.validate())) {
                      bool status = await controller.addEmployeeAboutNetworkApi("2");
                      if (status == true) {
                        addEMPTab.value=2;
                      }
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20.r),
        ],
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
            controller.experienceDeleteField(index);
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
            controller.educationDeleteField(index);
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


class MyTabBarDialog extends StatefulWidget {
  final int index;
  const MyTabBarDialog({super.key, required this.index});

  @override
  State<MyTabBarDialog> createState() => _MyTabBarDialogState();
}

class _MyTabBarDialogState extends State<MyTabBarDialog> {
  LoginController controller = Get.find<LoginController>();
  RxInt gradeValueTab = 1.obs;
  TextEditingController grade = TextEditingController();
  TextEditingController percentage = TextEditingController();
  GlobalKey<FormState> formKeyGrade = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyPercentage = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                          grade.clear();
                          percentage.clear();
                          gradeValueTab.value=1;
                        },
                        child: AnimatedContainer(
                          curve: Curves.linearToEaseOut,
                          duration: const Duration(milliseconds: 200),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 16.r),
                          decoration: BoxDecoration(
                            color: gradeValueTab.value==1?AllColors.themeColor:AllColors.none,
                            // border: Border(bottom: BorderSide(width: 3.r, ))
                          ),
                          child: Text("Grade".tr,
                            style:  fontMedium.copyWith(fontSize: 14.r, wordSpacing: 0,letterSpacing: 0.4,color: gradeValueTab.value==1?AllColors.white.withOpacity(0.9):AllColors.themeColor),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          grade.clear();
                          percentage.clear();
                          gradeValueTab.value=2;
                        },
                        child: AnimatedContainer(
                          curve: Curves.linearToEaseOut,
                          duration: const Duration(milliseconds: 200),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 16.r),
                          decoration: BoxDecoration(
                            color: gradeValueTab.value==2?AllColors.themeColor:AllColors.none,
                          ),
                          child: Text("Percentage".tr,
                            style:  fontMedium.copyWith(fontSize: 14.r, wordSpacing: 0,letterSpacing: 0.4,color: gradeValueTab.value==2?AllColors.white.withOpacity(0.9):AllColors.themeColor),
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
                  if(gradeValueTab.value==1){
                    return Form(
                      key: formKeyGrade,
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
                              grade.text = newValue ?? "Select Grade";
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
                              // if (formKeyGrade.currentState != null && formKeyGrade.currentState!.validate()) {
                              //   print("object ${grade.text.toString()}");
                                controller.educationFieldList.value[widget.index]['emp_course_grade'].text = grade.text;
                                Navigator.of(context);
                              // }
                            },
                          ),
                        ],
                      ),
                    );
                  }else if(gradeValueTab.value==2){
                    return Form(
                      key: formKeyPercentage,
                      child: Column(
                        children: [
                          SizedBox(height: 20.r),
                          UnderLineTextField(
                            labelText: "Percentage".tr,
                            hint: "Percentage".tr,
                            label: true,
                            type: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            length: 2,
                            controller: percentage,
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
                              if (formKeyPercentage.currentState != null && formKeyPercentage.currentState!.validate()) {
                                print("object ${percentage.text.toString()}");
                                controller.educationFieldList.value[widget.index]['emp_course_grade'].text = percentage.text;
                                Navigator.of(context);
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
                    padding: EdgeInsets.symmetric(horizontal: 5.r, vertical: 3.r),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.r),
            child: Column(
              children: widget.children,
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
