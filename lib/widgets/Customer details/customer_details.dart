// ignore_for_file: deprecated_member_use, use_build_context_synchronously, unnecessary_null_comparison

import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/controllers/permission_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils_method/custom_appbar.dart';
import 'package:bank_bay/utils_method/custom_image_view.dart';
import 'package:bank_bay/widgets/Customer%20details/Details/all_customer_details.dart';
import 'package:bank_bay/widgets/Customer%20details/Details/details_status.dart';
import 'package:bank_bay/widgets/Customer%20details/customer_loan_list.dart';
import 'package:bank_bay/widgets/Customer%20details/inc_due_leads_details.dart';
import 'package:bank_bay/widgets/Customer%20details/inc_view_details.dart';
import 'package:bank_bay/widgets/Customer%20details/my_loan_history_details.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerDetails extends StatefulWidget {
  final String? customerId;
  final String? leadId;
  final String? apiLeadId;
  final String? value;
  final String? pageName;
  final String? leadTransferName;
  final String? customerLoanListDetails;
  const CustomerDetails({super.key, this.customerId, this.value, this.leadId, this.apiLeadId, this.pageName, this.leadTransferName, this.customerLoanListDetails=""});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}


class _CustomerDetailsState extends State<CustomerDetails> {
  var statusValue = 1.obs;
  var controller = Get.find<PartnerController>();
  var loginController = Get.find<LoginController>();
  var permissionController = Get.find<PermissionController>();

  @override
  void initState() {
    controller.getCustomerDetailsNetworkApi(widget.customerId);
    controller.getLeadDetailsNetworkApi(widget.leadId);
    controller.check_owner_exist_tele.value.data.clear();
    controller.check_owner_exist_fos.value.data.clear();
    disbursedTeleFosTab.value=1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("customer id :--- ${widget.customerId}");
      print("lead id :--- ${widget.leadId}");
      print("api lead id :--- ${widget.apiLeadId}");
      print("value name :--- ${widget.value}");
      print("page name :--- ${widget.pageName}");
      print("transfer Lead name :--- ${widget.leadTransferName}");
    }
    leadDetailsTab.value = 1;
    leadListDetailsTab.value = 1;
    myLoanHistoryDetailsTab.value = 1;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          50.0.r,
        ),
        child: CustomAppBar(
          title: widget.value=="myLoanHistoryDetails"?
          "Loan Details": widget.pageName=="myTeamLeads"?
          "My Team Details":"Lead Details".tr,
          leadingBool: false,
          back: true,
          onTab: ()async{
            if(widget.customerLoanListDetails=="customerLoanListDetails"||widget.value=="myLoanHistoryDetails"){
              Get.back();
            }else{
              bool status = await showDetailsExitAlertDialog(context,widget.apiLeadId);
              if(status==true){
                Get.back();
              }
            }
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          if(widget.customerLoanListDetails=="customerLoanListDetails") {
            Get.back();
            return true;
          }else if(widget.value=="myLoanHistoryDetails") {
            Get.back();
            return true;
          }else{
            bool status = await showDetailsExitAlertDialog(context,widget.apiLeadId);
            return status;
          }
         },
        child: Container(
          color: Colors.lightBlue.withOpacity(0.1),
          child: SingleChildScrollView(
            child: Obx(() => Column(
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
                                                      TextSpan(text:controller.customerDetails.value.data.details.custId!=null&&controller.customerDetails.value.data.details.custId!=""?" (${controller.customerDetails.value.data.details.custId??""})":"", style: fontSmall.copyWith(fontWeight: FontWeight.w500)),
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
                    SizedBox(height: 15.r),
                    widget.value=="leadDetails"?
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.r),
                      child: AllCustomerDetails(leadId: widget.leadId, leadTransferName: widget.leadTransferName, apiLeadId: widget.apiLeadId,pageName: widget.pageName),
                    ): widget.value=="myLoanHistoryDetails"?
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.r),
                      child: MyLoanHistoryHomeDetails(leadId: widget.leadId),
                    )/*: widget.value=="leadLoanList"?
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.r),
                      child: CustomerLoanList(customerId: widget.customerId),
                    )*/:widget.value=="incDetails"?
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.r),
                      child: IncDetailsScreen(leadId: widget.leadId, apiLeadId: widget.apiLeadId,pageName: widget.pageName),
                    ):widget.value=="incDueDetails"?
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.r),
                      child: IncDueDetailsScreen(leadId: widget.leadId, apiLeadId: widget.apiLeadId,pageName: widget.pageName),
                    ):
                    const SizedBox(),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0.r, vertical: 10.r),
                      color: AllColors.white,
                      child: ListView.builder(
                        itemCount: controller.getLeadDetails.value.data.history.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var remarksData = controller.getLeadDetails.value.data.history[index];
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15.r),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1.r, color: AllColors.grey.withOpacity(0.7)),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 10.r),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: remarksData.updateByName??"NA",
                                          style: fontSmall.copyWith(fontWeight: FontWeight.w500, color: AllColors.themeColor, fontSize: 12.5.r,wordSpacing: 0, letterSpacing: 0,),
                                          children: [
                                            TextSpan(text: " (${remarksData.updatedBy??"NA"})", style: fontSmall.copyWith(fontWeight: FontWeight.w400,  fontSize: 12.r,color: AllColors.black.withOpacity(0.6),wordSpacing: 0, letterSpacing: 0, overflow: TextOverflow.ellipsis,)),
                                          ],
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 2.r),
                                      RichText(
                                        text: TextSpan(
                                          text: "Date : ",
                                          style: fontSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),wordSpacing: 0, letterSpacing: 0, fontSize: 11.r, overflow: TextOverflow.ellipsis),
                                          children: [
                                            TextSpan(text: remarksData.datetime??"", style: fontSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),wordSpacing: 0, letterSpacing: 0, fontSize: 11.r, overflow: TextOverflow.ellipsis)),
                                          ],
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(width: 1.r),
                                      Text(remarksData.notes??"", style: fontSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),wordSpacing: 0, letterSpacing: 0),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },),
                    ),
                    /// hold view card
                    if(controller.getLeadDetails.value.data.holdHistory.remarks.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(left:10.0.r, right: 10.0.r, top: 10.0.r),
                        padding: EdgeInsets.only(bottom:10.0.r, ),
                        color: AllColors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Get.width,
                              padding: EdgeInsets.all(11.r),
                              color: AllColors.grey.withOpacity(0.4),
                              child: Text("Hold History",style: fontMedium.copyWith()),
                            ),
                            SizedBox(height: 10.r),
                            ListView.builder(
                                itemCount: controller.getLeadDetails.value.data.holdHistory.remarks.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(top: index==0?0:3.r),
                                    child: ViewDataDetailsCheck(
                                      title: controller.getLeadDetails.value.data.holdHistory.remarks[index].reason.tr,
                                      status: "yes",
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    /// Verified view card
                    if(controller.getLeadDetails.value.data.verifiedHistory.remarks.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(left:10.0.r, right: 10.0.r, top: 10.0.r),
                        padding: EdgeInsets.only(bottom:10.0.r, ),
                        color: AllColors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Get.width,
                              padding: EdgeInsets.all(11.r),
                              color: AllColors.grey.withOpacity(0.4),
                              child: Text("Verified History",style: fontMedium.copyWith()),
                            ),
                            SizedBox(height: 10.r),
                            ViewDataDetailsCheck(
                              title: "Is customer interested in availing loan".tr,
                              status: controller.getLeadDetails.value.data.verifiedHistory.remarks[0].isCustomerInterestedInAvailingLoan.toString().toLowerCase().tr,
                            ),
                            SizedBox(height: 5.r),
                            ViewDataDetailsCheck(
                              title: "How soon the customer wants loan".tr,
                              status: controller.getLeadDetails.value.data.verifiedHistory.remarks[1].howSoonTheCustomerWantsLoan.toString().toLowerCase().tr,
                            ),
                            SizedBox(height: 5.r),
                            ViewDataDetailsCheck(
                              title: "Has customer applied for loan in last 12 months".tr,
                              status: controller.getLeadDetails.value.data.verifiedHistory.remarks[2].hasCustomerAppliedForLoanInLast12Months.toString().toLowerCase().tr,
                            ),
                            SizedBox(height: 5.r),
                            ViewDataDetailsCheck(
                              title: "Is somebody else is processing loan as well".tr,
                              status: controller.getLeadDetails.value.data.verifiedHistory.remarks[3].isSomebodyElseIsProcessingLoanAsWell.toString().toLowerCase().tr,
                            ),
                            SizedBox(height: 5.r),
                            ViewDataDetailsCheck(
                              title: "Is customer user of Bankbay application".tr,
                              status: controller.getLeadDetails.value.data.verifiedHistory.remarks[4].isCustomerUserOfBankbayApplication.toString().toLowerCase().tr,
                            ),
                            SizedBox(height: 5.r),

                          ],
                        ),
                      ),
                    /// Rejected view card
                    if(controller.getLeadDetails.value.data.rejectedHistory.remarks.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(left:10.0.r, right: 10.0.r, top: 10.0.r),
                        padding: EdgeInsets.only(bottom:10.0.r, ),
                        color: AllColors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Get.width,
                              padding: EdgeInsets.all(11.r),
                              color: AllColors.grey.withOpacity(0.4),
                              child: Text("Rejected History",style: fontMedium.copyWith()),
                            ),
                            SizedBox(height: 10.r),
                            ListView.builder(
                                itemCount: controller.getLeadDetails.value.data.rejectedHistory.remarks.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(top: index==0?0:3.r),
                                    child: ViewDataDetailsCheck(
                                      title: controller.getLeadDetails.value.data.rejectedHistory.remarks[index].reason,
                                      status: "yes",
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    /// Login view card
                    if(controller.getLeadDetails.value.data.loginBankName!=null&&controller.getLeadDetails.value.data.loginBankName!="")
                      Container(
                        margin: EdgeInsets.only(left:10.0.r, right: 10.0.r, top: 10.0.r),
                        padding: EdgeInsets.only(bottom:10.0.r, ),
                        color: AllColors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Get.width,
                              padding: EdgeInsets.all(11.r),
                              color: AllColors.grey.withOpacity(0.4),
                              child: Text("Login History",style: fontMedium.copyWith()),
                            ),
                            SizedBox(height: 8.r),
                            ViewDataDetails(
                              title: "Bank Name".tr,
                              subTitle: controller.getLeadDetails.value.data.loginBankName??"",
                            ),
                            ViewDataDetails(
                              title: "Login Date".tr,
                              subTitle: controller.getLeadDetails.value.data.bankLoginDate??"",
                            ),
                            ViewDataDetails(
                              title: "Amount".tr,
                              subTitle: "${controller.getLeadDetails.value.data.loanAmount??""}",
                            ),
                            ViewDataDetails(
                              title: "Tenure".tr,
                              subTitle: controller.getLeadDetails.value.data.loginTenure??"",
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal:11.0.r, vertical: 8.r),
                              child: InkWell(
                                onTap: ()=> Get.to(()=> CustomImageView(imageUrls: AppConstants.BASE_URL+controller.getLeadDetails.value.data.applicationForm.toString())),
                                child: Container(
                                  height: 80.r,
                                  width: 80.r,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1.r, color: AllColors.grey.withOpacity(0.7)),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: AppConstants.BASE_URL+controller.getLeadDetails.value.data.applicationForm.toString(),
                                    fadeOutDuration: const Duration(seconds: 2),
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
                                        Icon(Icons.error, size: 40.r, color: AllColors.orange.withOpacity(0.7),),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    /// Sanctioned view card
                    if((controller.getLeadDetails.value.data.sancDate!=null&&controller.getLeadDetails.value.data.sancDate!="")||
                        (controller.getLeadDetails.value.data.syncTenure!=null&&controller.getLeadDetails.value.data.syncTenure!=""))
                      Container(
                        margin: EdgeInsets.only(left:10.0.r, right: 10.0.r, top: 10.0.r),
                        padding: EdgeInsets.only(bottom:10.0.r, ),
                        color: AllColors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Get.width,
                              padding: EdgeInsets.all(11.r),
                              color: AllColors.grey.withOpacity(0.4),
                              child: Text("Sanctioned History",style: fontMedium.copyWith()),
                            ),
                            SizedBox(height: 8.r),
                            ViewDataDetails(
                                title: "Submit Date".tr,
                                subTitle: controller.getLeadDetails.value.data.sancDate??""
                            ),
                            ViewDataDetails(
                              title: "Duration".tr,
                              subTitle: "${controller.getLeadDetails.value.data.sancDuration??""}",
                            ),
                            ViewDataDetails(
                              title: "Amount".tr,
                              subTitle: "${controller.getLeadDetails.value.data.sancAmt??""}",
                            ),
                            ViewDataDetails(
                              title: "Tenure".tr,
                              subTitle: controller.getLeadDetails.value.data.syncTenure??"",
                            ),
                            ViewDataDetails(
                              title: "Roi".tr,
                              subTitle: controller.getLeadDetails.value.data.sancRoi??"",
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal:11.0.r, vertical: 8.r),
                              child: InkWell(
                                onTap: ()=> Get.to(()=> CustomImageView(imageUrls: AppConstants.BASE_URL+controller.getLeadDetails.value.data.syncLatter.toString())),
                                child: Container(
                                  height: 80.r,
                                  width: 80.r,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1.r, color: AllColors.grey.withOpacity(0.7)),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: AppConstants.BASE_URL+controller.getLeadDetails.value.data.syncLatter.toString(),
                                    fadeOutDuration: const Duration(seconds: 2),
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
                                        Icon(Icons.error, size: 40.r, color: AllColors.orange.withOpacity(0.7),),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    /// Disbursed view card
                    if((controller.getLeadDetails.value.data.disbBankName!=null&&controller.getLeadDetails.value.data.disbBankName!="")||
                        (controller.getLeadDetails.value.data.disbBankAccountName!=null&&controller.getLeadDetails.value.data.disbBankAccountName!=""))
                      Container(
                        margin: EdgeInsets.only(left:10.0.r, right: 10.0.r, top: 10.0.r),
                        padding: EdgeInsets.only(bottom:10.0.r, ),
                        color: AllColors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Get.width,
                              padding: EdgeInsets.all(11.r),
                              color: AllColors.grey.withOpacity(0.4),
                              child: Text("Disbursed History",style: fontMedium.copyWith()),
                            ),
                            SizedBox(height: 8.r),
                            ViewDataDetails(
                              title: "Bank Name".tr,
                              subTitle: controller.getLeadDetails.value.data.disbBankName??"",
                            ),
                            ViewDataDetails(
                              title: "Bank Account Name".tr,
                              subTitle: controller.getLeadDetails.value.data.disbBankAccountName??"",
                            ),
                            ViewDataDetails(
                              title: "Bank Account No".tr,
                              subTitle: controller.getLeadDetails.value.data.disbBankAccountNo??"",
                            ),
                            ViewDataDetails(
                              title: "IFSC Code".tr,
                              subTitle: controller.getLeadDetails.value.data.disbBankIfsc??"",
                            ),
                            ViewDataDetails(
                              title: "Method".tr,
                              subTitle: controller.getLeadDetails.value.data.disbMethod??"",
                            ),
                            ViewDataDetails(
                              title: "Submit Date".tr,
                              subTitle: controller.getLeadDetails.value.data.disbDate??"",
                            ),
                            ViewDataDetails(
                              title: "Amount".tr,
                              subTitle: "${controller.getLeadDetails.value.data.disbAmt??""}",
                            ),
                            ViewDataDetails(
                              title: "Tenure".tr,
                              subTitle: controller.getLeadDetails.value.data.disbTenure??"",
                            ),
                            ViewDataDetails(
                              title: "Roi".tr,
                              subTitle: controller.getLeadDetails.value.data.disbRoi??"",
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal:11.0.r, vertical: 8.r),
                              child: InkWell(
                                onTap: ()=> Get.to(()=> CustomImageView(imageUrls: AppConstants.BASE_URL+controller.getLeadDetails.value.data.disbLatter.toString())),
                                child: Container(
                                  height: 80.r,
                                  width: 80.r,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1.r, color: AllColors.grey.withOpacity(0.7)),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: AppConstants.BASE_URL+controller.getLeadDetails.value.data.disbLatter.toString(),
                                    fadeOutDuration: const Duration(seconds: 2),
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
                                        Icon(Icons.error, size: 40.r, color: AllColors.orange.withOpacity(0.7),),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    /// remarks history
                    SizedBox(height: 15.r),
                  ],
                ),
            ),
            ),
          ),
        ),
    );
  }
  Future<dynamic> showDetailsExitAlertDialog(BuildContext context,id) async {
    return showDialog(
      context: context,
      builder: (context) =>AlertDialog(
        title: Text('Confirmation',style: fontMedium.copyWith(),),
        content: Text('Do you want to exit Details page?',style: fontRegular.copyWith(wordSpacing: 0,letterSpacing: 0),),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('No',style: TextStyle(color: AllColors.red, fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: ()async{
              bool status = await permissionController.lockUnlockLeadNetworkApi(id, "false");
              if(status==true){
                print("page Name ${widget.pageName}");
                switch (widget.pageName) {
                  case "myLead":
                    Get.back(
                        result: {
                          loginController.freshLeadNetworkApi(),
                          loginController.getMyLeadNetworkApi("","","","","","","",""),
                          Navigator.of(context).pop(true),
                        }
                    );
                    break;
                  case "teamLead":
                    Get.back(
                        result: {
                          loginController.teamLeadsNetworkApi("","","","","","","","",loginController.filterTypeSelected.value,loginController.isTeamLeadEmpSelected.value,controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value)),
                          Navigator.of(context).pop(true),
                        }
                    );
                    break;
                  case "newLead":
                    Get.back(
                        result: {
                          loginController.allLeadsDataNetworkApi("","","",controller.loanTypeDecode(loginController.selectLoanType.value.toString()),"","","",controller.leadStatusNameFilter(loginController.leadsPageName.value.toString()),controller.sourceFilterSendValue(loginController.filterTypeSelected.value.toString()),controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value)),
                          Navigator.of(context).pop(true),
                        }
                    );
                    break;
                  case "verificationLead":
                    Get.back(
                        result: {
                          loginController.verificationNetworkApi("","","",controller.loanTypeDecode(loginController.selectLoanType.value.toString()),"","","",controller.leadStatusNameFilter(loginController.leadsPageName.value),controller.sourceFilterSendValue(loginController.filterTypeSelected.value),controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value)),
                          Navigator.of(context).pop(true),
                        }
                    );
                    break;
                  case "loginLead":
                    Get.back(
                        result: {
                          loginController.loginLeadsNetworkApi("","",controller.loanTypeDecode(loginController.selectLoanType.value.toString()),"","","","","",controller.leadStatusNameFilter(loginController.leadsPageName.value), controller.sourceFilterSendValue(loginController.filterTypeSelected.value),controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value)),
                          Navigator.of(context).pop(true),
                        }
                    );
                    break;
                  case "sanctionedLead":
                    Get.back(
                        result: {
                          loginController.sanctionedLeadsNetworkApi("","",controller.loanTypeDecode(loginController.selectLoanType.value.toString()),"","","","","",controller.leadStatusNameFilter(loginController.leadsPageName.value), controller.sourceFilterSendValue(loginController.filterTypeSelected.value),controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value)),
                          Navigator.of(context).pop(true),
                        }
                    );
                    break;
                  case "disbursedLead":
                    Get.back(
                        result: {
                          loginController.disbursedLeadsNetworkApi("","",controller.loanTypeDecode(loginController.selectLoanType.value.toString()),"","","","","",controller.leadStatusNameFilter(loginController.leadsPageName.value), controller.sourceFilterSendValue(loginController.filterTypeSelected.value),controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value)),
                          Navigator.of(context).pop(true),
                        }
                    );
                    break;
                  case "incentiveLead":
                    Get.back(
                        result: {
                          loginController.incentiveDataNetworkApi("","",controller.loanTypeDecode(loginController.selectLoanType.value.toString()),"","","","","", controller.sourceFilterSendValue(loginController.filterTypeSelected.value),controller.leadStatusNameFilter(loginController.leadsPageName.value),controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value)),
                          Navigator.of(context).pop(true),
                        }
                    );
                    break;

                }
              }
            },
            child: Text('Yes', style: TextStyle(color: AllColors.green, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class ViewDataDetails extends StatelessWidget {
  final String title;
  final String subTitle;
  const ViewDataDetails({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0.r, horizontal: 10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                  width: Get.width/3.1,
                  child: Text(title.toString(), style: fontSmall.copyWith(fontWeight: FontWeight.w600,color: AllColors.themeColor,wordSpacing: 0, letterSpacing: 0, fontSize: 11.r, overflow: TextOverflow.ellipsis))),
              Expanded(child: Text(subTitle.tr, style: fontSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.7),wordSpacing: 0, letterSpacing: 0, fontSize: 11.r, overflow: TextOverflow.ellipsis))),
            ],
          ),
        ],
      ),
    );
  }
}

class ViewDataDetailsCheck extends StatelessWidget {
  final String title;
  final String status;
  const ViewDataDetailsCheck({super.key, required this.title, required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0.r, horizontal: 10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(title.toString(), style: fontSmall.copyWith(fontWeight: FontWeight.w600,color: AllColors.themeColor,wordSpacing: 0, letterSpacing: 0, fontSize: 11.r, overflow: TextOverflow.ellipsis))),
              SizedBox(width: 8.r),
              if(status!=null&&status!="")
                if(status.toLowerCase()=="yes")
                  Image.asset(Images.pushback, height: 20.r, width: 20.r, color: AllColors.green,),
              if(status!=null&&status!="")
                if(status.toLowerCase()=="no")
                  Image.asset(Images.rejected, height: 20.r, width: 20.r),
            ],
          ),
        ],
      ),
    );
  }
}
