import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/widgets/Customer%20details/Details/deatails_loan_deatail.dart';
import 'package:bank_bay/widgets/Customer%20details/Details/deatils_document.dart';
import 'package:bank_bay/widgets/Customer%20details/Details/details_kyc.dart';
import 'package:bank_bay/widgets/Customer%20details/Details/details_status.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/Customer%20details/Draft%20Lead/draft_loan_docs.dart';
import 'package:bank_bay/widgets/Customer%20details/Draft%20Lead/draft_loan_form.dart';
import 'package:bank_bay/widgets/Customer%20details/Draft%20Lead/draft_loan_kyc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

RxInt leadDetailsTab = 1.obs;
class AllCustomerDetails extends StatefulWidget {
  final String? leadId;
  final String? apiLeadId;
  final String? leadTransferName;
  final String? pageName;
  const AllCustomerDetails({super.key, required this.leadId, this.leadTransferName, this.apiLeadId, this.pageName});

  @override
  State<AllCustomerDetails> createState() => _AllCustomerDetailsState();
}

class _AllCustomerDetailsState extends State<AllCustomerDetails> {
  PartnerController controller = Get.find<PartnerController>();

   @override
  void initState() {
     controller.getLeadDetailsNetworkApi(widget.leadId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AllColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal:8.r, vertical: 8.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(Images.house.toString(), width: 18.r,height: 18.r,),
                SizedBox(width: 10.r),
                Obx(() => RichText(
                    text: TextSpan(
                      text: controller.loanTypeEncode(controller.getLeadDetails.value.data.leadType??"PL"),
                      style: fontBold.copyWith(fontWeight: FontWeight.w600,wordSpacing: 0,letterSpacing: 0,fontSize: 13.r),
                      children: [
                        TextSpan(text: " (${controller.getLeadDetails.value.data.leadId??"0"})", style: fontRegular.copyWith(wordSpacing: 0,letterSpacing: 0,color: AllColors.black.withOpacity(0.6),fontSize: 13.r)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.r),
          Obx(()=> Container(
            color: AllColors.lightBlue.withOpacity(0.1),
            height: 40.r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: ()=> leadDetailsTab.value=1,
                  child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 3.r, color: leadDetailsTab.value==1? AllColors.themeColor:AllColors.none))
                    ),
                    child: Text("Status".tr,
                      style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color:  AllColors.themeColor),
                    ),
                  ),
                ),
                InkWell(
                  onTap: ()=> leadDetailsTab.value=2,
                  child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 3.r, color: leadDetailsTab.value==2? AllColors.themeColor:AllColors.none))
                    ),
                    child: Text("Loan Details".tr,
                      style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color:  AllColors.themeColor),
                    ),
                  ),
                ),
                InkWell(
                  onTap: ()=> leadDetailsTab.value=3,
                  child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 3.r, color: leadDetailsTab.value==3? AllColors.themeColor:AllColors.none))
                    ),
                    child: Text("KYC".tr,
                      style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color: AllColors.themeColor),
                    ),
                  ),
                ),
                InkWell(
                  onTap: ()=> leadDetailsTab.value=4,
                  child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 3.r, color: leadDetailsTab.value==4?AllColors.themeColor:AllColors.none))
                    ),
                    child: Text("Document".tr,
                      style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color: AllColors.themeColor),
                    ),
                  ),
                ),
              ],
            ),
          )),
          Obx((){
            if(leadDetailsTab.value == 1){
              return DetailsStatus(leadId: widget.leadId,leadTransferName: widget.leadTransferName, apiLeadId: widget.apiLeadId,pageName: widget.pageName);
            }
            else if(leadDetailsTab.value == 2){
              if((controller.getLeadDetails.value.data.leadStatus.toString().toLowerCase()=="draft"||controller.getLeadDetails.value.data.leadStatus.toString().toLowerCase()=="hold")&&controller.getLeadDetails.value.data.leadSource.toString()==GetStorage().read(AppConstant.cust_id)){
                return CustomerDraftLoanForm(leadId: widget.leadId);
              }else{
                return DetailsLoanDetail(leadId: widget.leadId);
              }
            }
            else if(leadDetailsTab.value == 3){
              if((controller.getLeadDetails.value.data.leadStatus.toString().toLowerCase()=="draft"||controller.getLeadDetails.value.data.leadStatus.toString().toLowerCase()=="hold")&&controller.getLeadDetails.value.data.leadSource.toString()==GetStorage().read(AppConstant.cust_id)){
                return CustomerDraftLoanKyc(leadId: widget.leadId);
              }else{
                return DetailsKyc(leadId: widget.leadId.toString(), pageName: widget.pageName.toString());
              }
            }
            else if(leadDetailsTab.value == 4){
              if((controller.getLeadDetails.value.data.leadStatus.toString().toLowerCase()=="draft"||controller.getLeadDetails.value.data.leadStatus.toString().toLowerCase()=="hold")&&controller.getLeadDetails.value.data.leadSource.toString()==GetStorage().read(AppConstant.cust_id)){
                return CustomerDraftLoanDocs(leadId: widget.leadId);
              }else{
                return DetailsDocument(leadId: widget.leadId, pageName: widget.pageName);
              }
            }
            else{
              return const SizedBox();
            }
          }),

          // if(leadDetailsTab.value == 1)
          //   DetailsStatus(leadId: widget.leadId,leadTransferName: widget.leadTransferName, apiLeadId: widget.apiLeadId,pageName: widget.pageName),
          // if(leadDetailsTab.value == 2)
          //   DetailsLoanDetail(leadId: widget.leadId),
          // if(leadDetailsTab.value == 3)
          //   DetailsKyc(leadId: widget.leadId.toString(), pageName: widget.pageName.toString()),
          // if(leadDetailsTab.value == 4)
          //   DetailsDocument(leadId: widget.leadId, pageName: widget.pageName),
        ],
      ),
    );
  }
}
