// ignore_for_file: unnecessary_null_comparison

import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_dropdown.dart';
import 'package:bank_bay/utils_method/uppercase_formate.dart';
import 'package:bank_bay/widgets/Customer%20details/Partner%20Details/partner_pushback_details.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PartnerPushbackPayrollScreen extends StatefulWidget {
  final String partnerId;
  const PartnerPushbackPayrollScreen({super.key, required this.partnerId});

  @override
  State<PartnerPushbackPayrollScreen> createState() => _PartnerPushbackPayrollScreenState();
}
class _PartnerPushbackPayrollScreenState extends State<PartnerPushbackPayrollScreen> {
  final PartnerController controller = Get.find<PartnerController>();
  TextEditingController pushbackSupervisorId = TextEditingController();
  var formKeyPushbackCheckSupId = GlobalKey<FormState>(debugLabel: "_formKeyPushbackCheckSupId");


  @override
  void initState() {
    saveData();
    controller.partnerRefreshList();
    controller.check_supId_exist_model.value.data.clear();
    super.initState();
  }
  saveData() async {
    bool status = await controller.getCustomerDetailsNetworkApi(widget.partnerId.toString());
    if(status==true){
      print("ggs ${controller.customerDetails.value.data.partnerdetails.supId}");
      pushbackSupervisorId.text = "${controller.customerDetails.value.data.partnerdetails.supId??""}";
      controller.partnerPushbackPayrollBrand.value = controller.partnerBandList[controller.partnerBandList.indexWhere((element2) => element2==controller.customerDetails.value.data.partnerdetails.partnerBand)!=-1?
      controller.partnerBandList.indexWhere((element2) => element2==controller.customerDetails.value.data.partnerdetails.partnerBand):0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(
      builder: (controller){
        controller.partnerRefreshList();
        return Column(
          children: [
            SizedBox(height: 10.r),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0.r),
              child: Column(
                children: [
                  Form(
                    key: formKeyPushbackCheckSupId,
                    child: TextFormField(
                      controller: pushbackSupervisorId,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value=="") {
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
                            if (formKeyPushbackCheckSupId.currentState != null && formKeyPushbackCheckSupId.currentState!.validate()) {
                              controller.checkSupIdExistNetworkApi(pushbackSupervisorId.text);
                            }
                          },
                          child: Text("Check", style: fontBold.copyWith(color: AllColors.themeColor),),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.r),
                  CustomerCountView(
                    title: "Partner referral ID".tr,
                    value: controller.customerDetails.value.data.partnerdetails.partnerReference??"0000",
                  ),
                  SizedBox(height: 15.r),
                  CustomerCountView(
                    title: "Functional Unit".tr,
                    value: controller.customerDetails.value.data.partnerdetails.partnerStatus??"NA",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: controller.partnerBandList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerPushbackPayrollBrand.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      controller.partnerPushbackPayrollBrand.value = newValue ?? "Beginner";
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select gender';
                      }
                      return null;
                    },
                    value: controller.partnerPushbackPayrollBrand.value,
                    hint: "Band",
                  ),
                  SizedBox(height: 15.r),
                  CustomerCountView(
                    title: "Partner initiation date".tr,
                    value: controller.customerDetails.value.data.partnerdetails.partnerJoinDate??"00-00-0000",
                  ),
                  SizedBox(height: 15.r),
                  CustomerCountView(
                    title: "Partner approval date".tr,
                    value: controller.customerDetails.value.data.partnerdetails.partnerJoinDate??"00-00-0000",
                  ),
                  SizedBox(height: 15.r),
                  CustomerCountView(
                    title: "Partner exit date".tr,
                    value: controller.customerDetails.value.data.partnerdetails.partnerJoinDate??"00-00-0000",
                  ),
                  SizedBox(height: 25.r),
                  CustomButton(
                    title: "Next".tr,
                    bgColor: AllColors.green,
                    background: false,
                    height: 38.r,
                    radius: 0.r,
                    onTap: ()async{
                      if((pushbackSupervisorId.text!=null&&pushbackSupervisorId.text!="")&&
                          (controller.check_supId_exist_model.value.data.isNotEmpty&&controller.check_supId_exist_model.value.data[0].eid!=null)){
                        bool status = await controller.partnerUpdatePayrollNetworkApi(
                            controller.customerDetails.value.data.partnerdetails.pid,
                            controller.partnerPushbackPayrollBrand.value,
                            controller.check_supId_exist_model.value.data.isNotEmpty?
                            controller.check_supId_exist_model.value.data[0].eid:"");
                        if(status==true){
                          controller.check_supId_exist_model.value.data.clear();
                          partnerPushbackDetailsTab.value = 5;
                        }
                      }else{
                        BaseController().errorSnack("Please fill supervisor Id and check it !!");
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.r),
          ],
        );
      },
    );
  }
}

class CustomerCountView extends StatelessWidget {
  final String title;
  final String? value;
  const CustomerCountView({Key? key, required this.title, this.value=""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title : ",style: fontMedium.copyWith(fontSize: 13.r,color: AllColors.black.withOpacity(0.5)),),
        SizedBox(height: 2.r),
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
