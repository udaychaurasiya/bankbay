// ignore_for_file: deprecated_member_use

import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils_method/custom_image.dart';
import 'package:bank_bay/utils_method/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomLeadsDetails extends StatelessWidget {
  final String image;
  final String name;
  final String? pageName;
  final String leadId;
  final String? leadTypeName;
  final String? leadSource;
  final String? disbursal;
  final String address;
  final String createDate;
  final String? leadDateTime;
  final String number;
  final String leadLockStatus;
  final String lockedBy;
  final String leadStatus;
  final int? holdCount;
  final dynamic index;
  final bool? transferLeadStatus;
  final GestureTapCallback? nameTap;
  final GestureTapCallback? detailsTap;
  final Widget? child;
  const CustomLeadsDetails({super.key, required this.image, this.nameTap, this.detailsTap, required this.name,
    required this.leadId, required this.address, required this.createDate, required this.number, this.transferLeadStatus=false,
    this.child, required this.leadLockStatus, required this.lockedBy, required this.leadStatus, this.index, this.leadTypeName, this.pageName, this.leadSource, this.disbursal,
    this.leadDateTime="", this.holdCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0.r),
      child: GetBuilder<LoginController>(
        builder: (controller) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: ()=> Get.to(()=> CustomImageView(imageUrls: AppConstants.BASE_URL+image.toString())),
                child: CircleAvatar(
                  radius: 18.r,
                  backgroundColor: AllColors.lightTeal.withOpacity(0.6),
                  child: CustomImage(
                    image: image.toString(),
                  ),
                ),
              ),
              SizedBox(width: 10.r),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: nameTap,
                                child: RichText(
                                  text: TextSpan(
                                    text: name,
                                    style: fontSmall.copyWith(fontWeight: FontWeight.w500),
                                    children: [
                                      if(leadId!=""||leadId!="null")
                                      TextSpan(text: "($leadId)", style: fontSmall.copyWith()),
                                    ],
                                  ),
                                ),
                              ),
                              Text(address, style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                              if(pageName!="IncDetails")
                                Text(createDate, style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                              if(pageName!="IncDetails")
                                if(leadDateTime!="")
                                Padding(
                                  padding: EdgeInsets.only(top: 2.r),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        size: 15.r,
                                        color: AllColors.black.withOpacity(0.6),
                                      ),
                                      SizedBox(width: 5.r),
                                      Text(leadDateTime??"", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w500),),
                                    ],
                                  ),
                                ),
                              if(pageName=="IncDetails")
                                RichText(
                                text: TextSpan(
                                  text: "Lead source : ",
                                  style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),fontSize: 11.r),
                                  children: [
                                    TextSpan(text: leadSource, style: fontExtraSmall.copyWith(fontSize: 11.r,color: AllColors.blue)),
                                    // TextSpan(text: " (${data.custId??"NA"})", style: fontExtraSmall.copyWith(fontSize: 11.r,overflow: TextOverflow.ellipsis)),
                                  ],
                                ),
                              ),
                              if(pageName=="IncDetails")
                                RichText(
                                text: TextSpan(
                                  text: "Lead date : ",
                                  style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),fontSize: 11.r),
                                  children: [
                                    TextSpan(text: createDate, style: fontExtraSmall.copyWith(fontSize: 11.r,overflow: TextOverflow.ellipsis)),
                                  ],
                                ),
                              ),
                              if(pageName=="IncDetails")
                                RichText(
                                text: TextSpan(
                                  text: "Disbursal : ",
                                  style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),fontSize: 11.r),
                                  children: [
                                    TextSpan(text: disbursal, style: fontExtraSmall.copyWith(fontSize: 11.r,overflow: TextOverflow.ellipsis)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if(number!="")
                        Row(
                          children: [
                            InkWell(
                              onTap: ()=> launch("tel://+91$number"),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 14.r,vertical: 3.r),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.r),
                                    border: Border.all(width: 0.5, color: AllColors.grey.withOpacity(0.6))
                                ),
                                child: Icon(
                                  Icons.call,
                                  size: 12.r,
                                  color: AllColors.red.withOpacity(0.6),
                                ),
                              ),
                            ),
                            if(transferLeadStatus==true)
                              if(leadStatus.toString()!="Inc Paid")
                            SizedBox(width: 10.r),
                            if(transferLeadStatus==true)
                              if(leadStatus.toString()!="Inc Paid")
                              SizedBox(
                                height: 20.r,
                                width: 20.r,
                                child: child,
                              ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              leadLockStatus=="true"?
                              Container(
                                width: 80.r,
                                height: 22.r,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.r),
                                    color: AllColors.lightGrey.withOpacity(0.6),
                                    border: Border.all(width: 0.5.r, color: AllColors.black.withOpacity(0.5))
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.lock_open_outlined,size: 15.r, color: AllColors.black.withOpacity(0.6)),
                                    SizedBox(width: 5.r),
                                    Text(lockedBy,style: fontMedium.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.6)),textAlign: TextAlign.end),
                                  ],
                                ),
                              ) :
                              InkWell(
                                onTap: detailsTap,
                                child: Container(
                                  width: 90.r,
                                  height: 22.r,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.r),
                                    color: AllColors.themeColor,
                                  ),
                                  child: Text("View Details",style: fontMedium.copyWith(fontSize: 12.r, color: AllColors.white.withOpacity(0.8)),),
                                ),
                              ),
                              SizedBox(width: 15.r),
                              if(leadTypeName=="Employee")
                                Image.asset(Images.employee,height: 18.r, width: 18.r, fit: BoxFit.cover,),
                              if(leadTypeName=="Partner")
                                Image.asset(Images.partnerIcon,height: 18.r, width: 18.r, fit: BoxFit.cover,),
                              if(leadTypeName=="customer")
                                Image.asset(Images.customer,height: 18.r, width: 18.r, fit: BoxFit.cover,),
                            ],
                          ),
                          if(leadStatus!=""&&leadStatus!="null")
                          if(leadStatus=="verified")
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(Images.ok, height: 18.r, width: 18.r, fit: BoxFit.cover,),
                                SizedBox(width: 2.r),
                                Text("Verified",
                                  style: fontMedium.copyWith(
                                  color: AllColors.green,
                                  fontSize: 13.r,
                                  letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ),
                          if(leadStatus!=""&&leadStatus!="null")
                          if(leadStatus=="in-principle approval")
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(Images.rejected, height: 18.r, width: 18.r, fit: BoxFit.cover),
                                SizedBox(width: 2.r),
                                Text("principle approval", style: fontMedium.copyWith(
                                  color: AllColors.red.withOpacity(0.7),
                                  fontSize: 13.r,
                                  letterSpacing: 0.2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                ),
                              ],
                            ),
                          if(leadStatus!=""&&leadStatus!="null")
                          if(leadStatus!="verified"&&leadStatus!="in-principle approval")
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(Images.rejected, height: 18.r, width: 18.r, fit: BoxFit.cover),
                                SizedBox(width: 2.r),
                                Text("${leadStatus.capitalize}", style: fontMedium.copyWith(
                                  color: AllColors.red.withOpacity(0.7),
                                  fontSize: 13.r,
                                  letterSpacing: 0.2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    index ? const SizedBox():
                    Container(
                      height: 1.r,
                      margin: EdgeInsets.symmetric(vertical: 12.r),
                      color: AllColors.lightGrey.withOpacity(0.8),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}

class CustomLeadsDetails2 extends StatelessWidget {
  final String image;
  final String name;
  final String leadId;
  final String address;
  final String createDate;
  final String? endDate;
  final String? leadStatus;
  final dynamic index;
  final String? pageName;
  final GestureTapCallback? detailsTap;
  const CustomLeadsDetails2({super.key, required this.image, this.detailsTap, required this.name,
    required this.leadId, required this.address, required this.createDate, this.leadStatus, this.index, this.endDate="", this.pageName=""});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: ()=> Get.to(()=> CustomImageView(imageUrls: AppConstants.BASE_URL+image.toString())),
            child: CircleAvatar(
              radius: 18.r,
              backgroundColor: AllColors.lightTeal.withOpacity(0.6),
              child: CustomImage(
                image: image.toString(),
              ),
            ),
          ),
          SizedBox(width: 10.r),
          Expanded(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: name,
                              style: fontSmall.copyWith(fontWeight: FontWeight.w500, fontSize: 12.5.r,),
                              children: [
                                if(leadId!=""||leadId!="null")
                                  TextSpan(text: "($leadId)", style: fontSmall.copyWith()),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.r),
                          Text(address, style: fontSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.7),overflow: TextOverflow.ellipsis),),
                          SizedBox(height: 1.r),
                          if(pageName=="myTeamEMP")
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Exp : $createDate", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),overflow: TextOverflow.ellipsis),),
                                SizedBox(height: 1.r),
                                Text("Pre: $endDate", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),overflow: TextOverflow.ellipsis),),
                              ],
                            ),
                          if(pageName!="myTeamEMP")
                            Text(createDate, style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),overflow: TextOverflow.ellipsis),),
                          SizedBox(height: 5.r),
                          InkWell(
                            onTap: detailsTap,
                            child: Container(
                              width: 90.r,
                              height: 22.r,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.r),
                                color: AllColors.themeColor,
                              ),
                              child: Text( "View Details",style: fontMedium.copyWith(fontSize: 12.r, color: AllColors.white.withOpacity(0.8)),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                index ? const SizedBox():
                Container(
                  height: 1.r,
                  margin: EdgeInsets.symmetric(vertical: 12.r),
                  color: AllColors.lightGrey.withOpacity(0.8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomLeadsDetails3 extends StatelessWidget {
  final String image;
  final String name;
  final String? pageName;
  final String leadId;
  final String? leadTypeName;
  final String? leadSource;
  final String? disbursal;
  final String address;
  final String createDate;
  final String? leadDateTime;
  final String number;
  final String leadLockStatus;
  final String lockedBy;
  final String leadStatus;
  final int? holdCount;
  final dynamic index;
  final bool? transferLeadStatus;
  final GestureTapCallback? nameTap;
  final GestureTapCallback? detailsTap;
  final Widget? child;
  const CustomLeadsDetails3({super.key, required this.image, this.nameTap, this.detailsTap, required this.name,
    required this.leadId, required this.address, required this.createDate, required this.number, this.transferLeadStatus=false,
    this.child, required this.leadLockStatus, required this.lockedBy, required this.leadStatus, this.index, this.leadTypeName, this.pageName, this.leadSource, this.disbursal,
    this.leadDateTime="", this.holdCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0.r),
      child: GetBuilder<LoginController>(
          builder: (controller) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: ()=> Get.to(()=> CustomImageView(imageUrls: AppConstants.BASE_URL+image.toString())),
                  child: CircleAvatar(
                    radius: 18.r,
                    backgroundColor: AllColors.lightTeal.withOpacity(0.6),
                    child: CustomImage(
                      image: image.toString(),
                    ),
                  ),
                ),
                SizedBox(width: 10.r),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: nameTap,
                                  child: RichText(
                                    text: TextSpan(
                                      text: name,
                                      style: fontSmall.copyWith(fontWeight: FontWeight.w500),
                                      children: [
                                        if(leadId!=""||leadId!="null")
                                          TextSpan(text: "($leadId)", style: fontSmall.copyWith()),
                                      ],
                                    ),
                                  ),
                                ),
                                Text(address, style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                if(pageName!="IncDetails")
                                  Text(createDate, style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                if(pageName!="IncDetails")
                                  if(leadDateTime!="")
                                    Padding(
                                      padding: EdgeInsets.only(top: 2.r),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.calendar_month,
                                            size: 15.r,
                                            color: AllColors.black.withOpacity(0.6),
                                          ),
                                          SizedBox(width: 5.r),
                                          Text(leadDateTime??"", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w500),),
                                        ],
                                      ),
                                    ),
                                if(pageName=="IncDetails")
                                  RichText(
                                    text: TextSpan(
                                      text: "Lead source : ",
                                      style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),fontSize: 11.r),
                                      children: [
                                        TextSpan(text: leadSource, style: fontExtraSmall.copyWith(fontSize: 11.r,color: AllColors.blue)),
                                        // TextSpan(text: " (${data.custId??"NA"})", style: fontExtraSmall.copyWith(fontSize: 11.r,overflow: TextOverflow.ellipsis)),
                                      ],
                                    ),
                                  ),
                                if(pageName=="IncDetails")
                                  RichText(
                                    text: TextSpan(
                                      text: "Lead date : ",
                                      style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),fontSize: 11.r),
                                      children: [
                                        TextSpan(text: createDate, style: fontExtraSmall.copyWith(fontSize: 11.r,overflow: TextOverflow.ellipsis)),
                                      ],
                                    ),
                                  ),
                                if(pageName=="IncDetails")
                                  RichText(
                                    text: TextSpan(
                                      text: "Disbursal : ",
                                      style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),fontSize: 11.r),
                                      children: [
                                        TextSpan(text: disbursal, style: fontExtraSmall.copyWith(fontSize: 11.r,overflow: TextOverflow.ellipsis)),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if(number!="")
                            Row(
                              children: [
                                InkWell(
                                  onTap: ()=> launch("tel://+91$number"),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 14.r,vertical: 3.r),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100.r),
                                        border: Border.all(width: 0.5, color: AllColors.grey.withOpacity(0.6))
                                    ),
                                    child: Icon(
                                      Icons.call,
                                      size: 12.r,
                                      color: AllColors.red.withOpacity(0.6),
                                    ),
                                  ),
                                ),
                                if(transferLeadStatus==true)
                                  if(leadStatus.toString()!="Inc Paid")
                                    SizedBox(width: 10.r),
                                if(transferLeadStatus==true)
                                  if(leadStatus.toString()!="Inc Paid")
                                    SizedBox(
                                      height: 20.r,
                                      width: 20.r,
                                      child: child,
                                    ),
                              ],
                            ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                leadLockStatus=="true"?
                                Container(
                                  width: 80.r,
                                  height: 22.r,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2.r),
                                      color: AllColors.lightGrey.withOpacity(0.6),
                                      border: Border.all(width: 0.5.r, color: AllColors.black.withOpacity(0.5))
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.lock_open_outlined,size: 15.r, color: AllColors.black.withOpacity(0.6)),
                                      SizedBox(width: 5.r),
                                      Text(lockedBy,style: fontMedium.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.6)),textAlign: TextAlign.end),
                                    ],
                                  ),
                                ) :
                                InkWell(
                                  onTap: detailsTap,
                                  child: Container(
                                    width: 90.r,
                                    height: 22.r,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2.r),
                                      color: AllColors.themeColor,
                                    ),
                                    child: Text("View Details",style: fontMedium.copyWith(fontSize: 12.r, color: AllColors.white.withOpacity(0.8)),),
                                  ),
                                ),
                                SizedBox(width: 15.r),
                                if(leadTypeName=="Employee")
                                  Image.asset(Images.employee,height: 18.r, width: 18.r, fit: BoxFit.cover,),
                                if(leadTypeName=="Partner")
                                  Image.asset(Images.partnerIcon,height: 18.r, width: 18.r, fit: BoxFit.cover,),
                                if(leadTypeName=="customer")
                                  Image.asset(Images.customer,height: 18.r, width: 18.r, fit: BoxFit.cover,),
                              ],
                            ),
                            if(leadStatus!=""&&leadStatus!="null")
                              if(leadStatus=="verified")
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(Images.ok, height: 18.r, width: 18.r, fit: BoxFit.cover,),
                                    SizedBox(width: 2.r),
                                    Text("Verified",
                                      style: fontMedium.copyWith(
                                        color: AllColors.green,
                                        fontSize: 13.r,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                  ],
                                ),
                            // lead_status=new & hold_count>0
                            if(leadStatus!=""&&leadStatus!="null")
                              if(leadStatus=="new"&&holdCount==0||leadStatus=="unassigned")
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(Images.ok, height: 18.r, width: 18.r, fit: BoxFit.cover,),
                                    SizedBox(width: 2.r),
                                    Text("Submitted",
                                      style: fontMedium.copyWith(
                                        color: AllColors.green,
                                        fontSize: 13.r,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                  ],
                                ),
                            if(leadStatus!=""&&leadStatus!="null")
                              if(leadStatus=="in-principle approval")
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(Images.rejected, height: 18.r, width: 18.r, fit: BoxFit.cover),
                                    SizedBox(width: 2.r),
                                    Text("principle approval", style: fontMedium.copyWith(
                                      color: AllColors.red.withOpacity(0.7),
                                      fontSize: 13.r,
                                      letterSpacing: 0.2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    ),
                                  ],
                                ),
                            if(leadStatus!=""&&leadStatus!="null")
                              if((leadStatus!="verified"&&leadStatus!="unassigned")&&(leadStatus!="in-principle approval"&&leadStatus!="new"))
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(Images.rejected, height: 18.r, width: 18.r, fit: BoxFit.cover),
                                    SizedBox(width: 2.r),
                                    Text("${leadStatus.capitalize}", style: fontMedium.copyWith(
                                      color: AllColors.red.withOpacity(0.7),
                                      fontSize: 13.r,
                                      letterSpacing: 0.2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    ),
                                  ],
                                ),
                            if(leadStatus!=""&&leadStatus!="null")
                              if(leadStatus=="new"&&holdCount!=0)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(Images.ok, height: 18.r, width: 18.r, fit: BoxFit.cover,),
                                    SizedBox(width: 2.r),
                                    Text("Released",
                                      style: fontMedium.copyWith(
                                        color: AllColors.green,
                                        fontSize: 13.r,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                  ],
                                ),

                          ],
                        ),
                      ),
                      index ? const SizedBox():
                      Container(
                        height: 1.r,
                        margin: EdgeInsets.symmetric(vertical: 12.r),
                        color: AllColors.lightGrey.withOpacity(0.8),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}
