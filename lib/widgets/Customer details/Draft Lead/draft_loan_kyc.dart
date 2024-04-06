import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/Customer%20details/my_loan_history_details.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CustomerDraftLoanKyc extends StatefulWidget {
  final String? leadId;
  const CustomerDraftLoanKyc({super.key, required this.leadId});

  @override
  State<CustomerDraftLoanKyc> createState() => _CustomerDraftLoanKycState();
}

class _CustomerDraftLoanKycState extends State<CustomerDraftLoanKyc> {
  var controller =  Get.find<PartnerController>();

  @override
  void initState() {
    saveLeadData();
    super.initState();
  }

  saveLeadData()async{
    bool status = await controller.getLeadDetailsNetworkApi(widget.leadId);
    if(status==true){
      controller.loanPanCard.text = controller.getLeadDetails.value.data.custPan ?? "";
      controller.loanAadharCard.text =  controller.getLeadDetails.value.data.custAadhar ?? "";
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0.r),
                          child: UnderLineTextField(
                            labelText: "Enter PAN Number".tr,
                            hint: "Enter PAN Number".tr,
                            label: true,
                            controller: controller.loanPanCard,
                            type: TextInputType.text,
                          ),
                        ),
                      ],
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0.r),
                          child: UnderLineTextField(
                            controller: controller.loanAadharCard,
                            hint: "Enter Aadhaar Number".tr,
                            label: true,
                            icon: true,
                            type: TextInputType.number,
                            length: 12,
                            suffixIcon: Lottie.asset(Images.success, height: 25.r, width: 25.r,),
                          ),
                        ),
                      ],
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
            SizedBox(height: 15.r),
            CustomButton(
              title: "Update".tr,
              background: true,
              radius: 5.r,
              height: 35.r,
              width: Get.width - 60,
              onTap: () async{
                bool status = await controller.updateLoanLeadKYCdNetworkApi(
                  controller.getLeadDetails.value.data.leadId??"",
                );
                if(status==true){
                  myLoanHistoryDetailsTab.value = 4;
                }
              },
            ),
            SizedBox(height: 10.r),
          ],
        );
      },
    );
  }
}
