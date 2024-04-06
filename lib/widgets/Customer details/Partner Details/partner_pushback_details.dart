import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/widgets/Customer%20details/Partner%20Details/Details/partner_details_about.dart';
import 'package:bank_bay/widgets/Customer%20details/Partner%20Details/Details/partner_details_access.dart';
import 'package:bank_bay/widgets/Customer%20details/Partner%20Details/Details/partner_details_docs.dart';
import 'package:bank_bay/widgets/Customer%20details/Partner%20Details/Details/partner_details_kyc.dart';
import 'package:bank_bay/widgets/Customer%20details/Partner%20Details/Details/partner_details_payroll.dart';
import 'package:bank_bay/widgets/Customer%20details/Partner%20Details/Push%20back/partner_pushback_about.dart';
import 'package:bank_bay/widgets/Customer%20details/Partner%20Details/Push%20back/partner_pushback_access.dart';
import 'package:bank_bay/widgets/Customer%20details/Partner%20Details/Push%20back/partner_pushback_docs.dart';
import 'package:bank_bay/widgets/Customer%20details/Partner%20Details/Push%20back/partner_pushback_kyc.dart';
import 'package:bank_bay/widgets/Customer%20details/Partner%20Details/Push%20back/partner_pushback_payroll.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

RxInt partnerPushbackDetailsTab = 1.obs;
class PartnerPushbackDetails extends StatefulWidget {
  final String pageName;
  final String partnerId;
  const PartnerPushbackDetails({super.key, required this.pageName, required this.partnerId});

  @override
  State<PartnerPushbackDetails> createState() => _PartnerPushbackDetailsState();
}
final PartnerController controller = Get.find<PartnerController>();
class _PartnerPushbackDetailsState extends State<PartnerPushbackDetails> {

  @override
  void initState() {
    controller.getCustomerDetailsNetworkApi(widget.partnerId.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AllColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(()=> partnerPushbackDetailsTab.value!=-1?
            Container(
              color: AllColors.lightBlue.withOpacity(0.1),
              height: 40.r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: ()=> partnerPushbackDetailsTab.value=1,
                    child: AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: partnerPushbackDetailsTab.value==1? AllColors.themeColor:AllColors.none))
                      ),
                      child: Text("About".tr,
                        style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color:  AllColors.themeColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: ()=> partnerPushbackDetailsTab.value=2,
                    child: AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: partnerPushbackDetailsTab.value==2? AllColors.themeColor:AllColors.none))
                      ),
                      child: Text("KYC".tr,
                        style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color:  AllColors.themeColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: ()=> partnerPushbackDetailsTab.value=3,
                    child: AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: partnerPushbackDetailsTab.value==3? AllColors.themeColor:AllColors.none))
                      ),
                      child: Text("Docs".tr,
                        style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color: AllColors.themeColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: ()=> partnerPushbackDetailsTab.value=4,
                    child: AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: partnerPushbackDetailsTab.value==4?AllColors.themeColor:AllColors.none))
                      ),
                      child: Text("Payroll".tr,
                        style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color: AllColors.themeColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: ()=> partnerPushbackDetailsTab.value=5,
                    child: AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: partnerPushbackDetailsTab.value==5?AllColors.themeColor:AllColors.none))
                      ),
                      child: Text("Access".tr,
                        style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color: AllColors.themeColor),
                      ),
                    ),
                  ),
                ],
              ),
            ):
            const SizedBox(),
          ),
          Obx(() {
            if(partnerPushbackDetailsTab.value == 1) {
              if(widget.pageName.toString()=="allPartner"){
                if(controller.customerDetails.value.data.partnerdetails.reqApproverId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()||
                    controller.customerDetails.value.data.partnerdetails.supId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()){
                  return PartnerPushbackAboutScreen(partnerId: widget.partnerId);
                }else {
                  return PartnerDetailsAboutScreen(partnerDetails: controller.customerDetails.value.data, pageName: widget.pageName.toString());
                }
              }else if(widget.pageName.toString()=="partnerRequest" && controller.customerDetails.value.data.partnerdetails.reqApproverId==null){
                return PartnerPushbackAboutScreen(partnerId: widget.partnerId);
              }else if(widget.pageName.toString()=="partnerPushback" && (controller.customerDetails.value.data.partnerdetails.supId.toString().toUpperCase()==GetStorage().read(AppConstant.cust_id).toString()||
                  controller.customerDetails.value.data.partnerdetails.partnerCreateBy.toString()==GetStorage().read(AppConstant.cust_id).toString())){
                return PartnerPushbackAboutScreen(partnerId: widget.partnerId);
              }else if(widget.pageName.toString()=="partnerDirectRequest"&& (controller.customerDetails.value.data.partnerdetails.partnerCreateBy.toString()==GetStorage().read(AppConstant.cust_id)||
                  GetStorage().read(AppConstant.partner_pending_approval).toString().toLowerCase() == "yes")){
                return PartnerPushbackAboutScreen(partnerId: widget.partnerId);
              }else{
                return PartnerDetailsAboutScreen(partnerDetails: controller.customerDetails.value.data, pageName: widget.pageName.toString());
              }
            }else if(partnerPushbackDetailsTab.value == 2) {
              if(widget.pageName.toString()=="allPartner"){
                if(controller.customerDetails.value.data.partnerdetails.reqApproverId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()||
                    controller.customerDetails.value.data.partnerdetails.supId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()){
                  return PartnerPushbackKYCScreen(partnerId: widget.partnerId);
                }else {
                  return PartnerDetailsKYCScreen(partnerDetails: controller.customerDetails.value.data);
                }
              }else if(widget.pageName.toString()=="partnerRequest" && controller.customerDetails.value.data.partnerdetails.reqApproverId==null){
                return PartnerPushbackKYCScreen(partnerId: widget.partnerId);
              }else if(widget.pageName.toString()=="partnerPushback" && (controller.customerDetails.value.data.partnerdetails.supId.toString().toUpperCase()==GetStorage().read(AppConstant.cust_id).toString()||
                  controller.customerDetails.value.data.partnerdetails.partnerCreateBy.toString()==GetStorage().read(AppConstant.cust_id).toString())){
                return PartnerPushbackKYCScreen(partnerId: widget.partnerId);
              }else if(widget.pageName.toString()=="partnerDirectRequest"&&(controller.customerDetails.value.data.partnerdetails.partnerCreateBy.toString()==GetStorage().read(AppConstant.cust_id)||
                  GetStorage().read(AppConstant.partner_pending_approval).toString().toLowerCase() == "yes")){
                return PartnerPushbackKYCScreen(partnerId: widget.partnerId);
              }else {
                return PartnerDetailsKYCScreen(partnerDetails: controller.customerDetails.value.data);
              }
            }else if(partnerPushbackDetailsTab.value == 3) {
              if(widget.pageName.toString()=="allPartner"){
                if(controller.customerDetails.value.data.partnerdetails.reqApproverId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()||
                    controller.customerDetails.value.data.partnerdetails.supId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()){
                  return PartnerPushbackDocsScreen(partnerId: widget.partnerId);
                }else {
                  return PartnerDetailsDocsScreen(partnerDetails: controller.customerDetails.value.data);
                }
              }else if(widget.pageName.toString()=="partnerRequest" && controller.customerDetails.value.data.partnerdetails.reqApproverId==null){
                return PartnerPushbackDocsScreen(partnerId: widget.partnerId);
              }else if(widget.pageName.toString()=="partnerPushback" && (controller.customerDetails.value.data.partnerdetails.supId.toString().toUpperCase()==GetStorage().read(AppConstant.cust_id).toString()||
                  controller.customerDetails.value.data.partnerdetails.partnerCreateBy.toString()==GetStorage().read(AppConstant.cust_id).toString())){
                return PartnerPushbackDocsScreen(partnerId: widget.partnerId);
              }else if(widget.pageName.toString()=="partnerDirectRequest"&& (controller.customerDetails.value.data.partnerdetails.partnerCreateBy.toString()==GetStorage().read(AppConstant.cust_id)||
                  GetStorage().read(AppConstant.partner_pending_approval).toString().toLowerCase() == "yes")){
                return PartnerPushbackDocsScreen(partnerId: widget.partnerId);
              }else {
                return PartnerDetailsDocsScreen(partnerDetails: controller.customerDetails.value.data);
              }
            }else if(partnerPushbackDetailsTab.value == 4) {
              if(widget.pageName.toString()=="allPartner"){
                if(controller.customerDetails.value.data.partnerdetails.reqApproverId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()||
                    controller.customerDetails.value.data.partnerdetails.supId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()){
                  return PartnerPushbackPayrollScreen(partnerId: widget.partnerId);
                }else {
                  return PartnerDetailsPayrollScreen(partnerDetails: controller.customerDetails.value.data);
                }
              }else if(widget.pageName.toString()=="partnerRequest" && controller.customerDetails.value.data.partnerdetails.reqApproverId==null){
                return PartnerPushbackPayrollScreen(partnerId: widget.partnerId);
              }else if(widget.pageName.toString()=="partnerPushback" && (controller.customerDetails.value.data.partnerdetails.supId.toString().toUpperCase()==GetStorage().read(AppConstant.cust_id).toString()||
                  controller.customerDetails.value.data.partnerdetails.partnerCreateBy.toString()==GetStorage().read(AppConstant.cust_id).toString())){
                return PartnerPushbackPayrollScreen(partnerId: widget.partnerId);
              }else if(widget.pageName.toString()=="partnerDirectRequest"&& (controller.customerDetails.value.data.partnerdetails.partnerCreateBy.toString()==GetStorage().read(AppConstant.cust_id)||
                  GetStorage().read(AppConstant.partner_pending_approval).toString().toLowerCase() == "yes")){
                return PartnerPushbackPayrollScreen(partnerId: widget.partnerId);
              }else {
                return PartnerDetailsPayrollScreen(partnerDetails: controller.customerDetails.value.data);
              }
            }else if(partnerPushbackDetailsTab.value == 5) {
              if(widget.pageName.toString()=="allPartner"){
                if(controller.customerDetails.value.data.partnerdetails.reqApproverId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()||
                    controller.customerDetails.value.data.partnerdetails.supId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()){
                  return PartnerPushbackAccessScreen(partnerId: widget.partnerId, pageName: widget.pageName);
                }else {
                  return PartnerDetailsAccessScreen(partnerDetails: controller.customerDetails.value.data);
                }
              }else if((widget.pageName.toString()=="partnerPushback"||widget.pageName.toString()=="partnerRequest")){
                if(widget.pageName.toString()=="partnerRequest" && controller.customerDetails.value.data.partnerdetails.reqApproverId==null){
                  return PartnerPushbackAccessScreen(partnerId: widget.partnerId, pageName: widget.pageName);
                }else if(widget.pageName.toString()=="partnerPushback" && (controller.customerDetails.value.data.partnerdetails.supId.toString().toUpperCase()==GetStorage().read(AppConstant.cust_id).toString()||
                    controller.customerDetails.value.data.partnerdetails.partnerCreateBy.toString()==GetStorage().read(AppConstant.cust_id).toString())){
                  return PartnerPushbackAccessScreen(partnerId: widget.partnerId, pageName: widget.pageName);
                }else{
                  return PartnerDetailsAccessScreen(partnerDetails: controller.customerDetails.value.data);
                }
              }else if(widget.pageName.toString()=="partnerDirectRequest"&& (controller.customerDetails.value.data.partnerdetails.partnerCreateBy.toString()==GetStorage().read(AppConstant.cust_id)||
                  GetStorage().read(AppConstant.partner_pending_approval).toString().toLowerCase() == "yes")){
                return PartnerPushbackAccessScreen(partnerId: widget.partnerId, pageName: widget.pageName);
              }else{
                return PartnerDetailsAccessScreen(partnerDetails: controller.customerDetails.value.data);
              }
            }else{
              return const SizedBox();
            }
          }),
        ],
      ),
    );
  }
}
