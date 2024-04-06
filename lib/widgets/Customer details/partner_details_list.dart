// ignore_for_file: deprecated_member_use

import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils_method/custom_image_view.dart';
import 'package:bank_bay/widgets/Customer%20details/customer_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PartnerDetailsList extends StatefulWidget {
  final String? partnerId;
  final String? pageName;
  const PartnerDetailsList({super.key, this.partnerId, this.pageName});

  @override
  State<PartnerDetailsList> createState() => _PartnerDetailsListState();
}

class _PartnerDetailsListState extends State<PartnerDetailsList> {
  var selectedMenu = "Set Follow-up".obs;
  var controller = Get.find<PartnerController>();

  @override
  void initState() {
    controller.getCustomerDetailsNetworkApi(widget.partnerId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Partner Page"),),
      body: WillPopScope(
        onWillPop: () async {
          Get.back();
          return true;
        },
        child: Container(
          color: Colors.lightBlue.withOpacity(0.1),
          height: Get.height,
          child: SingleChildScrollView(
            child: GetBuilder<PartnerController>(builder:(controller) => Column(
              children: [
                SizedBox(height: 20.r),
                Container(
                  margin: EdgeInsets.symmetric(horizontal:10.0.r),
                  padding: EdgeInsets.symmetric(horizontal:8.r, vertical: 8.r),
                  color: AllColors.white,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.0.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: ()=> Get.to(()=> CustomImageView(imageUrls: AppConstants.BASE_URL+controller.customerDetails.value.data.details.custProfilePic.toString())),
                              child: CircleAvatar(
                                radius: 18.r,
                                backgroundColor: AllColors.lightTeal.withOpacity(0.5),
                                backgroundImage: NetworkImage(AppConstants.BASE_URL+controller.customerDetails.value.data.details.custProfilePic.toString()),
                              ),
                            ),
                            SizedBox(width: 10.r),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: controller.customerDetails.value.data.details.custName??"NA",
                                                style: fontSmall.copyWith(fontWeight: FontWeight.w500),
                                                children: [
                                                  TextSpan(text:controller.customerDetails.value.data.partnerdetails.pid!=null&&controller.customerDetails.value.data.partnerdetails.pid!=""?" (${controller.customerDetails.value.data.partnerdetails.pid??""})":"", style: fontSmall.copyWith(fontWeight: FontWeight.w500)),
                                                ],
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                            // Text(controller.customerDetails.value.data.details.custName??"NA", style: fontSmall.copyWith(fontWeight: FontWeight.w500)),
                                            Text(controller.customerDetails.value.data.details.custAddress??"NA", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                            Text(controller.customerDetails.value.data.details.custCreateDatetime??"NA", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                          ],
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
                      SizedBox(height: 10.r),
                      Container(
                        height: 60.r,
                        padding: EdgeInsets.symmetric(vertical: 8.r),
                        child: Row(
                          children: [
                            InkWell(
                              child: Icon(
                                Icons.keyboard_arrow_left_rounded,
                                size: 22.r,
                                color: AllColors.black.withOpacity(0.6),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: 3,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index){
                                  return Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 25.r, right: 25.r,),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(index==0?"All Leads":index==1?"Active":index==2?"Dropped":"Dropped",style: fontSmall.copyWith(color: AllColors.black.withOpacity(0.7)),),
                                            Text(index==0?"${controller.customerDetails.value.allLeadecount??0}":index==1?"${controller.customerDetails.value.activeLeadecount??0}":"${controller.customerDetails.value.droppedLeadecount??0}",style: fontRegular.copyWith(fontSize: 16.r,color: AllColors.black.withOpacity(0.6)),),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 1.r,
                                        color: AllColors.lightGrey.withOpacity(0.8),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                            InkWell(
                              child: Icon(
                                Icons.keyboard_arrow_right_rounded,
                                size: 22.r,
                                color: AllColors.black.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if(controller.customerDetails.value.data.allLeade.isNotEmpty)
                  Container(
                    color: AllColors.white,
                    margin: EdgeInsets.symmetric(horizontal: 10.0.r, vertical: 10.r),
                    child: ListView.builder(
                      itemCount: controller.customerDetails.value.data.allLeade.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var allLeadsData = controller.customerDetails.value.data.allLeade[index];
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 5.r),
                          decoration: BoxDecoration(
                              border: index==0?null:Border(top: BorderSide(color: AllColors.lightGrey))
                          ),
                          child: InkWell(
                            onTap: ()async{
                              Get.to(()=> CustomerDetails(leadId: "${allLeadsData.id??""}",customerId: allLeadsData.custId??"",value: "leadDetails",apiLeadId: allLeadsData.leadId,customerLoanListDetails: "customerLoanListDetails",pageName: widget.pageName,));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.r),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: ()=> Get.to(()=> CustomImageView(imageUrls: AppConstants.BASE_URL+allLeadsData.custLoanSelfie.toString())),
                                    child: CircleAvatar(
                                      radius: 18.r,
                                      backgroundColor: AllColors.lightTeal.withOpacity(0.5),
                                      backgroundImage: NetworkImage(AppConstants.BASE_URL+allLeadsData.custLoanSelfie.toString()),
                                    ),
                                  ),
                                  SizedBox(width: 10.r),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: controller.loanTypeEncode(allLeadsData.leadType??"PL"),
                                            style: fontBold.copyWith(fontWeight: FontWeight.w500,wordSpacing: 0,letterSpacing: 0,fontSize: 13.r),
                                            children: [
                                              TextSpan(text: " (${allLeadsData.leadId??"0"})", style: fontRegular.copyWith(wordSpacing: 0,letterSpacing: 0,color: AllColors.black.withOpacity(0.5),fontSize: 13.r)),
                                            ],
                                          ),
                                        ),
                                        // Text(allLeadsData.custPresentAddress??"NA", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                        Text("Update on : ${allLeadsData.leadDateTime??"NA"}", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.calendar_month,
                                              size: 14.r,
                                              color: AllColors.black.withOpacity(0.6),
                                            ),
                                            SizedBox(width: 5.r),
                                            Text(allLeadsData.nextFollowupDate??"NA", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w500),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: ()=> launch("tel://+91${allLeadsData.custPhone}"),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12.r,vertical: 3.r),
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
                                      SizedBox(width: 10.r),
                                      SizedBox(
                                        height: 20.r,
                                        width: 20.r,
                                        child: Obx(()=>  PopupMenuButton(
                                          padding: EdgeInsets.symmetric(horizontal: 0.r),
                                          position: PopupMenuPosition.over,
                                          offset: Offset.zero,
                                          initialValue: selectedMenu.value,
                                          onSelected: (value) {
                                            selectedMenu.value = value.toString();
                                            print("object $value");
                                            if(value == "Transfer Lead"){
                                              Get.to(()=> CustomerDetails(leadId: "${allLeadsData.id??""}",customerId: allLeadsData.custId??"",value: "leadDetails",apiLeadId: allLeadsData.leadId,pageName: "unassignedLead",leadTransferName: "transferLead",customerLoanListDetails: "customerLoanListDetails"));
                                            }
                                            else{
                                              Get.to(()=> CustomerDetails(leadId: "${allLeadsData.id??""}",customerId: allLeadsData.custId??"",value: "leadDetails",apiLeadId: allLeadsData.leadId,pageName: "unassignedLead",leadTransferName: "unassignedTransferLead",customerLoanListDetails: "customerLoanListDetails"));
                                            }
                                          },
                                          itemBuilder: (BuildContext context) => [
                                            PopupMenuItem(
                                              value: 'Set Follow-up'.tr,
                                              child: Text('Set Follow-up',style: fontMedium.copyWith()),
                                            ),
                                            PopupMenuItem(
                                              value: 'Mark Hot Lead'.tr,
                                              child: Text('Mark Hot Lead',style: fontMedium.copyWith()),
                                            ),
                                            PopupMenuItem(
                                              value: 'Transfer Lead'.tr,
                                              child: Text('Transfer Lead',style: fontMedium.copyWith()),
                                            ),
                                            PopupMenuItem(
                                              value: 'Delete Lead'.tr,
                                              child: RichText(
                                                text: TextSpan(
                                                  text: 'Delete Lead ',
                                                  style: fontMedium.copyWith(),
                                                  children: [
                                                    TextSpan(text: '(Draft)', style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.5))),
                                                  ],
                                                ),
                                              ),
                                              // child: Text('Delete Lead',style: fontMedium.copyWith()),
                                            ),
                                          ],
                                          icon: Container(
                                            padding: EdgeInsets.all(2.r),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100.r),
                                                border: Border.all(width: 0.5, color: AllColors.grey.withOpacity(0.6))
                                            ),
                                            child: Icon(
                                              Icons.keyboard_arrow_down_sharp,
                                              size: 16.r,
                                              color: AllColors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                if(controller.customerDetails.value.data.allLeade.isEmpty)
                  SizedBox(height: 15.r),
                if(controller.customerDetails.value.data.allLeade.isEmpty)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.r),
                    padding: EdgeInsets.symmetric(vertical: 10.r),
                    color: AllColors.white,
                    alignment: Alignment.center,
                    child: Text("No data available",style: fontRegular.copyWith(letterSpacing: 0,),
                    ),
                  ),
              ],
            ),
            ),
          ),
        ),
      ),
    );
  }
}
