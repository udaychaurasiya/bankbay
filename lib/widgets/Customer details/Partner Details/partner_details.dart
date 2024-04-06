import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/widgets/Customer%20details/Partner%20Details/Details/partner_details_about.dart';
import 'package:bank_bay/widgets/Customer%20details/Partner%20Details/Details/partner_details_access.dart';
import 'package:bank_bay/widgets/Customer%20details/Partner%20Details/Details/partner_details_docs.dart';
import 'package:bank_bay/widgets/Customer%20details/Partner%20Details/Details/partner_details_kyc.dart';
import 'package:bank_bay/widgets/Customer%20details/Partner%20Details/Details/partner_details_payroll.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

RxInt partnerDetailsTab = 1.obs;
class PartnerDetails extends StatefulWidget {
  final String partnerId;
  final String pageName;
  const PartnerDetails({super.key, required this.partnerId, required this.pageName});

  @override
  State<PartnerDetails> createState() => _PartnerDetailsState();
}

class _PartnerDetailsState extends State<PartnerDetails> {
  final PartnerController controller = Get.find<PartnerController>();

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
            Obx(()=>partnerDetailsTab.value!=-1?
            Container(
              color: AllColors.lightBlue.withOpacity(0.1),
              height: 40.r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: ()=> partnerDetailsTab.value=1,
                    child: AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: partnerDetailsTab.value==1? AllColors.themeColor:AllColors.none))
                      ),
                      child: Text("About".tr,
                        style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color:  AllColors.themeColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: ()=> partnerDetailsTab.value=2,
                    child: AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: partnerDetailsTab.value==2? AllColors.themeColor:AllColors.none))
                      ),
                      child: Text("KYC".tr,
                        style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color:  AllColors.themeColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: ()=> partnerDetailsTab.value=3,
                    child: AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: partnerDetailsTab.value==3? AllColors.themeColor:AllColors.none))
                      ),
                      child: Text("Docs".tr,
                        style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color: AllColors.themeColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: ()=> partnerDetailsTab.value=4,
                    child: AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: partnerDetailsTab.value==4?AllColors.themeColor:AllColors.none))
                      ),
                      child: Text("Payroll".tr,
                        style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color: AllColors.themeColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: ()=> partnerDetailsTab.value=5,
                    child: AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: partnerDetailsTab.value==5?AllColors.themeColor:AllColors.none))
                      ),
                      child: Text("Access".tr,
                        style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color: AllColors.themeColor),
                      ),
                    ),
                  ),
                ],
              ),
            ) : const SizedBox()),
            Obx((){
              if(partnerDetailsTab.value == 1){
                return PartnerDetailsAboutScreen(partnerDetails: controller.customerDetails.value.data, pageName: widget.pageName.toString());
              }else if(partnerDetailsTab.value == 2){
                return PartnerDetailsKYCScreen(partnerDetails: controller.customerDetails.value.data);
              }else if(partnerDetailsTab.value == 3){
                return PartnerDetailsDocsScreen(partnerDetails: controller.customerDetails.value.data);
              }else if(partnerDetailsTab.value == 4){
                return PartnerDetailsPayrollScreen(partnerDetails: controller.customerDetails.value.data);
              }else if(partnerDetailsTab.value == 5){
                return PartnerDetailsAccessScreen(partnerDetails: controller.customerDetails.value.data);
              }else{
                return const SizedBox();
              }
            }),
          ],
        ),
    );
  }
}
