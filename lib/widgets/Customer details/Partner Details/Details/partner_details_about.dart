// ignore_for_file: invalid_use_of_protected_member, unnecessary_null_comparison, use_build_context_synchronously
import 'dart:convert';

import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/edit_text_field.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/Partner/partner_home.dart';
import 'package:bank_bay/widgets/Profile/Model/user_details_model.dart';
import 'package:bank_bay/widgets/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PartnerDetailsAboutScreen extends StatefulWidget {
  final UserDetailsData partnerDetails;
  final String pageName;
  const PartnerDetailsAboutScreen({super.key, required this.partnerDetails, required this.pageName});

  @override
  State<PartnerDetailsAboutScreen> createState() => _PartnerDetailsAboutScreenState();
}

class _PartnerDetailsAboutScreenState extends State<PartnerDetailsAboutScreen> {
  GlobalKey<FormState> _partnerPushbackRemarksFormKey = GlobalKey<FormState>(debugLabel: '_formKeyAddPartnerForm');

  var partnerController = Get.find<PartnerController>();
    TextEditingController remarks = TextEditingController();
    TextEditingController partnerName = TextEditingController();
    TextEditingController dob = TextEditingController();
    TextEditingController gender = TextEditingController();
    TextEditingController marital = TextEditingController();
    TextEditingController highQualification = TextEditingController();
    TextEditingController eMail = TextEditingController();
    TextEditingController facebook = TextEditingController();
    TextEditingController linkedin = TextEditingController();
    // TextEditingController country = TextEditingController();
    // TextEditingController state = TextEditingController();
    TextEditingController pincode = TextEditingController();
    TextEditingController address = TextEditingController();
    TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder:(controller){
      if(widget.partnerDetails.details.custSocial.toString().isNotEmpty)
      {
        try{
          List<dynamic> custSocialList = json.decode(widget.partnerDetails.details.custSocial.toString());
          for (dynamic item in custSocialList) {
            String fabValue = item['fab'];
            String linkedinValue = item['linkdin'];
            facebook.text =fabValue;
            linkedin.text =linkedinValue;
          }
        }catch (e){
          print("error $e");
        }
      }
      partnerName.text = widget.partnerDetails.details.custName??"";
      dob.text = widget.partnerDetails.details.custDob??"";
      gender.text = widget.partnerDetails.details.custGender??"";
      marital.text = widget.partnerDetails.details.custMaritalStatus??"";
      highQualification.text = widget.partnerDetails.details.custEducation??"";
      eMail.text = widget.partnerDetails.details.custEmail??"";
      pincode.text = widget.partnerDetails.details.custPincode??"";
      address.text = widget.partnerDetails.details.custAddress??"";
      phone.text = widget.partnerDetails.details.custPhone??"";
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
                  controller: partnerName,
                  type: TextInputType.text,
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
            if(widget.partnerDetails.partnerdetails.reqApproverId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim())
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(widget.pageName.toString()=="partnerRequest")
                    SizedBox(height: 15.r),
                  if(widget.pageName.toString()=="partnerRequest")
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.r),
                      child: Form(
                        key: _partnerPushbackRemarksFormKey,
                        child: EditTextFiled(
                          controller: remarks,
                          hint: "Remarks".tr,
                          label: "Remarks",
                          validator: (value) {
                            if(value==null||value==""){
                              return "please fill remarks ";
                            }
                            else{
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
                  if(widget.pageName.toString()=="partnerRequest")
                    SizedBox(height: 15.r),
                  if(widget.pageName.toString()=="partnerRequest")
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
                              if (_partnerPushbackRemarksFormKey.currentState != null && _partnerPushbackRemarksFormKey.currentState!.validate()) {
                                bool status = await partnerController.partnerUpdateAboutNetworkApi(widget.partnerDetails.partnerdetails.pid.toString(), "active", remarks.text);
                                if(status==true){
                                  Get.off(()=> const DashboardScreen());
                                  partnerTab.value=3;
                                }
                              }
                            },
                          ),
                          CustomButton(
                            title: "Push back".tr,
                            width: 120.r,
                            background: true,
                            height: 35.r,
                            radius: 0,
                            onTap: ()async{
                              if (_partnerPushbackRemarksFormKey.currentState != null && _partnerPushbackRemarksFormKey.currentState!.validate()) {
                                bool status = await partnerController.partnerUpdateAboutNetworkApi(widget.partnerDetails.partnerdetails.pid.toString(), "push-back", remarks.text);
                                if(status==true){
                                  Get.off(()=> const DashboardScreen());
                                  partnerTab.value=3;
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            SizedBox(height: 10.r),
            ListView.builder(
              itemCount: widget.partnerDetails.remarks.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var remarksData = widget.partnerDetails.remarks[index];
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
