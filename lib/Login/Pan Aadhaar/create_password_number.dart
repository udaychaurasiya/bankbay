import 'package:bank_bay/Login/login_home.dart';
import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/uppercase_formate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreatePasswordNumber extends StatelessWidget {
  const CreatePasswordNumber({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.find<LoginController>();
    GlobalKey<FormState> formKeyPasswordForget = GlobalKey<FormState>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Form(
          key: formKeyPasswordForget,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:25.r),
            child: TextFormField(
              controller: controller.generateNumber,
              keyboardType: TextInputType.text,
              inputFormatters: [ UpperCaseTextFormatter() ],
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.credit_card,
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
                  hintText: "Enter PAN Number",
                  hintStyle: fontMedium.copyWith(
                      color: AllColors.white.withOpacity(0.8),fontSize: 16.r),
                  isDense: true,
                  contentPadding: EdgeInsets.only(top: 12.r,bottom: 10.r)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Invalid PAN number';
                }else if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value)) {
                  return 'Please enter valid PAN card';
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
            if (formKeyPasswordForget.currentState != null && formKeyPasswordForget.currentState!.validate()) {
              bool status = await controller.forgetPasswordNetworkAPI();
              if (status == true) {
                passwordValue.value=3;
              }
            }
          },
        ),
        SizedBox(height: 20.r),
        InkWell(
          onTap: () => passwordValue.value=1,
          child: Text(
            "I remember my Password",
            style: fontRegular.copyWith(color: AllColors.white.withOpacity(0.8),wordSpacing: 0,letterSpacing: 0.2),
          ),
        ),
      ],
    );
  }
}
