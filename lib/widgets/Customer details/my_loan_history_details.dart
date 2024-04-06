import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/widgets/Customer%20details/Draft%20Lead/draft_loan_docs.dart';
import 'package:bank_bay/widgets/Customer%20details/Draft%20Lead/draft_loan_form.dart';
import 'package:bank_bay/widgets/Customer%20details/Draft%20Lead/draft_loan_kyc.dart';
import 'package:bank_bay/widgets/Customer%20details/Loan%20History%20Details/loan_history_details_status.dart';
import 'package:bank_bay/widgets/Customer%20details/Loan%20History%20Details/my_loan_history_deatail.dart';
import 'package:bank_bay/widgets/Customer%20details/Loan%20History%20Details/my_loan_history_deatils_document.dart';
import 'package:bank_bay/widgets/Customer%20details/Loan%20History%20Details/my_loan_history_details_kyc.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

RxInt myLoanHistoryDetailsTab = 1.obs;
class MyLoanHistoryHomeDetails extends StatefulWidget {
  final String? leadId;
  const MyLoanHistoryHomeDetails({super.key, required this.leadId});

  @override
  State<MyLoanHistoryHomeDetails> createState() => _MyLoanHistoryHomeDetailsState();
}

class _MyLoanHistoryHomeDetailsState extends State<MyLoanHistoryHomeDetails> {
    PartnerController controller = Get.find<PartnerController>();

    @override
    void initState() {
      controller.getLeadDetailsNetworkApi(widget.leadId);
      myLoanHistoryDetailsTab.value=1;
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
                RichText(
                  text: TextSpan(
                    text: controller.loanTypeEncode(controller.getLeadDetails.value.data.leadType??"PL"),
                    style: fontBold.copyWith(fontWeight: FontWeight.w600,wordSpacing: 0,letterSpacing: 0,fontSize: 13.r),
                    children: [
                      TextSpan(text: " (${controller.getLeadDetails.value.data.leadId??"0"})", style: fontRegular.copyWith(wordSpacing: 0,letterSpacing: 0,color: AllColors.black.withOpacity(0.6),fontSize: 13.r)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.r),
          Obx(()=>  myLoanHistoryDetailsTab.value!=-1?
            Container(
              color: AllColors.lightBlue.withOpacity(0.1),
              height: 40.r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: ()=> myLoanHistoryDetailsTab.value=1,
                    child: AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: myLoanHistoryDetailsTab.value==1? AllColors.themeColor:AllColors.none))
                      ),
                      child: Text("Status".tr,
                        style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color:  AllColors.themeColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: ()=> myLoanHistoryDetailsTab.value=2,
                    child: AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: myLoanHistoryDetailsTab.value==2? AllColors.themeColor:AllColors.none))
                      ),
                      child: Text("Loan Details".tr,
                        style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color:  AllColors.themeColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: ()=> myLoanHistoryDetailsTab.value=3,
                    child: AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: myLoanHistoryDetailsTab.value==3? AllColors.themeColor:AllColors.none))
                      ),
                      child: Text("KYC".tr,
                        style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color: AllColors.themeColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: ()=> myLoanHistoryDetailsTab.value=4,
                    child: AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: myLoanHistoryDetailsTab.value==4?AllColors.themeColor:AllColors.none))
                      ),
                      child: Text("Document".tr,
                        style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color: AllColors.themeColor),
                      ),
                    ),
                  ),
                ],
              ),
            ) :
            const SizedBox(),
          ),
          Obx(() {
            if(myLoanHistoryDetailsTab.value == 1){
              return MyLoanHistoryDetailsStatus(leadDetailsData: controller.getLeadDetails.value.data);
            }
            else if(myLoanHistoryDetailsTab.value == 2){
              if(controller.getLeadDetails.value.data.leadStatus.toString().toLowerCase()=="draft"){
                return CustomerDraftLoanForm(leadId: widget.leadId);
              }else{
                return MyLoanHistoryDetailsLoanDetail(leadDetailsData: controller.getLeadDetails.value.data);
              }
            }
            else if(myLoanHistoryDetailsTab.value == 3){
              if(controller.getLeadDetails.value.data.leadStatus.toString().toLowerCase()=="draft"){
                return CustomerDraftLoanKyc(leadId: widget.leadId);
              }else{
                return MyLoanHistoryDetailsKyc(leadDetailsData: controller.getLeadDetails.value.data);
              }
            }
            else if(myLoanHistoryDetailsTab.value == 4){
              if(controller.getLeadDetails.value.data.leadStatus.toString().toLowerCase()=="draft"){
                return CustomerDraftLoanDocs(leadId: widget.leadId);
              }else{
                return MyLoanHistoryDetailsDocument(leadDetailsData: controller.getLeadDetails.value.data);
              }
            }
            else{
              return const SizedBox();
            }
          }),
        ],
      ),
    );
  }
}
