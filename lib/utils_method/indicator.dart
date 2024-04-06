import 'package:bank_bay/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: AllColors.white,
          borderRadius: BorderRadius.circular(100.r),
            boxShadow: [
              BoxShadow(
              color: AllColors.grey.withOpacity(0.5),
              blurRadius: 5.0.r, spreadRadius: 2.r,
            ),
          ],
        ),
        child: SizedBox(
          height: 30.r,
          width: 30.r,
          child: CircularProgressIndicator(color: AllColors.blue, strokeWidth: 3.5.r,),
        ),
      ),
    );
  }
}
