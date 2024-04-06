import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/widgets/Partner/Add%20Partner/partner_access_widget.dart';
import 'package:bank_bay/widgets/Partner/Add%20Partner/partner_document.dart';
import 'package:bank_bay/widgets/Partner/Add%20Partner/partner_kyc_widget.dart';
import 'package:bank_bay/widgets/Partner/Add%20Partner/partner_loan_form.dart';
import 'package:bank_bay/widgets/Partner/Add%20Partner/partner_loan_form_view.dart';
import 'package:bank_bay/widgets/Partner/Add%20Partner/partner_otp.dart';
import 'package:bank_bay/widgets/Partner/Add%20Partner/partner_payroll_widget.dart';
import 'package:bank_bay/widgets/Partner/Add%20Partner/partner_selfie.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreatePartnerScreen extends StatefulWidget {
  const CreatePartnerScreen({super.key});

  @override
  State<CreatePartnerScreen> createState() => _CreatePartnerScreenState();
}

  RxInt addPartnerTab = 1.obs;
  PartnerController controller = Get.find<PartnerController>();
class _CreatePartnerScreenState extends State<CreatePartnerScreen> {

  @override
  Widget build(BuildContext context) {
    addPartnerTab.value=1;
    controller.employeeId.clear();
    controller.approvalReason.clear();
    controller.partnerCompleteIdUpdate="";
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create Partner"),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: Container(
              height: 40.r,
              color: AllColors.lightGrey,
              padding: EdgeInsets.symmetric(horizontal: 12.r),
              child: Obx(() => addPartnerTab.value!=-1 ?
                ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    InkWell(
                      // onTap: ()=> addPartnerTab.value=1,
                      child: AnimatedContainer(
                        curve: Curves.linearToEaseOut,
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 16.r),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 3.r, color: addPartnerTab.value==1||addPartnerTab.value==2||addPartnerTab.value==3||addPartnerTab.value==4?AllColors.themeColor:AllColors.none))
                        ),
                        child: Text("About".tr,
                          style:  fontMedium.copyWith(fontSize: 12.r, wordSpacing: 0,letterSpacing: 0.4,color: addPartnerTab.value==1||addPartnerTab.value==2||addPartnerTab.value==3||addPartnerTab.value==4?AllColors.black.withOpacity(0.8):AllColors.black.withOpacity(0.6)),
                        ),
                      ),
                    ),
                    InkWell(
                      // onTap: ()=> addPartnerTab.value=5,
                      child: AnimatedContainer(
                        curve: Curves.linearToEaseOut,
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 16.r),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 3.r, color: addPartnerTab.value==5?AllColors.themeColor:AllColors.none))
                        ),
                        child: Text("KYC".tr,
                          style:  fontMedium.copyWith(fontSize: 12.r, wordSpacing: 0,letterSpacing: 0.4,color: addPartnerTab.value==5?AllColors.black.withOpacity(0.8):AllColors.black.withOpacity(0.6)),
                        ),
                      ),
                    ),
                    InkWell(
                      // onTap: ()=> addPartnerTab.value=6,
                      child: AnimatedContainer(
                        curve: Curves.linearToEaseOut,
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 16.r),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 3.r, color: addPartnerTab.value==6?AllColors.themeColor:AllColors.none))
                        ),
                        child: Text("Docs".tr,
                          style:  fontMedium.copyWith(fontSize: 12.r, wordSpacing: 0,letterSpacing: 0.4,color: addPartnerTab.value==6?AllColors.black.withOpacity(0.8):AllColors.black.withOpacity(0.6)),
                        ),
                      ),
                    ),
                    InkWell(
                      // onTap: ()=> addPartnerTab.value=7,
                      child: AnimatedContainer(
                        curve: Curves.linearToEaseOut,
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 16.r),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 3.r, color: addPartnerTab.value==7?AllColors.themeColor:AllColors.none))
                        ),
                        child: Text("Payroll".tr,
                          style:  fontMedium.copyWith(fontSize: 12.r, wordSpacing: 0,letterSpacing: 0.4,color: addPartnerTab.value==7?AllColors.black.withOpacity(0.8):AllColors.black.withOpacity(0.6)),
                        ),
                      ),
                    ),
                    InkWell(
                      // onTap: ()=> addPartnerTab.value=8,
                      child: AnimatedContainer(
                        curve: Curves.linearToEaseOut,
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 18.r),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 3.r, color: addPartnerTab.value==8?AllColors.themeColor:AllColors.none))
                        ),
                        child: Text("Access".tr,
                          style:  fontMedium.copyWith(fontSize: 12.r, wordSpacing: 0,letterSpacing: 0.4,color: addPartnerTab.value==8?AllColors.black.withOpacity(0.8):AllColors.black.withOpacity(0.6)),
                        ),
                      ),
                    ),
                  ],
                ) :
                const SizedBox(),
              ),
            ),
          ),
        ),
        body: Container(
          color: Colors.lightBlue.withOpacity(0.1),
          padding: EdgeInsets.symmetric(horizontal: 10.0.r),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10.r),
            child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(addPartnerTab.value==1)
                const PartnerLoanForm(),
                if(addPartnerTab.value==2)
                const PartnerLoanFormView(),
                if(addPartnerTab.value==3)
                const PartnerOtpVerification(),
                if(addPartnerTab.value==4)
                const PartnerSelfie(),
                if(addPartnerTab.value==5)
                const PartnerKYCScreen(),
                if(addPartnerTab.value==6)
                const PartnerDocument(),
                if(addPartnerTab.value==7)
                const PartnerPayrollScreen(),
                if(addPartnerTab.value==8)
                const PartnerAccessScreen(),
              ],
            ),
            ),
          ),
        )
    );
  }


}