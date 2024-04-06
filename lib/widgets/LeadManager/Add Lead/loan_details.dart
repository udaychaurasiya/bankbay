import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoanDetails extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String title;
  final String? subTitle;
  final String? image;
  final Color? color;
  final Color? textColor;
  final Color? subColor;

  const LoanDetails(
      {super.key,
        this.onTap,
        required this.title,
        this.subTitle,
        this.color,
        this.textColor,
        this.subColor, this.image=""});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5.r, color: AllColors.themeColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(5.r)
        ),
        child: Row(
          children: [
            Container(
              height: 90.r,
              width: Get.width * 0.35,
              decoration: BoxDecoration(
                  // color: AllColors.lightTeal.withOpacity(0.1),
                  image: DecorationImage(image: AssetImage(image.toString())),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.r),
                      bottomLeft: Radius.circular(5.r)),
              ),
            ),
            Expanded(
              child: Container(
                height: 90.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5.r),
                        bottomRight: Radius.circular(5.r))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: fontBold.copyWith(color: textColor),
                    ),
                    SizedBox(height: 6.r),
                    Text(
                      subTitle.toString(),
                      style: fontSmall.copyWith(
                          color: subColor, wordSpacing: 0.1, letterSpacing: 0.1),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

