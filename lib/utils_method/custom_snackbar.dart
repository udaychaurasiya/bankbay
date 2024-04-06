// ignore_for_file: unnecessary_null_comparison

import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CustomAnimation extends GetxController{

  void showCustomSnackBar(String message,
      {bool isError = true, bool getXSnackBar = false}) {
    if (message != null && message.isNotEmpty) {
      if (getXSnackBar) {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: isError ? Colors.red.shade300 : Colors.green,
          message: message,
          maxWidth: Get.width,
          duration: const Duration(seconds: 2),
          snackStyle: SnackStyle.FLOATING,
          snackPosition: SnackPosition.TOP, // Position at the top
          margin: EdgeInsets.all(5.r),
          borderRadius: 5.r,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
        ));
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: isError ? Colors.red : /*Color(0xff051ba6)*/ Colors.green,
          message: message,
          maxWidth: Get.width,
          duration: const Duration(seconds: 2),
          snackStyle: SnackStyle.FLOATING,
          snackPosition: SnackPosition.TOP, // Position at the top
          margin: EdgeInsets.all(5.r),
          borderRadius: 5.r,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
        ));
      }
    }
  }

  showCustomToast(String message, {bool isError = true}) {
    if (message != null && message.isNotEmpty) {
      Fluttertoast.showToast(
          msg: message,
          backgroundColor: isError ? Colors.red.shade400 : Colors.black,
          textColor: Colors.white);

    }
  }

  imageDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context, ) {
        return AlertDialog(
          content: SizedBox(
            height: 140.r,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.r, right: 15.r, top: 15.r),
                  child: Column(
                    children: [
                      Text("Choose Image", style: fontBold.copyWith(fontSize: 18.r),),
                      SizedBox(height: 10.r),
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
                SizedBox(height: 20.r),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(),
                    InkWell(
                      onTap: (){},
                      child: Column(
                        children: [
                          // Image.asset(Images.gallery, height: 42.r, width: 42.r, fit: BoxFit.cover,),
                          SizedBox(height: 5.r),
                          Text("Gallery", style: fontMedium.copyWith(fontSize: 15.r),),
                        ],
                      ),
                    ),
                    Container(
                      width: 1.r,
                      height: 40.r,
                      color: AllColors.lightGrey.withOpacity(0.8),
                      margin: EdgeInsets.symmetric(vertical: 5.r),
                    ),
                    InkWell(
                      onTap: (){},
                      child: Column(
                        children: [
                          // Image.asset(Images.camera, height: 42.r, width: 42.r,fit: BoxFit.cover,),
                          SizedBox(height: 5.r),
                          Text("Camera", style: fontMedium.copyWith(fontSize: 15.r),),
                        ],
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
