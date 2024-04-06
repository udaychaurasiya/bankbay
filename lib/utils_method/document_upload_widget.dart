import 'dart:io';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChooseImageWidget extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String title;
  final String? subTitle;
  final String image;
  const ChooseImageWidget(
      {super.key, this.onTap, required this.title, this.subTitle, required this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DottedBorder(
          borderType: BorderType.Rect,
          radius: Radius.circular(5.r),
          strokeWidth: 1.5.r,
          dashPattern: const [5, 4],
          color: AllColors.black.withOpacity(0.5),
          child: image!=""?
          Container(
            height: 100.r,
            width: 150.r,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(File(image.toString())),
              ),
            ),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                title: "Browser Files".tr,
                height: 22.r,
                radius: 0,
                onTap: onTap,
                bgColor: AllColors.black.withOpacity(0.5),
                background: false,
                border: false,
                miniFont: true,
              ),
            ),
          ) :
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 5.r),
            child: Column(
              children: [
                Icon(Icons.cloud_download_rounded, size: 25.r,
                    color: Colors.black.withOpacity(0.6)),
                SizedBox(height: 3.r),
                Text(
                  "Drag & Drop files here",
                  style: fontExtraSmall.copyWith(
                      color: Colors.black.withOpacity(0.6)),
                ),
                SizedBox(height: 5.r),
                Text(
                  "or",
                  style: fontExtraSmall.copyWith(
                      color: Colors.black.withOpacity(0.6)),
                ),
                SizedBox(height: 5.r),
                InkWell(
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.r, vertical: 3.r),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.r),
                      border: Border.all(
                          width: 1.r, color: AllColors.blue.withOpacity(0.9)),
                    ),
                    child: Text("Browser Files", style: fontExtraSmall.copyWith(
                        color: AllColors.blue.withOpacity(0.9),
                        letterSpacing: 0.1),),
                  ),
                ),
                SizedBox(height: 5.r),
              ],
            ),
          ),
        ),
        SizedBox(width: 20.r),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title.toString(), style: fontSmall.copyWith(
                  color: AllColors.black.withOpacity(0.9),
                  letterSpacing: 0.2),),
              SizedBox(height: 2.r),
              Text(subTitle ?? "", style: fontExtraSmall.copyWith(
                  color: AllColors.black.withOpacity(0.5)),),
            ],
          ),
        )
      ],
    );
  }
}
