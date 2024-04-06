import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingMoreData extends StatelessWidget {
  const LoadingMoreData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.r),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0.r),
            child: CircularProgressIndicator(color: AllColors.themeColor.withOpacity(0.8)),
          ),
          SizedBox(width: 10.r),
          Text("Loading...",style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.8),fontSize: 15.r),)
        ],
      ),
    );
  }
}
