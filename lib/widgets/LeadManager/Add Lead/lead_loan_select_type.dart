// ignore_for_file: deprecated_member_use

import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/widgets/LeadManager/add_lead.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/Profile/Model/profile_complete_model.dart';
import 'package:bank_bay/widgets/Profile/Profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'loan_details.dart';

class LeadLoanSelectType extends StatefulWidget {
  const LeadLoanSelectType({super.key});

  @override
  State<LeadLoanSelectType> createState() => _LeadLoanSelectTypeState();
}

class _LeadLoanSelectTypeState extends State<LeadLoanSelectType> {
  var partnerController = Get.find<PartnerController>();
  var controller = Get.find<LoginController>();

  @override
  void initState() {
    loanValue.value = 1;
    partnerController.getProfileCompleteApi();
    if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10")) {
      partnerController.getEmployeeDetailsNetworkApi(GetStorage().read(AppConstant.cust_id).toString());
    }else if(GetStorage().read(AppConstant.cust_id).toString().startsWith("C10")||GetStorage().read(AppConstant.cust_id).toString().startsWith("P10")){
      partnerController.getCustomerDetailsNetworkApi(GetStorage().read(AppConstant.cust_id).toString());
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 15.r),
      color: AllColors.white.withOpacity(0.9),
      child: GetBuilder<PartnerController>(
        builder:(partnerController) {
        return Column(
          children: [
            Text(
              "Please select All Loan",
              style: fontSmall.copyWith(color: Colors.black.withOpacity(0.6)),
            ),
            SizedBox(height: 15.r),
            Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoanDetails(
                    image: Images.personal_loan,
                    title: "Personal loan".tr,
                    subTitle: "(For salaried employees)".tr,
                    onTap: () {
                      loanValue.value = 1;
                      print("loanValue $loanValue");
                    },
                    color: loanValue.value == 1
                        ? AllColors.darkBlue.withOpacity(0.8)
                        : AllColors.lightGrey.withOpacity(0.8),
                    textColor: loanValue.value == 1
                        ? AllColors.white.withOpacity(0.9)
                        : AllColors.black.withOpacity(0.8),
                    subColor: loanValue.value == 1
                        ? AllColors.white.withOpacity(0.9)
                        : AllColors.black.withOpacity(0.6),
                  ),
                  SizedBox(height: 10.r),
                  LoanDetails(
                    image: Images.business_loan,
                    title: "Business loan".tr,
                    subTitle: "(For Corporates and MSME)".tr,
                    onTap: () {
                      loanValue.value = 2;
                      print("loanValue $loanValue");
                    },
                    color: loanValue.value == 2
                        ? AllColors.darkBlue.withOpacity(0.8)
                        : AllColors.lightGrey.withOpacity(0.8),
                    textColor: loanValue.value == 2
                        ? AllColors.white.withOpacity(0.9)
                        : AllColors.black.withOpacity(0.8),
                    subColor: loanValue.value == 2
                        ? AllColors.white.withOpacity(0.9)
                        : AllColors.black.withOpacity(0.6),
                  ),
                  SizedBox(height: 10.r),
                  LoanDetails(
                    image: Images.car_loan,
                    title: "Self-Employed Loan".tr,
                    subTitle: "(Doctor, CA, Consultant etc)".tr,
                    onTap: () {
                      loanValue.value = 3;
                      print("loanValue $loanValue");
                    },
                    color: loanValue.value == 3
                        ? AllColors.darkBlue.withOpacity(0.8)
                        : AllColors.lightGrey.withOpacity(0.8),
                    textColor: loanValue.value == 3
                        ? AllColors.white.withOpacity(0.9)
                        : AllColors.black.withOpacity(0.8),
                    subColor: loanValue.value == 3
                        ? AllColors.white.withOpacity(0.9)
                        : AllColors.black.withOpacity(0.6),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.r),
            CustomButton(
              title: "Get Started".tr,
              background: true,
              radius: 30.r,
              height: 30.r,
              width: Get.width - 150,
              onTap: () {
                print("object ${partnerController.profileComplete.value.data.popupStatus}");
                if(partnerController.profileComplete.value.data.popupStatus.toString()=="true"){
                  print("jhss ${partnerController.profileComplete.value.data.popupStatus}");
                  _dataClear();
                  if(partnerController.customerDetails.value.data.partnerdetails.partnerStatus.toString().toLowerCase()=="active") {
                    screenValue.value=2;
                  }else{
                    _underProcessAccess(context);
                  }
                } else if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10")){
                  _dataClear();
                  screenValue.value=2;
                }
                else{
                  _profileComplete(context, partnerController.profileComplete.value.data);
                }
              },
            ),
          ],
        );
      },
      ),
    );
  }

  _dataClear(){
    controller.leadProfileSelfie.value="";
    controller.panCardImage.value="";
    controller.aadhaarCardImage.value="";
    controller.salarySlipsImage.value="";
    controller.bankStatementImage.value="";
    controller.ownerShipProof.value="";
    controller.relationshipProof.value="";
    controller.panCardImageName.value="";
    controller.leadProfileSelfieName.value="";
    controller.aadhaarCardImageName.value="";
    controller.salarySlipsImageName.value="";
    controller.bankStatementImageName.value="";
    controller.ownerShipProofName.value="";
    controller.relationshipProofName.value="";
    controller.loanTextFieldList.clear();
    controller.leadCompanyName.clear();
    controller.leadMonthlyAmount.clear();
    controller.gender.value ="Select Gender";
    controller.companyType.value = "IT Company";
    controller.maritalStatus.value = "Select Marital Status";
    controller.highestQualification.value = "Select Qualification";
    controller.leadName.clear();
    controller.leadEmail.clear();
    controller.leadPassword.clear();
    controller.leadPanCard.clear();
    controller.leadNumber.clear();
    controller.leadDob.clear();
    controller.leadCompanyName.clear();
    controller.leadMonthlyAmount.clear();
  }

  _profileComplete(BuildContext context, ProfileData profileData) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: Future.value,
        child: Dialog(
          child: Container(
            height: 350.r,
            width: double.infinity,
            padding: EdgeInsets.all(10.r),
            child: GetBuilder<PartnerController>(builder:(controller)=> Column(
                children: [
                  SizedBox(height: 10.r),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "Complete profile to add lead & earn incentive",
                          style: fontBold.copyWith(fontSize: 13.sp),
                        ),
                      ),
                      SizedBox(width: 5.r),
                      InkWell(
                        onTap: ()=> Navigator.pop(context),
                        child: Icon(Icons.close_outlined, size: 22.r, color: AllColors.red.withOpacity(0.8),),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.r),
                  ListView.builder(
                        itemCount: profileData.cmpStatus.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final data = profileData.cmpStatus[index];
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${data.title}",
                                  style: fontBold,
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                LinearPercentIndicator(
                                  width: MediaQuery.of(context).size.width - 145,
                                  animation: true,
                                  lineHeight: 6.r,
                                  percent: double.parse(data.count.toString()) / 100,
                                  animationDuration: 2000,
                                  trailing: Text(
                                    "${data.count!.toStringAsFixed(0)}%",
                                    style: fontBold.copyWith(color: AllColors.green),
                                  ),
                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                  progressColor: AllColors.green,
                                  backgroundColor: Colors.amberAccent,
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),
                              ],
                            );
                        },
                  ),
                  SizedBox(
                    height: 10.r,
                  ),
                  InkWell(
                    onTap: () {
                      profileIndex.value=1;
                      Get.to(() => const Profile());
                    },
                    child: CustomButton(
                      background: true,
                      width: 150.r,
                      height: 35.r,
                      radius: 5.r,
                      title: "Update Profile".tr,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _underProcessAccess(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () => Navigator.pop(context),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Waiting Approval"),
      content: Text("Your partner request was submitted successfully and is under review."
          "\n\nYou will be able to add lead sooner !!", style: fontRegular.copyWith(fontSize: 13.5.r),),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
