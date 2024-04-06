import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DocumentUploadImageView extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String? fileName;
  final String image;
  final bool? optional;
  const DocumentUploadImageView(
      {super.key, required this.title, this.subTitle, required this.image, this.optional=false, this.fileName=""});

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
          child: SizedBox(
            height: 100.r,
            width: 150.r,
            child: CachedNetworkImage(
              imageUrl: image!="null"?AppConstants.BASE_URL+image.toString():Images.empty,
              fadeOutDuration: const Duration(seconds: 3),
              imageBuilder: (context,
                  imageProvider) =>
                  Container(
                    decoration:
                    BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.colorBurn)),
                    ),
                  ),
              placeholder: (context, url) =>
                  Center(
                    child: SizedBox(
                      height: 45.r,
                      width: 45.r,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
              errorWidget: (context,
                  url, error) =>
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, size: 40.r, color: AllColors.orange.withOpacity(0.7),),
                      SizedBox(height: 3.r),
                      Text("Image not found!", style: fontExtraSmall.copyWith(color: AllColors.black.withOpacity(0.7)),),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 15.r),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: title.toString(),
                  style: fontSmall.copyWith(
                      color: AllColors.black.withOpacity(0.9),
                      letterSpacing: 0.2),
                  children: [
                    TextSpan(text: optional==false? " * ":"", style: fontMedium.copyWith(
                      color: AllColors.red.withOpacity(0.8),
                    ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.r),
              Text(subTitle ?? "", style: fontExtraSmall.copyWith(
                  color: AllColors.black.withOpacity(0.5)),),
              SizedBox(height: 2.r),
              Text(fileName.toString(), style: fontExtraSmall.copyWith(
                  color: AllColors.black.withOpacity(0.5)),),
            ],
          ),
        )
      ],
    );
  }
}
