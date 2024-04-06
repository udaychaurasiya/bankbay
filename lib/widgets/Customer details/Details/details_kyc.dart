import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/Customer%20details/Details/all_customer_details.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

class DetailsKyc extends StatefulWidget {
  final String leadId;
  final String pageName;
  const DetailsKyc({super.key, required this.pageName, required this.leadId});

  @override
  State<DetailsKyc> createState() => _DetailsKycState();
}

class _DetailsKycState extends State<DetailsKyc> {
  var controller = Get.find<PartnerController>();

  @override
  void initState() {
    saveData();
    super.initState();
  }
  saveData()async{
    bool status = await controller.getLeadDetailsNetworkApi(widget.leadId);
    if(status==true){
      controller.loanPanCard.text = controller.getLeadDetails.value.data.custPan??"";
      controller.loanAadharCard.text = controller.getLeadDetails.value.data.custAadhar??"";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(
      builder: (controller){
        return Column(
          children: [
            SizedBox(height: 15.r),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 120.r,
                  margin: EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 10.r),
                  padding: EdgeInsets.only(bottom: 10.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    shape: BoxShape.rectangle,
                  ),
                  child: DottedBorder(
                    borderType: BorderType.Rect,
                    radius: Radius.circular(5.r),
                    strokeWidth: 1.5.r,
                    dashPattern: const [4,3],
                    color: AllColors.blue.withOpacity(0.5),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20.0.r),
                      child:
                      ((controller.getLeadDetails.value.data.leadSource.toString()!=GetStorage().read(AppConstant.cust_id)&&
                          GetStorage().read(AppConstant.assignment_change_approval).toString().toLowerCase() == "yes")&&widget.pageName!="unassignedLead")?
                      UnderLineTextField(
                        labelText: "Enter PAN Number".tr,
                        hint: "Enter PAN Number".tr,
                        label: true,
                        controller: controller.loanPanCard,
                        type: TextInputType.text,
                        icon: controller.getLeadDetails.value.data.panVerifyStatus.toString().toLowerCase()=="yes"?true:false,
                        isRead: controller.getLeadDetails.value.data.panVerifyStatus.toString().toLowerCase()=="yes"?true:false,
                        suffixIcon: controller.getLeadDetails.value.data.panVerifyStatus.toString().toLowerCase()=="yes"? Padding(
                          padding: EdgeInsets.only(right: 3.0.r),
                          child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                        ) : null,
                      ) :
                      UnderLineTextField(
                        labelText: "Enter PAN Number".tr,
                        hint: "Enter PAN Number".tr,
                        label: true,
                        isRead: true,
                        controller: controller.loanPanCard,
                        type: TextInputType.text,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: Get.width/4-5.r,
                  top: 12.r,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10.r, left: 10.r, right: 10.r),
                    color: Colors.white,
                    child: Text(
                      "PAN Authentication",
                      style: fontMedium.copyWith(fontSize: 12.r),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.r),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 120.r,
                  margin: EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 10.r),
                  padding: EdgeInsets.only(bottom: 10.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    shape: BoxShape.rectangle,
                  ),
                  child: DottedBorder(
                    borderType: BorderType.Rect,
                    radius: Radius.circular(5.r),
                    strokeWidth: 1.5.r,
                    dashPattern: const [4,3],
                    color: AllColors.blue.withOpacity(0.5),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20.0.r),
                      child: ((controller.getLeadDetails.value.data.leadSource.toString()!=GetStorage().read(AppConstant.cust_id)&&
                          GetStorage().read(AppConstant.assignment_change_approval).toString().toLowerCase() == "yes")&&widget.pageName!="unassignedLead")?
                      UnderLineTextField(
                        controller: controller.loanAadharCard,
                        hint: "Enter Aadhaar Number".tr,
                        label: true,
                        icon: true,
                        type: TextInputType.number,
                        length: 12,
                        // suffixIcon: Lottie.asset(Images.success, height: 25.r, width: 25.r,),
                        isRead: controller.getLeadDetails.value.data.otpPhoneStatus.toString().toLowerCase()=="yes"?true:false,
                        suffixIcon: controller.getLeadDetails.value.data.otpPhoneStatus.toString().toLowerCase()=="yes"?Padding(
                          padding: EdgeInsets.only(right: 3.0.r),
                          child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                        ) : Lottie.asset(Images.success, height: 25.r, width: 25.r,),
                      ) : UnderLineTextField(
                        controller: controller.loanAadharCard,
                        hint: "Enter Aadhaar Number".tr,
                        label: true,
                        icon: true,
                        isRead: true,
                        type: TextInputType.number,
                        length: 12,
                        suffixIcon: Lottie.asset(Images.success, height: 25.r, width: 25.r,),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: Get.width/4-5.r,
                  top: 12.r,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10.r, left: 10.r, right: 10.r),
                    color: Colors.white,
                    child: Text(
                      "AADHAAR Authentication",
                      style: fontMedium.copyWith(fontSize: 12.r),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.r),
            ((controller.getLeadDetails.value.data.leadSource.toString()!=GetStorage().read(AppConstant.cust_id)&&
                GetStorage().read(AppConstant.assignment_change_approval).toString().toLowerCase() == "yes")&&widget.pageName!="unassignedLead")?
            Padding(
              padding: EdgeInsets.symmetric(horizontal:18.0.r),
              child: CustomButton(
                title: "Update".tr,
                background: true,
                height: 38.r,
                onTap: ()async{
                  bool status = await controller.updateLoanLeadKYCdNetworkApi(controller.getLeadDetails.value.data.leadId??"");
                  if (status == true) {
                    leadDetailsTab.value = 4;
                  }
                },
              ),
            ) : const SizedBox(),
            SizedBox(height: 10.r),
          ],
        );
      },
    );
  }
}
