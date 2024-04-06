import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils_method/custom_image.dart';
import 'package:bank_bay/utils_method/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmpPartnerViewCard extends StatelessWidget {
  final String title;
  final String userId;
  final String profileImage;
  final String? address;
  final String? expireDate;
  final String? preDate;
  final String? status;
  final bool? star;
  final Color? color;
  final GestureTapCallback? onTap;
  final GestureTapCallback? nameTap;
  final bool? remarkBool;
  final TextEditingController? controller;
  const EmpPartnerViewCard({super.key, required this.title, required this.profileImage, this.address, this.expireDate, this.preDate, this.star, this.color, this.onTap, this.controller, this.remarkBool=false, required this.userId, this.status="", this.nameTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: ()=> Get.to(()=> CustomImageView(imageUrls: AppConstants.BASE_URL+profileImage.toString())),
            child: CircleAvatar(
              radius: 24.r,
              backgroundColor: AllColors.lightTeal.withOpacity(0.6),
              child: CustomImage(
                image: profileImage.toString(),
              ),
            ),
          ),
          SizedBox(width: 10.r),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: nameTap,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                title.toString().length > 20?
                                Expanded(child: Text(title.toString(), style: fontSmall.copyWith(fontWeight: FontWeight.w500, fontSize: 13.r, color: AllColors.themeColor,overflow: TextOverflow.ellipsis),maxLines: 1)) :
                                Text(title.toString(), style: fontSmall.copyWith(fontWeight: FontWeight.w500, fontSize: 13.r, color: AllColors.themeColor,overflow: TextOverflow.ellipsis),maxLines: 1),
                                Text("(${userId.toString()})", style: fontSmall.copyWith(fontSize: 13.r, color: AllColors.themeColor.withOpacity(0.9),overflow: TextOverflow.ellipsis)),
                              ],
                            ),
                          ),
                          SizedBox(height: 1.r),
                          Text(address??"NA", style: fontSmall.copyWith(fontSize: 13.r,fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.7),overflow: TextOverflow.ellipsis),),
                        ],
                      ),
                    ),
                    if(star==true)
                      SizedBox(width: 10.r),
                    if(star==true)
                      Icon(Icons.star_border_outlined, color: color),
                  ],
                ),
                SizedBox(height: 1.r),
                Text("Exp : $expireDate", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),overflow: TextOverflow.ellipsis),),
                SizedBox(height: 1.r),
                Text("Pre: $preDate", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),overflow: TextOverflow.ellipsis),),
                SizedBox(height: 5.r),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: onTap,
                      child: Container(
                        width: 85.r,
                        height: 22.r,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.r),
                          color: AllColors.themeColor.withOpacity(0.85),
                        ),
                        child: Text( "View Details",style: fontMedium.copyWith(fontSize: 12.r, color: AllColors.white.withOpacity(0.8)),),
                      ),
                    ),
                    if(status!=""&&status!=null)
                      (status=="active")?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(Images.ok, height: 20.r, width: 20.r, fit: BoxFit.cover,),
                          Text("Approve",style: fontBold.copyWith(
                            color: AllColors.green,
                            fontSize: 14.r,
                            letterSpacing: 0.2,
                          ),
                          ),
                        ],
                      ) :
                      (status=="int-initiated")?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(Images.active, height: 18.r, width: 18.r, fit: BoxFit.cover,color: AllColors.orange),
                          SizedBox(width: 3.r),
                          Text("New User",style: fontBold.copyWith(
                            color: AllColors.orange,
                            fontSize: 14.r,
                            letterSpacing: 0.2,
                          ),
                          ),
                        ],
                      ):
                      (status=="push-back")?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(Images.pushback, height: 18.r, width: 18.r, fit: BoxFit.cover,color: AllColors.red.withOpacity(0.7)),
                          SizedBox(width: 3.r),
                          Text("Push Back",style: fontBold.copyWith(
                            color: AllColors.red.withOpacity(0.7),
                            fontSize: 14.r,
                            letterSpacing: 0.2,
                          ),
                          ),
                        ],
                      ):
                      const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
