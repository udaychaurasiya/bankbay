import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final String? title;
  const CustomImage({super.key, required this.image, this.title=""});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image != "null" && image != ""
          ? AppConstants.BASE_URL + image.toString()
          : Images.empty,
      fadeOutDuration: const Duration(seconds: 2),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 0.5.r, color: AllColors.themeColor.withOpacity(0.5)),
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.colorBurn)),
        ),
      ),
      placeholder: (context, url) => Center(
        child: Container(
          height: 45.r,
          width: 45.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 0.5.r, color: AllColors.themeColor.withOpacity(0.5)),
          ),
          child: const CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.error,
            size: 20.r,
            color: AllColors.orange.withOpacity(0.7),
          ),
          if(title!="")
          SizedBox(height: 3.r),
          if(title!="")
          Text(
            title ?? "",
            style: fontExtraSmall.copyWith(
                color: AllColors.black.withOpacity(0.7)),
          )
        ],
      ),
    );
  }
}
