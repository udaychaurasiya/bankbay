import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/widgets/Customer%20details/Partner%20Details/partner_pushback_details.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PartnerPushbackKYCScreen extends StatefulWidget {
  final String partnerId;
  const PartnerPushbackKYCScreen({super.key, required this.partnerId});

  @override
  State<PartnerPushbackKYCScreen> createState() => _PartnerPushbackKYCScreenState();
}
final PartnerController controller = Get.find<PartnerController>();

class _PartnerPushbackKYCScreenState extends State<PartnerPushbackKYCScreen> {
    TextEditingController panCard = TextEditingController();
    TextEditingController aadharCard = TextEditingController();

  @override
  void initState() {
    controller.getCustomerDetailsNetworkApi(widget.partnerId.toString());
    controller.pPushbackPanCard.text = controller.customerDetails.value.data.details.custPan??"";
    controller.pPushbackAadhaar.text = controller.customerDetails.value.data.details.custAadhar??"";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        controller: controller.pPushbackPanCard,
                        type: TextInputType.text,
                        // inputFormatters: [
                        //   UpperCaseTextFormatter(),
                        // ],
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
                        controller: controller.pPushbackAadhaar,
                        hint: "Enter Aadhaar Number".tr,
                        label: true,
                        type: TextInputType.number,
                        length: 12,
                        // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        suffixIcon: Lottie.asset(Images.success, height: 25.r, width: 25.r,),
                      ),
                    ),
                    // SizedBox(height: 5.r),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 20.0.r),
                    //   child: UnderLineTextField(
                    //     // controller: controller.etPanCard,
                    //     hint: "Enter OTP".tr,
                    //     label: false,
                    //     icon: true,
                    //     type: TextInputType.text,
                    //     length: 10,
                    //     suffixIcon: Text("Verify OTP",style: fontMedium.copyWith(fontSize: 12.r,wordSpacing: 0,letterSpacing: 0),),
                    //     validator: (value) {
                    //       if (value == null || value.isEmpty) {
                    //         return 'Please enter OTP';
                    //       }
                    //       return null;
                    //     },
                    //   ),
                    // ),
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
        SizedBox(height: 25.r),
        Padding(
          padding: EdgeInsets.symmetric(horizontal:15.0.r),
          child: CustomButton(
            title: "Next".tr,
            bgColor: AllColors.green,
            background: false,
            height: 38.r,
            radius: 0.r,
            onTap: ()async{
              bool status = await controller.partnerPushbackKycNetworkApi(controller.customerDetails.value.data.partnerdetails.custId);
              if(status==true){
                partnerPushbackDetailsTab.value = 3;
              }
            },
          ),
        ),
        SizedBox(height: 20.r),
      ],
    );
  }
}
