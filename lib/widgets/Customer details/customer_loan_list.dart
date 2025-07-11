// ignore_for_file: deprecated_member_use

import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils_method/custom_image_view.dart';
import 'package:bank_bay/widgets/Customer%20details/Loan%20List%20details/loan_List_document.dart';
import 'package:bank_bay/widgets/Customer%20details/Loan%20List%20details/loan_list_details_kyc.dart';
import 'package:bank_bay/widgets/Customer%20details/Loan%20List%20details/loan_list_details_status.dart';
import 'package:bank_bay/widgets/Customer%20details/Loan%20List%20details/loan_list_form_deatail.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

RxInt leadListDetailsTab = 1.obs;
class CustomerLoanList extends StatefulWidget {
  final String? customerId;
  const CustomerLoanList({super.key, required this.customerId});

  @override
  State<CustomerLoanList> createState() => _CustomerLoanListState();
}

class _CustomerLoanListState extends State<CustomerLoanList> {
  var controller = Get.find<PartnerController>();
  var selectedMenu = "Set Follow-up".obs;

  @override
  void initState() {
    controller.getCustomerDetailsNetworkApi(widget.customerId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(
      builder:(controller)=> Column(
        children: [
          if(controller.customerDetails.value.data.allLeade.isNotEmpty)
            Container(
              color: AllColors.white,
              child: ListView.builder(
                itemCount: controller.customerDetails.value.data.allLeade.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var allLeadsData = controller.customerDetails.value.data.allLeade[index];
                  return Obx(() => Container(
                    decoration: BoxDecoration(
                      border: index==0?null:Border(top: BorderSide(color: AllColors.lightGrey))
                    ),
                    child: ExpansionTile(
                          tilePadding: EdgeInsets.only(right: 8.r, top: 8.r, left: 5.r),
                          collapsedTextColor: Colors.amber,
                          childrenPadding: EdgeInsets.zero,
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          controlAffinity: ListTileControlAffinity.trailing,
                          expandedAlignment: Alignment.topCenter,
                          textColor: Colors.amber,
                          initiallyExpanded: false,
                          onExpansionChanged: (value){},
                          trailing:  SizedBox(
                            width: 85.r,
                            child: Row(
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
                                        // controller.getMyLeadNetworkApi("","",value=="Personal Loan"?"PL":value=="Business Loan"?"BL":value=="Self-Employee Loan"?"SEL":"Pl");
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
                          ),
                          key: const Key("2"),
                          title: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.0.r, vertical: 5.r),
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
                                      Text("Last update on : ${allLeadsData.leadDateTime??"NA"}", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.calendar_month,
                                            size: 14.r,
                                            color: AllColors.black.withOpacity(0.6),
                                          ),
                                          SizedBox(width: 5.r),
                                          Text("${allLeadsData.leadDateTime??"NA"}", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w500),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          children: [
                            SizedBox(height: 10.r),
                            Obx(()=> Container(
                              color: AllColors.lightBlue.withOpacity(0.1),
                              height: 40.r,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: ()=> leadListDetailsTab.value=1,
                                    child: AnimatedContainer(
                                      curve: Curves.linearToEaseOut,
                                      duration: const Duration(milliseconds: 200),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                                      decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(width: 3.r, color: leadListDetailsTab.value==1? AllColors.themeColor:AllColors.none))
                                      ),
                                      child: Text("Status".tr,
                                        style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color:  AllColors.themeColor),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: ()=> leadListDetailsTab.value=2,
                                    child: AnimatedContainer(
                                      curve: Curves.linearToEaseOut,
                                      duration: const Duration(milliseconds: 200),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                                      decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(width: 3.r, color: leadListDetailsTab.value==2? AllColors.themeColor:AllColors.none))
                                      ),
                                      child: Text("Loan Details".tr,
                                        style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color:  AllColors.themeColor),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: ()=> leadListDetailsTab.value=3,
                                    child: AnimatedContainer(
                                      curve: Curves.linearToEaseOut,
                                      duration: const Duration(milliseconds: 200),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                                      decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(width: 3.r, color: leadListDetailsTab.value==3? AllColors.themeColor:AllColors.none))
                                      ),
                                      child: Text("KYC".tr,
                                        style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color: AllColors.themeColor),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: ()=> leadListDetailsTab.value=4,
                                    child: AnimatedContainer(
                                      curve: Curves.linearToEaseOut,
                                      duration: const Duration(milliseconds: 200),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                                      decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(width: 3.r, color: leadListDetailsTab.value==4?AllColors.themeColor:AllColors.none))
                                      ),
                                      child: Text("Document".tr,
                                        style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color: AllColors.themeColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                            if(leadListDetailsTab.value == 1)
                              LoanListDetailsStatus(allLeade: allLeadsData),
                            if(leadListDetailsTab.value == 2)
                              LoanListFormDetail(allLeade: allLeadsData),
                            if(leadListDetailsTab.value == 3)
                              LoanListDetailsKyc(allLeade: allLeadsData),
                            if(leadListDetailsTab.value == 4)
                              LoanListDocument(allLeade: allLeadsData),
                          ]
                      ),
                    /*InkWell(
                      onTap: ()async{
                        Get.to(()=> CustomerDetails(leadId: "${allLeadsData.id??""}",customerId: allLeadsData.custId??"",value: "leadLoanList",apiLeadId: allLeadsData.leadId,leadTransferName: "unassignedTransferLead",));
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
                                      // controller.getMyLeadNetworkApi("","",value=="Personal Loan"?"PL":value=="Business Loan"?"BL":value=="Self-Employee Loan"?"SEL":"Pl");
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
                    ),*/
                  ),
                  );
                },
              ),
            ),
          if(controller.customerDetails.value.data.allLeade.isEmpty)
            Container(
              margin: EdgeInsets.symmetric(horizontal:8.r),
              padding: EdgeInsets.symmetric(vertical: 8.r),
              color: AllColors.white,
              alignment: Alignment.center,
              child: Text("No data available",style: fontRegular.copyWith(letterSpacing: 0,),
              ),
            ),
        ],
      ),
    );
  }
}
