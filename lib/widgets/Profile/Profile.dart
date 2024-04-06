// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils_method/custom_appbar.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/custom_image_view.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/dashboard.dart';
import 'package:bank_bay/widgets/home_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'profile_document.dart';
import 'profile_form.dart';
import 'profile_kyc.dart';
import 'profile_selfie.dart';

var profileIndex = 1.obs;
class Profile extends StatefulWidget {
  const Profile({super.key,});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
    final _controller = Get.find<PartnerController>();
    var controller = Get.find<LoginController>();

    @override
  void initState() {
    super.initState();
    _controller. getUserDetailsApi(GetStorage().read(AppConstant.cust_id).toString());
    _controller.getCountryNetworkApi(context);
    _controller.saveProfileDate();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Get.to(()=>const DashboardScreen());
        indexValue.value=1;
        controller.index.value=0;
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.lightBlue.shade50,
        appBar: PreferredSize(
          preferredSize: Size(
            double.infinity,
            55.0.r,
          ),
          child: CustomAppBar(
            backgroundValue: true,
            leadingBool: false,
            back: true,
            onTab: (){
              Get.to(()=>const DashboardScreen());
              indexValue.value=1;
              controller.index.value=0;
            },
            title: 'Profile'.tr,
          ),
        ),
        body: Obx(() => Column(
          children: [
            SizedBox(height: 10.r),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: ()=> profileIndex.value=1,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10.r,right: 10.r,left: 10),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 4.r, color: profileIndex.value==1?Colors.yellow:AllColors.none))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 18.r,
                          width: 18.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AllColors.black,width: 0.5.r),
                            color: AllColors.white,
                          ),
                        ),
                        SizedBox(height: 2.r),
                        Text('About',style: fontSmall.copyWith()),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 5.r),
                InkWell(
                  onTap: ()=> profileIndex.value=2,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10.r,right: 10.r,left: 10.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 4.r, color: profileIndex.value==2?Colors.yellow:AllColors.none))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 18.r,
                          width: 18.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AllColors.black,width: 0.5.r),
                            color: AllColors.white,
                          ),
                        ),
                        SizedBox(height: 2.r),
                        Text('Photo',style: fontSmall.copyWith()),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 5.r),
                InkWell(
                  onTap: ()=> profileIndex.value=3,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10.r,right: 10.r,left: 10.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 4.r, color: profileIndex.value==3?Colors.yellow:AllColors.none))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 18.r,
                          width: 18.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AllColors.black,width: 0.5.r),
                            color: AllColors.white,
                          ),
                        ),
                        SizedBox(height: 2.r),
                        Text('Kyc',style: fontSmall.copyWith()),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 5.r),
                InkWell(
                  onTap: ()=> profileIndex.value=4,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10.r, left: 10.r, right: 10.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 4.r, color: profileIndex.value==4?Colors.yellow:AllColors.none))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 18.r,
                          width: 18.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AllColors.black,width: 0.5.r),
                            color: AllColors.white,
                          ),
                        ),
                        SizedBox(height: 2.r),
                        Text('Documents',style: fontSmall.copyWith()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  if(profileIndex.value==1)
                    const ProfileForm(),
                  if(profileIndex.value==2)
                    const ProfileSelfie(),
                  if(profileIndex.value==3)
                    const ProfileKyc(),
                  if(profileIndex.value==4)
                    const ProfileDocument(),
                ],
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}

class ChooseImageDocument extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String title;
  final String? subTitle;
  final String? fileName;
  final String image;
  final bool? optional;
  const ChooseImageDocument(
      {super.key, this.onTap, required this.title, this.subTitle, required this.image, this.optional=false, this.fileName=""});

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
                  image: FileImage(File(image.toString()),
                  )
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

class ChooseImageDocumentView extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String title;
  final String? subTitle;
  final String? fileName;
  final String image;
  final bool? optional;
  const ChooseImageDocumentView(
      {super.key, this.onTap, required this.title, this.subTitle, required this.image, this.optional=false, this.fileName=""});

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
          child: InkWell(
            onTap: ()=> Get.to(()=> CustomImageView(imageUrls: AppConstants.BASE_URL+image.toString())),
            child: Container(
              height: 100.r,
              width: 150.r,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(AppConstants.BASE_URL+image.toString(),
                    )
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
            ),
          )
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
