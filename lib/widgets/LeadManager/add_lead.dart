// ignore_for_file: avoid_print, invalid_use_of_protected_member, deprecated_member_use
import 'package:bank_bay/controllers/create_customer_controller.dart';
import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/widgets/Calculator/emi_calculator.dart';
import 'package:bank_bay/widgets/Calculator/fd_calculator.dart';
import 'package:bank_bay/widgets/Calculator/sip_calculator.dart';
import 'package:bank_bay/widgets/LeadManager/Add%20Lead/lead_documet.dart';
import 'package:bank_bay/widgets/LeadManager/Add%20Lead/lead_loan_form.dart';
import 'package:bank_bay/widgets/LeadManager/Add%20Lead/lead_loan_form_view.dart';
import 'package:bank_bay/widgets/LeadManager/Add%20Lead/lead_loan_select_type.dart';
import 'package:bank_bay/widgets/LeadManager/Add%20Lead/lead_otp_verify.dart';
import 'package:bank_bay/widgets/LeadManager/Add%20Lead/lead_requirment_form.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

RxInt loanValue = 1.obs;
RxInt screenValue = 1.obs;
class AddLeadScreen extends StatefulWidget {
  const AddLeadScreen({super.key});

  @override
  State<AddLeadScreen> createState() => _AddLeadScreenState();
}

TextEditingController number = TextEditingController();
TextEditingController year = TextEditingController();
TextEditingController month = TextEditingController();

class _AddLeadScreenState extends State<AddLeadScreen> {
  var controller = Get.find<LoginController>();
  var createCustomerController = Get.find<CreateCustomerController>();
  var partnerController = Get.find<PartnerController>();
  var countLakh = 5.obs;
  var countLakh1 = 5.obs;
  RxString otpValue = "".obs;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    partnerController.getProfileCompleteApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenValue.value = 1;
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Scaffold(
          backgroundColor: Colors.lightBlue.withOpacity(0.1),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.r),
            child: SingleChildScrollView(
              child: GetBuilder<PartnerController>(
                builder: (controller) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 15.r),
                        Center(
                          child: Text("Let us get you money @ best Rate & Terms",
                              style: fontSmall.copyWith(
                                  color: Colors.black.withOpacity(0.7)),
                              textAlign: TextAlign.center),
                        ),
                        SizedBox(height: 15.r),
                        Obx(() => Column(
                            children: [
                              if(screenValue.value==1) const LeadLoanSelectType(),
                              if(screenValue.value==2) const LeadLoanForm(),
                              if(screenValue.value==3) const LeadLoanFormView(),
                              if(screenValue.value==4) const LeadOtpVerify(),
                              if(screenValue.value==5) const LeadRequirmentForm(),
                              if(screenValue.value==6) const LeadDocument(),
                              // if(screenValue.value==7) const LeadSelfie(),
                            ],
                          )),
                        SizedBox(height: 15.r),
                        Container(
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                            color: AllColors.white,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: (){
                                    Get.to(()=> const EMICalculator());
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        Images.emi,
                                        height: 70.r,
                                        width: 70.r,
                                      ),
                                      Text(
                                        "EMI",
                                        style: fontBold.copyWith(
                                            fontSize: 13.r,
                                            color: AllColors.black.withOpacity(0.8)),
                                      ),
                                      SizedBox(height: 2.r),
                                      Text(
                                        "Calculator",
                                        style: fontSmall.copyWith(
                                          fontSize: 13.r,
                                          color: AllColors.black.withOpacity(0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: (){
                                    Get.to(()=> const SIPCalculator());
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        Images.sip,
                                        height: 70.r,
                                        width: 70.r,
                                      ),
                                      Text(
                                        "SIP",
                                        style: fontBold.copyWith(
                                            fontSize: 13.r,
                                            color: AllColors.black.withOpacity(0.8)),
                                      ),
                                      SizedBox(height: 2.r),
                                      Text(
                                        "Calculator",
                                        style: fontSmall.copyWith(
                                          fontSize: 13.r,
                                          color: AllColors.black.withOpacity(0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: (){
                                    Get.to(()=> const FDCalculator());
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        Images.fd,
                                        height: 70.r,
                                        width: 70.r,
                                      ),
                                      Text(
                                        "FD",
                                        style: fontBold.copyWith(
                                            fontSize: 13.r,
                                            color: AllColors.black.withOpacity(0.8)),
                                      ),
                                      SizedBox(height: 2.r),
                                      Text(
                                        "Calculator",
                                        style: fontSmall.copyWith(
                                          fontSize: 13.r,
                                          color: AllColors.black.withOpacity(0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 65.r),
                      ],
                    );
                }
              ),
              ),
            ),
          ),
    );
  }
}
