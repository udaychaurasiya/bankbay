import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/utils_method/uppercase_formate.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/dashboard.dart';
import 'package:bank_bay/widgets/home_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'Bussiness Loan/bussiness_loan_form.dart';
import 'Personal Loan/personal_loan_form.dart';
import 'Self Employee Loan/self_employee_loan_form.dart';
import 'cust_select_type.dart';

class CustKycScreen extends StatefulWidget {
  final bool addLoan;
  final String? pageName;
  const CustKycScreen({super.key, required this.addLoan, this.pageName});

  @override
  State<CustKycScreen> createState() => _CustKycScreenState();
}
var controller = Get.find<LoginController>();
var partnerController = Get.find<PartnerController>();

class _CustKycScreenState extends State<CustKycScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade50),
          ),
          height: Get.height-150, // Set the desired height
          child: GetBuilder<PartnerController>(
              builder: (controller) {
                return Column(
                  children: [
                    SizedBox(height: 20.r),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150.r,
                          margin: EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 10.r),
                          padding: EdgeInsets.only(bottom: 10.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            shape: BoxShape.rectangle,
                          ),
                          child: DottedBorder(
                            borderType: BorderType.Rect,
                            radius: Radius.circular(5.r),
                            strokeWidth: 1.5.r,
                            dashPattern: const [4,3],
                            color: AllColors.blue.withOpacity(0.5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0.r),
                                  child: UnderLineTextField(
                                    labelText: "Enter PAN Number".tr,
                                    hint: "Enter PAN Number".tr,
                                    label: true,
                                    controller: createCustController.custPan,
                                    type: TextInputType.text,
                                    inputFormatters: [
                                      UpperCaseTextFormatter(),
                                    ],
                                    length: 10,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter permanent account number (PAN)';
                                      }else if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value)) {
                                        return 'Please enter valid PAN card';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(height: 20.r),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "Request Customer OTP",
                                    style: fontMedium.copyWith(
                                      color: AllColors.themeColor,
                                      fontSize: 12.r,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: Get.width/4-5.r,
                          top: 12.r,
                          child: Container(
                            padding: EdgeInsets.only(bottom: 10.r, left: 10.r, right: 10.r),
                            color: Colors.white,
                            child: Text(
                              "PAN Authentication",
                              style: fontMedium.copyWith(fontSize: 12.r),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150.r,
                          margin: EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 10.r),
                          padding: EdgeInsets.only(bottom: 10.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            shape: BoxShape.rectangle,
                          ),
                          child: DottedBorder(
                            borderType: BorderType.Rect,
                            radius: Radius.circular(5.r),
                            strokeWidth: 1.5.r,
                            dashPattern: const [4,3],
                            color: AllColors.blue.withOpacity(0.5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0.r),
                                  child: UnderLineTextField(
                                    controller: createCustController.custAadhaar,
                                    hint: "Enter Aadhaar Number".tr,
                                    label: true,
                                    icon: true,
                                    type: TextInputType.number,
                                    length: 12,
                                    onChange: (value){
                                      if(value.length==12){
                                        print("object 10 digit");
                                      }
                                    },
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    suffixIcon: Lottie.asset(Images.success, height: 25.r, width: 25.r,),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter aadhaar number';
                                      }else if (!RegExp( r'^[2-9]{1}[0-9]{3}\\s[0-9]{4}\\s[0-9]{4}$').hasMatch(value)) {
                                        return 'Please enter valid aadhaar card';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(height: 5.r),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0.r),
                                  child: UnderLineTextField(
                                    // controller: controller.etPanCard,
                                    hint: "Enter OTP".tr,
                                    label: false,
                                    icon: true,
                                    type: TextInputType.text,
                                    length: 10,
                                    suffixIcon: Text("Verify OTP",style: fontMedium.copyWith(fontSize: 12.r,wordSpacing: 0,letterSpacing: 0),),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter OTP';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: Get.width/4-5.r,
                          top: 12.r,
                          child: Container(
                            padding: EdgeInsets.only(bottom: 10.r, left: 10.r, right: 10.r),
                            color: Colors.white,
                            child: Text(
                              "AADHAAR Authentication",
                              style: fontMedium.copyWith(fontSize: 12.r),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.r),
                    CustomButton(
                      title: "Submit".tr,
                      background: true,
                      radius: 10.r,
                      height: 35.r,
                      width: Get.width - 200,
                      onTap: () async {
                        bool status = await createCustController.createCustKycNetworkApi();
                        if(status==true){
                          partnerController.resetTimer();
                          _otpVerifyBox(context);
                        }
                      },
                    ),
                  ],
                );
              }
          ),
        ),
      ),
    );
  }

  _otpVerifyBox(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        child: Container(
          height: 300.r,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 15.r),
          child: Obx(() => Column(
              children: [
                SizedBox(height: 10.r),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(),
                    Center(
                      child: Text(
                        "OTP Verify",
                        style: fontBold.copyWith(fontSize: 16.sp),
                      ),
                    ),
                    InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(
                          Icons.close,
                          size: 22.r,
                          color: AllColors.red.withOpacity(0.9),
                        ))
                  ],
                ),
                SizedBox(height: 20.r),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("OTP send to +91 ${createCustController.custPhone.text}",style: fontExtraSmall.copyWith()),
                    SizedBox(width: 10.r),
                    Text(DateFormat('ss:mm').format(
                            DateTime(0, 0, 0, 0, partnerController.seconds.value)),
                        style: fontBold.copyWith(
                          fontSize: 16.r,
                          decoration: TextDecoration.underline,
                          color: partnerController.seconds.value==0?AllColors.red:AllColors.green,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 15.r),
                SizedBox(
                  width: 220.w,
                  height: 40.h,
                  child: OTPTextField(
                    length: 4,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 40.w,
                    style: fontBold.copyWith(fontSize: 18.sp,color: Colors.black),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.underline,
                    onCompleted: (pin) {
                      createCustController.verifyOtp.value = pin;
                    },
                    onChanged: (value){
                      createCustController.verifyOtp.value = value;
                    },
                  ),
                ),
                SizedBox(height: 30.r,),
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(partnerController.seconds.value != 00)
                      Text("Please enter 4 digit code that send \nto your mobile number.", style: fontSmall.copyWith(
                          color: AllColors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    if(partnerController.seconds.value == 00)
                      Text("Didn't get the code ? ", style: fontMedium.copyWith(
                          color: AllColors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w400),),
                    if(partnerController.seconds.value == 00)
                      InkWell(
                        onTap: ()async{
                          if (partnerController.seconds.value == 00) {
                            bool status = await partnerController.profileResendOTPNetworkApi(context);
                            if(status==true){
                              partnerController.resetTimer();
                            }
                          }
                        },
                        child: Text(" Resend Otp ", style: fontMedium.copyWith(
                            color: AllColors.darkBlue.withOpacity(0.8),
                            fontWeight: FontWeight.w400),),
                      ),
                  ],
                ),
                ),
                SizedBox(height: 30.r),
                InkWell(
                  onTap: ()async{
                    bool status = await createCustController.createCustOtpVerificationApi(createCustController.verifyOtp.value);
                    if(status==true){
                      if(widget.addLoan==true) {
                        Get.to(()=> const CustSelectType(loanType: "userLoan"));
                      }else if(widget.pageName=="personal Loan") {
                        Get.to(()=> const PersonalLoanForm(loanType: "userLoan"));
                      }else if(widget.pageName=="Business Loan") {
                        Get.to(()=> const BusinessLoanForm(loanType: "userLoan"));
                      }else if(widget.pageName=="Self Employee Loan") {
                        Get.to(()=> const SelfEmployeeLoanForm(loanType: "userLoan"));
                      }else {
                        Get.offAll(()=> const DashboardScreen());
                        controller.index.value=0;
                        indexValue.value=1;
                      }
                    }
                  },
                  child: CustomButton(
                    background: true,
                    width: 150.r,
                    height: 35.r,
                    radius: 5.r,
                    title: "Verify".tr,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
