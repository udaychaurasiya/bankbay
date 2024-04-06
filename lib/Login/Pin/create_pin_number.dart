import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/Login/login_home.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreatePinNumber extends StatelessWidget {
  const CreatePinNumber({super.key});

  @override
  Widget build(BuildContext context) {
        LoginController controller = Get.find<LoginController>();
    GlobalKey<FormState> formKeyPinGenerate = GlobalKey<FormState>();
    return Column(
      children: [
        Form(
          key: formKeyPinGenerate,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:25.r),
            child: TextFormField(
              controller: controller.generateNumber,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone_android_outlined,
                    size: 22.r,
                    color: AllColors.white.withOpacity(0.6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 35.r,
                  ),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 35.r,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AllColors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AllColors.grey),
                  ),
                  counter: const Offstage(),
                  hintText: "Enter Mobile Number",
                  hintStyle: fontMedium.copyWith(
                      color: AllColors.white.withOpacity(0.8),fontSize: 16.r),
                  isDense: true,
                  contentPadding: EdgeInsets.only(top: 12.r,bottom: 10.r)),
              validator: (value) {
                if (value.toString().isEmpty) {
                  return "Please enter mobile No.";
                }
                if (value!.length != 10) {
                  return "Please enter 10 digits mobile number";
                }
                return null;
              },
              maxLength: 10,
              style: fontMedium.copyWith(
                  color: AllColors.white.withOpacity(0.8),
                  fontSize: 18.r),
            ),
          ),
        ),
        SizedBox(height: 25.r),
        CustomButton(
          title: "Send OTP".tr,
          background: false,
          bgColor: AllColors.darkBlue,
          width: Get.width - 60.r,
          height: 45.r,
          radius: 2.r,
          onTap: () async {
            if (formKeyPinGenerate.currentState != null && formKeyPinGenerate.currentState!.validate()) {
              bool status = await controller.userGeneratePinNetworkApi();
              if (status == true) {
                pinValue.value = 4;
              }
            }
          },
        ),
        SizedBox(height: 20.r),
        InkWell(
          onTap: ()=> pinValue.value = 1,
          child: Text(
            "I remember my PIN",
            style: fontRegular.copyWith(color: AllColors.white.withOpacity(0.8),wordSpacing: 0,letterSpacing: 0.2),
          ),
        ),
      ],
    );
  }
}
