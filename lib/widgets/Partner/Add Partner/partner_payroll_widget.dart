// ignore_for_file: unnecessary_null_comparison

import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_dropdown.dart';
import 'package:bank_bay/utils_method/uppercase_formate.dart';
import 'package:bank_bay/widgets/Partner/create_partner.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PartnerPayrollScreen extends StatefulWidget {
  const PartnerPayrollScreen({super.key});

  @override
  State<PartnerPayrollScreen> createState() => _PartnerPayrollScreenState();
}

class _PartnerPayrollScreenState extends State<PartnerPayrollScreen> {
  var controller = Get.find<PartnerController>();
  GlobalKey<FormState> formKeyAddPartnerPayroll = GlobalKey<FormState>(debugLabel: "_addEMPPayroll");

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AllColors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.0.r),
      margin: EdgeInsets.only(bottom: 10.0.r),
      child: Form(
        key: formKeyAddPartnerPayroll,
        child: Column(
          children: [
            SizedBox(height: 5.r),
            TextFormField(
              controller: controller.supervisorId,
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
                    if (formKeyAddPartnerPayroll.currentState != null && formKeyAddPartnerPayroll.currentState!.validate()) {
                      controller.checkSupIdExistNetworkApi(controller.supervisorId.text);
                    }
                  },
                  child: Text("Check", style: fontBold.copyWith(color: AllColors.themeColor),),
                ),
              ),
            ),
            SizedBox(height: 10.r),
            CustomerCountView(
              title: "Partner referral ID".tr,
              value: "0000",
            ),
            SizedBox(height: 15.r),
            CustomerCountView(
              title: "Functional Unit".tr,
              value: "NA",
            ),
            SizedBox(height: 2.r),
            CustomUnderlineDropdownField(
              items: ["Beginner", "Practitioner", "Professional", "Star", "Gem", "Ambassador"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                  onTap: (){
                    print("value $value");
                    controller.partnerPayrollBrand.value=value;
                  },
                );
              }).toList(),
              onChanged: (String? newValue) {
                controller.partnerPayrollBrand.value = newValue??"Beginner";
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select gender';
                }
                return null;
              },
              value: controller.partnerPayrollBrand.value,
              hint: "Band",
            ),
            SizedBox(height: 15.r),
            CustomerCountView(
              title: "Partner initiation date".tr,
              value: "0",
            ),
            SizedBox(height: 15.r),
            CustomerCountView(
              title: "Partner approval date".tr,
              value: "0",
            ),
            SizedBox(height: 15.r),
            CustomerCountView(
              title: "Partner exit date".tr,
              value: "0",
            ),
            SizedBox(height: 30.r),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  title: "back".tr,
                  width: 140.r,
                  bgColor: AllColors.green,
                  background: false,
                  height: 38.r,
                  radius: 0,
                  onTap: ()async{
                    addPartnerTab.value = 6;
                  },
                ),
                CustomButton(
                  title: "Next".tr,
                  width: 140.r,
                  background: true,
                  height: 38.r,
                  radius: 0,
                  onTap: ()async{
                    if (formKeyAddPartnerPayroll.currentState != null && formKeyAddPartnerPayroll.currentState!.validate()) {
                      if((controller.supervisorId.text!=null&&controller.supervisorId.text!="")&&
                          (controller.check_supId_exist_model.value.data.isNotEmpty&&controller.check_supId_exist_model.value.data[0].eid!=null)){
                        bool status = await controller.partnerUpdatePayrollNetworkApi(
                            GetStorage().read(AppConstant.partner_id).toString().trim(),
                            controller.partnerPayrollBrand.value,
                            controller.check_supId_exist_model.value.data.isNotEmpty?
                            controller.check_supId_exist_model.value.data[0].eid:"");
                        if (status == true) {
                          controller.check_supId_exist_model.value.data.clear();
                          controller.supervisorId.clear();
                          controller.partnerPayrollBrand.value = "Beginner";
                          addPartnerTab.value = 8;
                        }
                      }else{
                        BaseController().errorSnack("Please fill supervisor Id and check it !!");
                      }
                    }
                  },
                )
              ],
            ),
            SizedBox(height: Get.height/8.4.r),
          ],
        ),
      ),
    );
  }
}

class CustomerCountView extends StatelessWidget {
  final String title;
  final String? value;
  const CustomerCountView({super.key, required this.title, this.value=""});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title : ",style: fontMedium.copyWith(fontSize: 13.r,color: AllColors.black.withOpacity(0.5)),),
        SizedBox(height: 5.r),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 10.r),
          color: AllColors.grey.withOpacity(0.2),
          child: Text(value.toString(),style: fontBold.copyWith(fontSize: 12.r,color: AllColors.black.withOpacity(0.6)),),
        ),
      ],
    );
  }
}