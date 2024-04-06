import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/Login/login_home.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class CreatePin extends StatefulWidget {
  const CreatePin({super.key});

  @override
  State<CreatePin> createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
  LoginController controller = Get.find<LoginController>();
  GlobalKey<FormState> formKeyPinCreate = GlobalKey<FormState>();
  final defaultPinTheme = PinTheme(
    width: 56.r,
    height: 56.r,
    margin: EdgeInsets.symmetric(horizontal: 8.r),
    textStyle: fontMedium.copyWith(
        fontSize: 25.r,
        color: AllColors.black.withOpacity(0.8),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: AllColors.blueDem, width: 2.r),
      color: AllColors.lightBlue,
    ),
  );
  final errorPinTheme = PinTheme(
    width: 56.r,
    height: 56.r,
    margin: EdgeInsets.symmetric(horizontal: 8.r),
    textStyle: fontMedium.copyWith(
        fontSize: 25.r,
        color: AllColors.black.withOpacity(0.8),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: AllColors.red, width: 2.r),
      color: AllColors.lightBlue,
    ),
  );

    @override
  Widget build(BuildContext context) {
    controller.generatePin.clear();
    return Form(
      key: formKeyPinCreate,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0.r),
            alignment: Alignment.centerLeft,
            child: Text(
              "Create New PIN",
              style: fontMedium.copyWith(
                  fontSize: 16.r, color: AllColors.white),
            ),
          ),
          SizedBox(height: 25.r),
          Pinput(
            controller: controller.generatePin,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: defaultPinTheme.copyDecorationWith(
              border: Border.all(color: AllColors.blueDem, width: 2.r),
              color: AllColors.white,
            ),
            submittedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                color: AllColors.white,
                border: Border.all(color: AllColors.blueDem, width: 2.r),
              ),
            ),
            errorPinTheme: errorPinTheme,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter new PIN';
              }
              return null;
            },
            pinputAutovalidateMode:
            PinputAutovalidateMode.onSubmit,
            showCursor: true,
            onCompleted: (pin) async{
              print("Pin $pin");
            },
          ),
          SizedBox(height: 25.r),
          CustomButton(
            title: "Validate with OTP".tr,
            background: false,
            bgColor: AllColors.darkBlue,
            width: Get.width - 60.r,
            height: 45.r,
            radius: 2.r,
            onTap: () async {
              if (formKeyPinCreate.currentState != null && formKeyPinCreate.currentState!.validate()) {
                if(controller.generatePin.text.length != 4){
                  print("ssssija Please enter 4 digit PIN");
                  BaseController().errorSnack("Please enter 4 digit PIN");
                }else{
                  pinValue.value = 3;
                }
              }
            },
          ),
          SizedBox(height: 25.r),
          InkWell(
            onTap: ()=> pinValue.value = 1,
            child: Text(
              "I know my PIN",
              style: fontRegular.copyWith(
                  color: AllColors.white.withOpacity(0.8),
                  wordSpacing: 0,
                  letterSpacing: 0.2),
            ),
          ),
        ],
      ),
    );
  }
}
