import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserLoanFormView extends StatelessWidget {
  const UserLoanFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.find<LoginController>();

    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 20.r),
      color: AllColors.white.withOpacity(0.9),
      child: Column(
        children: [
          Text(
            "Please confirm your PAN address details",
            style: fontSmall.copyWith(color: Colors.black.withOpacity(0.6)),
          ),
          SizedBox(height: 30.r),
          Text(
            "Correspondence Address",
            style: fontSmall.copyWith(
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 5.r),
          Container(
            color: Colors.lightBlue.withOpacity(0.05),
            padding: EdgeInsets.only(
                left: 8.r, top: 10.r, bottom: 10.r, right: 35.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "So ${controller.etName
                      .text}, House No 842, Samachar \nApartment, Near Shiv Mandir \nDelhi",
                  style: fontExtraSmall.copyWith(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                SizedBox(height: 2.r),
                Text(
                  "Delhi",
                  style: fontExtraSmall.copyWith(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                SizedBox(height: 2.r),
                Text(
                  "111065522",
                  style: fontExtraSmall.copyWith(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30.r),
          Text(
            "Permanent Address",
            style: fontSmall.copyWith(
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 5.r),
          Container(
            color: Colors.lightBlue.withOpacity(0.05),
            padding: EdgeInsets.only(
                left: 8.r, top: 10.r, bottom: 10.r, right: 35.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "So Ajay Sharma, House No 842, Samachar \nApartment, Near Shiv Mandir \nDelhi",
                  style: fontExtraSmall.copyWith(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                SizedBox(height: 2.r),
                Text(
                  "Delhi",
                  style: fontExtraSmall.copyWith(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                SizedBox(height: 2.r),
                Text(
                  "111065522",
                  style: fontExtraSmall.copyWith(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30.r),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LightCustomButton(
                title: "Back".tr,
                height: 28.r,
                width: 100.r,
                background: false,
                onTap: () => indexValue.value=2,
              ),
              SizedBox(width: 15.r),
              CustomButton(
                title: "Next".tr,
                background: true,
                radius: 30.r,
                height: 30.r,
                width: Get.width - 240,
                onTap: ()async{
                  //if (formKeyLoan.currentState != null && formKeyLoan.currentState!.validate()) {
                  bool status = await controller.loginNetworkApi();
                  if (status == true) {
                    indexValue.value=4;
                  }
                  //}
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
