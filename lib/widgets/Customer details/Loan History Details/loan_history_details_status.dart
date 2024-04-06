// ignore_for_file: use_build_context_synchronously

import 'package:bank_bay/models/get_lead_details_model.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

var controller = Get.find<PartnerController>();
class MyLoanHistoryDetailsStatus extends StatelessWidget {
  final LeadDetailsData leadDetailsData;
  const MyLoanHistoryDetailsStatus({super.key, required this.leadDetailsData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatusViewData(
            title: "Created on".tr,
            value: "${leadDetailsData.leadDateTime??"NA"}",
          ),
          StatusViewData(
            title: "Created by".tr,
            value: leadDetailsData.createdByName??"NA",
          ),
          StatusViewData(
            title: "Last connect".tr,
            value: leadDetailsData.lastCallDateTime??"NA",
          ),
          StatusViewData(
            title: "Next Follow-up".tr,
            value: leadDetailsData.nextFollowupDate??"NA",
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 7.r),
            child: Row(
              children: [
                SizedBox(
                  width: Get.width/3-15.r,
                  child: Text("Status",
                    style: fontMedium.copyWith(
                      fontSize: 12.r,
                      color: AllColors.black.withOpacity(0.5),
                    ),
                  ),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: ":  ",
                      style: fontRegular.copyWith(
                        wordSpacing: 0,
                        letterSpacing: 0.2,
                        fontSize: 12.r,
                        color: AllColors.black.withOpacity(0.5),
                      ),
                      children: [
                          TextSpan(text: leadDetailsData.leadStatus.toString().capitalize??"NA",
                              style: fontBold.copyWith(
                                wordSpacing: 0,
                                letterSpacing: 0.2,
                                fontSize: 13.r,
                                color:  leadDetailsData.leadStatus.toString()=="verified"?
                                AllColors.green : AllColors.red.withOpacity(0.65),
                              )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.r),
        ],
      ),
    );
  }
}

class StatusViewData extends StatelessWidget {
  final String title;
  final String? value;
  final String? hint;
  const StatusViewData({super.key, required this.title, this.value, this.hint=""});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.r),
      child: Row(
        children: [
          SizedBox(
            width: Get.width/3-15.r,
            child: Text(title,
              style: fontMedium.copyWith(
                fontSize: 12.r,
                color: AllColors.black.withOpacity(0.5),
              ),
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: ":  ${value.toString()}",
                style: fontRegular.copyWith(
                  wordSpacing: 0,
                  letterSpacing: 0.2,
                  fontSize: 12.r,
                  color: AllColors.black.withOpacity(0.5),
                ),
                children: [
                  if(hint.toString().isNotEmpty)
                    TextSpan(text: "(${hint.toString()})", style: fontSmall.copyWith()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
