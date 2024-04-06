import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/widgets/Partner/all_partner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'partner_approval.dart';
import 'partner_pushback.dart';
import 'partner_request.dart';


RxInt partnerTab = 2.obs;
class PartnerHomeScreen extends StatefulWidget {
  const PartnerHomeScreen({super.key});

  @override
  State<PartnerHomeScreen> createState() => _PartnerHomeScreenState();
}

class _PartnerHomeScreenState extends State<PartnerHomeScreen> {
  @override
  void initState() {
    /*if(GetStorage().read(AppConstant.partner_add).toString().toLowerCase() == "no"&& GetStorage().read(AppConstant.partner_pending_approval).toString().toLowerCase() == "yes"){
      partnerTab.value=2;
    }else */if(GetStorage().read(AppConstant.add_emp).toString().toLowerCase() == "no"&& GetStorage().read(AppConstant.partner_push_back).toString().toLowerCase() == "yes"){
      partnerTab.value=3;
    }else if(GetStorage().read(AppConstant.add_emp).toString().toLowerCase() == "no"&& GetStorage().read(AppConstant.partner_view_all).toString().toLowerCase() == "yes"){
      partnerTab.value=4;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    partnerTab.value=2;
    return Scaffold(
      backgroundColor: Colors.lightBlue.withOpacity(0.1),
      body: ((GetStorage().read(AppConstant.partner_add).toString().toLowerCase() == "no"&&
          GetStorage().read(AppConstant.partner_pending_approval).toString().toLowerCase() == "no")&&
          (GetStorage().read(AppConstant.partner_pending_approval).toString().toLowerCase() == "no"&&
          (GetStorage().read(AppConstant.partner_push_back).toString().toLowerCase() == "no"&&
          GetStorage().read(AppConstant.partner_view_all).toString().toLowerCase() == "no")))?
      defaultPartnerWidget(context) :
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40.r,
            color: AllColors.blue,
            padding: EdgeInsets.symmetric(horizontal: 5.r),
            child: Obx(() => ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    // if(GetStorage().read(AppConstant.partner_add).toString().toLowerCase() == "yes")
                    // InkWell(
                    //   onTap: (){
                    //     partnerTab.value=1;
                    //     addPartnerTab.value = 1;
                    //   },
                    //   child: AnimatedContainer(
                    //     curve: Curves.linearToEaseOut,
                    //     duration: const Duration(milliseconds: 200),
                    //     alignment: Alignment.center,
                    //     padding: EdgeInsets.symmetric(horizontal: 10.r),
                    //     decoration: BoxDecoration(
                    //       border: Border(bottom: BorderSide(width: 3.r, color: partnerTab.value==1?AllColors.yellow:AllColors.none))
                    //     ),
                    //     child: Text("Add Partner".tr,
                    //       style:  fontSmall.copyWith(wordSpacing: 0,letterSpacing: 0.4,color: partnerTab.value==1?AllColors.white:AllColors.white.withOpacity(0.6)),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(width: 5.r),
                    if(GetStorage().read(AppConstant.partner_pending_approval).toString().toLowerCase() == "yes")
                    InkWell(
                      onTap: ()=> partnerTab.value=2,
                      child: AnimatedContainer(
                        curve: Curves.linearToEaseOut,
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 10.r),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: partnerTab.value==2?AllColors.yellow:AllColors.none))
                        ),
                        child: Text("Request".tr,
                          style:  fontSmall.copyWith(wordSpacing: 0,letterSpacing: 0.4,color: partnerTab.value==2?AllColors.white:AllColors.white.withOpacity(0.6)),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.r),
                    if(GetStorage().read(AppConstant.partner_pending_approval).toString().toLowerCase() == "yes")
                    InkWell(
                      onTap: ()=> partnerTab.value=3,
                      child: AnimatedContainer(
                        curve: Curves.linearToEaseOut,
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 10.r),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: partnerTab.value==3?AllColors.yellow:AllColors.none))
                        ),
                        child: Text("Approval".tr,
                          style:  fontSmall.copyWith(wordSpacing: 0,letterSpacing: 0.4,color: partnerTab.value==3?AllColors.white:AllColors.white.withOpacity(0.6)),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.r),
                    if(GetStorage().read(AppConstant.partner_push_back).toString().toLowerCase() == "yes")
                    InkWell(
                      onTap: ()=> partnerTab.value=4,
                      child: AnimatedContainer(
                        curve: Curves.linearToEaseOut,
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 10.r),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: partnerTab.value==4?AllColors.yellow:AllColors.none))
                        ),
                        child: Text("Pushback".tr,
                          style:  fontSmall.copyWith(wordSpacing: 0,letterSpacing: 0.4,color: partnerTab.value==4?AllColors.white:AllColors.white.withOpacity(0.6)),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.r),
                    if(GetStorage().read(AppConstant.partner_view_all).toString().toLowerCase() == "yes")
                    InkWell(
                      onTap: ()=> partnerTab.value=5,
                      child: AnimatedContainer(
                        curve: Curves.linearToEaseOut,
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 10.r),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: partnerTab.value==5?AllColors.yellow:AllColors.none))
                        ),
                        child: Text("All Partner".tr,
                          style:  fontSmall.copyWith(wordSpacing: 0,letterSpacing: 0.4,color: partnerTab.value==5?AllColors.white:AllColors.white.withOpacity(0.6)),
                        ),
                      ),
                    ),
                  ],
                ),
            ),
            ),
          Expanded(
            child: Obx((){
              /*if(partnerTab.value==1){
                return const AddPartnerScreen();
              }else */if(partnerTab.value==2){
                return const PartnerApprovalScreen();
              }else if(partnerTab.value==3){
                return const PartnerRequestScreen();
              }else if(partnerTab.value==4){
                return const PartnerPushbackScreen();
              }else if(partnerTab.value==5){
                return const AllPartnerScreen();
              }else{
                return const PartnerApprovalScreen();
              }
            }),
          ),
        ],
      ),
    );
  }
  Padding defaultPartnerWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20.r),
          Padding(
            padding: EdgeInsets.symmetric(vertical:30.0.r),
            child: Text("Partner permission",style: fontBold.copyWith(fontSize: 18.r),),
          ),
          SizedBox(height: 20.r),
          Text("It seems like your question is a bit unclear. If you're asking about employees not having permission for a specific title or subtitle, it could pertain to various scenarios, such as access to certain documents, systems, or areas within a company."
              "\n\nIf you could provide more details or context, I'd be happy to help you with a more specific and accurate answer. "
              "\n\nAre you referring to permissions within a particular software system, access to certain information, or something else? "
              "\n\nClarifying your question will enable me to provide you with more targeted assistance.", style: fontRegular.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.7))),
          SizedBox(height: 60.r),
          CustomButton(
            title: "You have not any partner permission!!".tr,
            background: true,
            miniFont: true,
            // width: Get.width-5,
          ),
        ],
      ),
    );
  }
}
