import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataNotFoundScreen extends StatelessWidget {
  final String title;
  const DataNotFoundScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // Image.asset(Images.no_data.toString(), height: 110.h, width: 110.w, color: AllColors.red.withAlpha(150)),
          Text(title,style: fontMedium.copyWith(fontSize: 22.r,color: AllColors.themeColor.withOpacity(0.9)),),
        ],
      ),
    );
  }
}
