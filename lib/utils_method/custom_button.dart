
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String title;
  final GestureTapCallback? onTap;
  final bool? background;
  final Color? bgColor;
  final Color? iconColor;
  final Color? textColor;
  final double? radius;
  final IconData? icon;
  final double? iconSize;
  final bool? miniFont;
  final bool? border;
  const CustomButton({super.key, this.width, this.height, required this.title, this.onTap,
    this.background=true, this.radius, this.icon, this.iconSize, this.miniFont=false, this.bgColor, this.border=true, this.iconColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.0.r),
      child: Container(
        width: width??Get.width,
        height: height ?? 40.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: background==true?AllColors.themeColor:bgColor??AllColors.none,
          borderRadius: BorderRadius.circular(radius??5.r),
          border: border==false?null:Border.all(width: 0.5.r, color: bgColor??AllColors.themeColor.withOpacity(0.9))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon!=null?Icon(icon,size: iconSize??18.r,color: background==true?Colors.white.withOpacity(0.9):iconColor??AllColors.themeColor.withOpacity(0.9),):const SizedBox(),
            SizedBox(width: icon!=null?5.w:0),
            Text(title,style: fontMedium.copyWith(color: background==true?Colors.white.withOpacity(0.95):bgColor!=null?textColor??Colors.white.withOpacity(0.95):AllColors.themeColor,
                fontSize: miniFont == true ? 12.r:16.r, letterSpacing: 0.3, wordSpacing: 0.4),),
          ],
        ),
      ),
    );
  }
}

class LightCustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String title;
  final GestureTapCallback? onTap;
  final bool? background;
  final bool? lightBg;
  final double? radius;
  final IconData? icon;
  final double? iconSize;
  final bool? miniFont;
  final bool? shape;
  const LightCustomButton({super.key, this.width, this.height, required this.title, this.onTap,
    this.background=true, this.radius, this.icon, this.iconSize, this.miniFont=false, this.shape, this.lightBg=false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.0.r),
      child: Container(
        width: width??Get.width,
        height: height ?? 40.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: background==true?AllColors.teal.withOpacity(0.85):lightBg==true? AllColors.grey.withOpacity(0.5):AllColors.none,
            borderRadius: BorderRadius.circular(shape==true?100.r:radius??5.r),
            border: background==true?null:lightBg==true?null:Border.all(width: 0.5.r, color: AllColors.black.withOpacity(0.7))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon!=null?Icon(icon,size: iconSize??18.r,color: background==true?Colors.white.withOpacity(0.9):AllColors.black.withOpacity(0.7),):const SizedBox(),
            SizedBox(width: icon!=null?5.w:0),
            Text(title,style: fontRegular.copyWith(
                color: background==true?Colors.white.withOpacity(0.9):lightBg==true?AllColors.white:AllColors.black.withOpacity(0.7),
                fontWeight: lightBg==true?FontWeight.w600:FontWeight.w400,
                fontSize: miniFont == true ? 12.r:14.r),),
          ],
        ),
      ),
    );
  }
}

