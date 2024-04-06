import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class UserOtpVerify extends StatefulWidget {
  const UserOtpVerify({Key? key}) : super(key: key);

  @override
  State<UserOtpVerify> createState() => _UserOtpVerifyState();
}

class _UserOtpVerifyState extends State<UserOtpVerify> {
   var controller = Get.find<LoginController>();
   final _controller = Get.find<PartnerController>();
   OtpFieldController otpController = OtpFieldController();

   @override
   void initState() {
     _controller.resetTimer();
     super.initState();
   }
   @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 20.r),
      color: AllColors.white.withOpacity(0.9),
      child: GetBuilder<LoginController>(builder:(controller) => Column(
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
                "Otp send to +91${GetStorage().read(AppConstant.phone).toString()}",
                style: fontSmall.copyWith(
                    color: Colors.black.withOpacity(0.5),
                    wordSpacing: 0.2,
                    letterSpacing: 0.2
                ),
              ),
              SizedBox(width: 10.r),
              Obx(() => Text(
                DateFormat('ss:mm').format(
                    DateTime(0, 0, 0, 0, _controller.seconds.value)),
                style: fontBold.copyWith(
                  fontSize: 16.r,
                  decoration: TextDecoration.underline,
                  color: _controller.seconds.value==0?AllColors.red:AllColors.green,
                ),
              ),
              ),
            ],
          ),
          SizedBox(height: 20.r),
          SizedBox(
            width: Get.width - 80,
            height: 40.0.r,
            child: Form(
              // key: _formKey,
              child: OTPTextField(
                length: 4,
                controller: otpController,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 50.0.w,
                style: fontRegular.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AllColors.black.withOpacity(0.5),
                  fontSize: 16.r,
                ),
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  // Allow only digits
                ],
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onChanged: (value) {
                  controller.phoneOtp.value = value;
                },
                onCompleted: (pin) async {
                  controller.phoneOtp.value = pin;
                },
              ),
            ),
          ),
          SizedBox(height: 25.r),
          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(_controller.seconds.value != 00)
                Text("Please enter 4 digit code that send \nto your mobile number.", style: fontSmall.copyWith(
                    color: AllColors.black.withOpacity(0.6),
                    fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              if(_controller.seconds.value == 00)
                Text("Didn't get the code ? ", style: fontMedium.copyWith(
                    color: AllColors.black.withOpacity(0.6),
                    fontWeight: FontWeight.w400),),
              if(_controller.seconds.value == 00)
                InkWell(
                  onTap: ()async{
                    if (_controller.seconds.value == 00) {
                      bool status = await _controller.profileResendOTPNetworkApi(context);
                      if(status==true){
                        _controller.resetTimer();
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
            onTap: ()=> indexValue.value=2,
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
                  bool status = await controller.otpVerificationApi(controller.phoneOtp.value);
                  if(status==true){
                    indexValue.value=7;
                  }
                },
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }
}
