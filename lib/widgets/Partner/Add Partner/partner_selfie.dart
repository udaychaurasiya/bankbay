import 'dart:io';

import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/widgets/Partner/create_partner.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

PartnerController controller = Get.find<PartnerController>();
class PartnerSelfie extends StatelessWidget {
  const PartnerSelfie({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 25.r),
      color: AllColors.white.withOpacity(0.9),
      child: Column(
        children: [
          Text(
            "Selfie",
            style: fontBold.copyWith(fontSize: 22.r, color: Colors.black),
          ),
          SizedBox(height: 2.r),
          Text(
            "Let's take a s/elfie",
            style: fontSmall.copyWith(color: Colors.black.withOpacity(0.6)),
          ),
          SizedBox(height: 20.r),
          DottedBorder(
            borderType: BorderType.Circle,
            radius: Radius.circular(100.r),
            strokeWidth: 1.5.r,
            dashPattern: const [5, 4],
            color: AllColors.black.withOpacity(0.5),
            child: Obx(() => InkWell(
                onTap: () {
                  partnerImageDialogBox(context);
                },
                child: CircleAvatar(
                  radius: 80.r,
                  backgroundColor: AllColors.white,
                  backgroundImage: controller.profileImg.isNotEmpty
                      ? FileImage(
                      File(controller.profileImg.value))
                      : null,
                  child: controller.profileImg.isEmpty ? Icon(
                      Icons.add, size: 18.r,
                      color: AllColors.black.withOpacity(0.5)) : null,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.r),
          Text(
            "Be sure to sit in full light area. \nMake sure your face is visible within area",
            style: fontRegular.copyWith(
                color: AllColors.black.withOpacity(0.7), fontSize: 13.r),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 25.r),
          CustomButton(
            title: "Update".tr,
            background: true,
            radius: 30.r,
            width: Get.width - 100,
            onTap: ()async {
              if(controller.profileImg.value!=""){
                bool status = await controller.partnerUploadSelfieNetworkApi();
                if(status==true){
                  addPartnerTab.value = 5;
                }
              }else{
                BaseController().errorSnack("Please take a selfie or choose image");
              }
            },
          ),
        ],
      ),
    );
  }
  partnerImageDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context,) {
        return AlertDialog(
          content: SizedBox(
            height: 180.r,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25.r, right: 25.r, top: 20.r),
                  child: Column(
                    children: [
                      Text(
                        "Choose Image",
                        style: fontBold.copyWith(fontSize: 18.r),
                      ),
                      SizedBox(height: 15.r),
                      Container(
                        height: 2.r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: AllColors.lightGrey.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.r),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        controller.chooseImage(false);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0.r),
                        child: Column(
                          children: [
                            Image.asset(
                              Images.gallery,
                              height: 50.r,
                              width: 50.r,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 5.r),
                            Text(
                              "Gallery",
                              style: fontMedium.copyWith(fontSize: 15.r),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 1.r,
                      height: 40.r,
                      color: AllColors.lightGrey.withOpacity(0.8),
                      margin: EdgeInsets.symmetric(vertical: 5.r),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        controller.chooseImage(true);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0.r),
                        child: Column(
                          children: [
                            Image.asset(
                              Images.camera,
                              height: 50.r,
                              width: 50.r,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 5.r),
                            Text(
                              "Camera",
                              style: fontMedium.copyWith(fontSize: 15.r),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
          contentPadding: EdgeInsets.zero,
          actionsOverflowButtonSpacing: 0,
          actionsOverflowDirection: VerticalDirection.down,
          actions: [
            Container(
              color: Colors.red,
            )
          ],
        );
      },
    );
  }
}
