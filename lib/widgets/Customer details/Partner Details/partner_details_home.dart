// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/controllers/permission_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils_method/custom_appbar.dart';
import 'package:bank_bay/utils_method/custom_image.dart';
import 'package:bank_bay/utils_method/custom_image_view.dart';
import 'package:bank_bay/widgets/Customer%20details/Partner%20Details/partner_details.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'partner_pushback_details.dart';

class PartnerDetailsHome extends StatefulWidget {
  final String pageName;
  final String partnerId;
  const PartnerDetailsHome({super.key, required this.pageName, required this.partnerId});

  @override
  State<PartnerDetailsHome> createState() => _PartnerDetailsHomeState();
}


class _PartnerDetailsHomeState extends State<PartnerDetailsHome> {
  var controller = Get.find<PartnerController>();
  var loginController = Get.find<LoginController>();
  var permissionController = Get.find<PermissionController>();
  var statusValue = 1.obs;

  @override
  void initState() {
    controller.getCustomerDetailsNetworkApi(widget.partnerId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          50.0.r,
        ),
        child: CustomAppBar(
          title: "Partner Details".tr,
          leadingBool: false,
          back: true,
          onTab: ()async{
            Get.back();
          },
        ),
      ),
      body: Container(
        color: Colors.lightBlue.withOpacity(0.1),
        padding: EdgeInsets.symmetric(horizontal: 10.r),
        child: ListView(
          children: [
            SizedBox(height: 20.r),
            Container(
              padding: EdgeInsets.symmetric(horizontal:8.r, vertical: 8.r),
              color: AllColors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.0.r, vertical: 3.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GetBuilder<PartnerController>(
                      builder:(controller) => controller.customerDetails.value.data.details.custProfilePic!=null&&
                        controller.customerDetails.value.data.details.custProfilePic!=""?
                      InkWell(
                        onTap: ()=> Get.to(()=> CustomImageView(imageUrls: AppConstants.BASE_URL+controller.customerDetails.value.data.details.custProfilePic.toString())),
                        child: CircleAvatar(
                          radius: 22.r,
                          backgroundColor: AllColors.lightTeal.withOpacity(0.6),
                          child: CustomImage(
                            image: controller.customerDetails.value.data.details.custProfilePic.toString(),
                          ),
                        ),
                      ): const SizedBox(),
                    ),
                    SizedBox(width: 10.r),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: GetBuilder<PartnerController>(
                                  builder:(controller) => controller.customerDetails.value.data.details.custName!=null
                                    &&controller.customerDetails.value.data.details.custName!=""?
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: controller.customerDetails.value.data.details.custName??"",
                                          style: fontSmall.copyWith(fontWeight: FontWeight.w500),
                                          children: [
                                            TextSpan(text: controller.customerDetails.value.data.partnerdetails.pid!=""&&controller.customerDetails.value.data.partnerdetails.pid!=null?"(${controller.customerDetails.value.data.partnerdetails.pid??""})":"", style: fontSmall.copyWith(fontWeight: FontWeight.w500, color: AllColors.black.withOpacity(0.7))),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 2.r),
                                      Text(controller.customerDetails.value.data.details.custAddress??"NA", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                      SizedBox(height: 2.r),
                                      Text("Exp : ${controller.customerDetails.value.data.partnerdetails.partnerApprovedDate??""}", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                      SizedBox(height: 2.r),
                                      Text("Pre : ${controller.customerDetails.value.data.partnerdetails.partnerJoinDate??""}", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                    ],
                                  ) : const SizedBox(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.r),
            ((widget.pageName.toString()=="partnerPushback"||widget.pageName.toString()=="allPartner")||
                (widget.pageName.toString()=="partnerDirectRequest"||widget.pageName.toString()=="partnerRequest"))?
              PartnerPushbackDetails(pageName: widget.pageName.toString(),partnerId: widget.partnerId) :
              PartnerDetails(pageName: widget.pageName.toString(),partnerId: widget.partnerId),
            SizedBox(height: 15.r),
          ],
        ),
      ),
    );
  }
}
