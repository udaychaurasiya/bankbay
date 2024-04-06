import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/widgets/Partner/create_partner.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';


class PartnerOtpVerification extends StatefulWidget {
  const PartnerOtpVerification({super.key});

  @override
  State<PartnerOtpVerification> createState() => _PartnerOtpVerificationState();
}

class _PartnerOtpVerificationState extends State<PartnerOtpVerification> {
  var controller = Get.find<PartnerController>();
  OtpFieldController apOtpController = OtpFieldController();
  GlobalKey<FormState> formKeyOtp = GlobalKey<FormState>(debugLabel: '_otpVerify');

  @override
  void initState() {
    controller.resetTimer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 20.r),
      color: AllColors.white.withOpacity(0.9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Please enter the one time password",
            style: fontSmall.copyWith(color: Colors.black.withOpacity(0.6)),
          ),
          SizedBox(height: 15.r),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Otp send to +91${controller.apNumber.text}",
                style: fontSmall.copyWith(
                    color: Colors.black.withOpacity(0.5),
                    wordSpacing: 0.2,
                    letterSpacing: 0.2
                ),
              ),
              SizedBox(width: 10.r),
              Obx(() => Text(
                DateFormat('ss:mm').format(
                    DateTime(0, 0, 0, 0, controller.seconds.value)),
                style: fontBold.copyWith(
                  fontSize: 16.r,
                  decoration: TextDecoration.underline,
                  color: controller.seconds.value==0?AllColors.red:AllColors.green,
                ),
              ),
              ),
            ],
          ),
          SizedBox(height: 20.r),
          SizedBox(
            width: Get.width - 80,
            height: 40.0.r,
            child: OTPTextField(
              length: 4,
              controller: apOtpController,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 50.0.w,
              style: fontRegular.copyWith(
                fontWeight: FontWeight.w600,
                color: AllColors.black.withOpacity(0.5),
                fontSize: 16.r,
              ),
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onChanged: (value) {
                controller.otpVerify.value = value;
              },
              onCompleted: (pin) async {
                controller.otpVerify.value = pin;
              },
            ),
          ),
          SizedBox(height: 25.r),
          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(controller.seconds.value != 00)
                Text("Please enter 4 digit code that send \nto your mobile number.", style: fontSmall.copyWith(
                    color: AllColors.black.withOpacity(0.6),
                    fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              if(controller.seconds.value == 00)
                Text("Didn't get the code ? ", style: fontMedium.copyWith(
                    color: AllColors.black.withOpacity(0.6),
                    fontWeight: FontWeight.w400),),
              if(controller.seconds.value == 00)
                InkWell(
                  onTap: ()async{
                    if (controller.seconds.value == 00) {
                      bool status = await controller.partnerResendOTPNetworkApi(context);
                      if(status==true){
                        controller.resetTimer();
                      }
                    }
                  },
                  child: Text(" Resend Otp ", style: fontMedium.copyWith(
                      color: AllColors.darkBlue.withOpacity(0.8),
                      fontWeight: FontWeight.w400),),
                ),
            ],
          ),
          ),
          SizedBox(height: 25.r),
          InkWell(
            onTap: ()=> addPartnerTab.value=1,
            child: Text("Edit Phone number", style: fontSmall.copyWith(
                color: AllColors.darkBlue.withOpacity(0.7),
                fontWeight: FontWeight.w400),),
          ),
          SizedBox(height: 30.r),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                title: "Next".tr,
                background: true,
                radius: 30.r,
                height: 30.r,
                width: Get.width - 240,
                onTap: () async{
                  bool status = await controller.partnerOtpVerificationApi(controller.otpVerify.value);
                  if(status==true){
                    addPartnerTab.value=4;
                    apOtpController.clear();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
