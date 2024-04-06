// ignore_for_file: deprecated_member_use

import 'package:bank_bay/controllers/create_customer_controller.dart';
import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/widgets/LeadManager/Add%20Lead/loan_details.dart';
import 'package:bank_bay/widgets/LeadManager/add_lead.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Bussiness Loan/bussiness_loan_form.dart';
import 'Personal Loan/personal_loan_form.dart';
import 'Self Employee Loan/self_employee_loan_form.dart';

class CustSelectType extends StatefulWidget {
  final String loanType;
  const CustSelectType({super.key, required this.loanType});

  @override
  State<CustSelectType> createState() => _CustSelectTypeState();
}

class _CustSelectTypeState extends State<CustSelectType> {
  var partnerController = Get.find<PartnerController>();
  var createCustomerController = Get.find<CreateCustomerController>();
  var controller = Get.find<LoginController>();
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    loanValue.value=1;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select All Loan"),
        elevation: 0,
      ),
      body: Container(
        height: Get.height,
        color: Colors.lightBlue.withOpacity(0.1),
        padding: EdgeInsets.all(10.r),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.r),
                child: Text(
                  "Please select All Loan",
                  style: fontMedium.copyWith(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              SizedBox(height: 10.r),
              Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 15.r),
                color: AllColors.white.withOpacity(0.9),
                child: Obx(() => Column(
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
                    SizedBox(height: 20.r),
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
                    SizedBox(height: 20.r),
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
                    SizedBox(height: 40.r),
                    Center(
                      child: CustomButton(
                        title: "Next".tr,
                        background: true,
                        radius: 30.r,
                        height: 35.r,
                        width: Get.width - 150,
                        onTap: () async {
                          String loanType = loanValue.value==1?"PL":loanValue.value==2?"BL":loanValue.value==3?"SEL":"";
                          print("hjhbs ${GetStorage().read(AppConstant.create_cust_id)}");
                          print("hjhbs ${loanValue.value}  $loanType");
                          bool status = await createCustomerController.checkDuplicateLeadNetworkApi(GetStorage().read(AppConstant.create_cust_id)??"", loanType);
                          if(status==true){
                            if(createCustomerController.checkDuplicateLeadModel.value.popupStatus==true){
                              _confirmationDuplicateLead(context, loanType);
                            }else{
                              if(loanValue.value==1){
                                Get.to(()=> PersonalLoanForm(loanType: widget.loanType));
                              }else if(loanValue.value==2){
                                Get.to(()=> BusinessLoanForm(loanType: widget.loanType));
                              }else if(loanValue.value==3){
                                Get.to(()=> SelfEmployeeLoanForm(loanType: widget.loanType));
                              }
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(height: Get.height/5.r),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _confirmationDuplicateLead(BuildContext context, loanType) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: Future.value,
            child: AlertDialog(
              backgroundColor: AllColors.none,
              insetPadding: EdgeInsets.symmetric(horizontal:15.r),
              actionsPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.symmetric(horizontal: 0.r),
              titlePadding: EdgeInsets.zero,
              actions: [
                Container(
                  width: Get.width,
                  color: AllColors.white,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      if(loanValue.value==1){
                        Get.to(()=> PersonalLoanForm(loanType: widget.loanType));
                      }else if(loanValue.value==2){
                        Get.to(()=> BusinessLoanForm(loanType: widget.loanType));
                      }else if(loanValue.value==3){
                        Get.to(()=> SelfEmployeeLoanForm(loanType: widget.loanType));
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.r),
                      margin: EdgeInsets.only(left: 25.r, right: 25, top: 8.r, bottom: 8),
                      decoration: BoxDecoration(
                        color: AllColors.green,
                        borderRadius: BorderRadius.circular(5.r)
                      ),
                      alignment: Alignment.center,
                      child: Text("I want to create new lead",style: fontMedium.copyWith(fontSize: 13.r,color: AllColors.white.withOpacity(0.9)),),
                    ),
                  ),
                )
              ],
              content: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 58.0),
                    child: Container(
                      height: 420.r,
                      color: AllColors.white,
                      child: Column(
                        children: [
                          Container(
                            color: AllColors.themeColor,
                            padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 8.r),
                            child: Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(createCustomerController.checkDuplicateLeadModel.value.data.custData.custName??"", style: fontMedium.copyWith(color: AllColors.lightGrey.withOpacity(0.5), fontSize: 13.r),),
                                    Text(createCustomerController.checkDuplicateLeadModel.value.data.custData.custAddress??"", style: fontMedium.copyWith(color: AllColors.white.withOpacity(0.8), fontSize: 13.r)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Active Loan',  style: fontMedium.copyWith(color: AllColors.lightGrey.withOpacity(0.5), fontSize: 13.r)),
                                    Text('${createCustomerController.checkDuplicateLeadModel.value.data.active}', style: fontMedium.copyWith(color: AllColors.white.withOpacity(0.8))),
                                  ],
                                ),

                              ],
                            ),
                            ),
                          ),
                          SizedBox(
                            height: 400.0,
                            width: Get.width-30,
                            child: Obx(() => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      _pageController.previousPage(
                                        duration: const Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                    },
                                    child: Icon(Icons.chevron_left_outlined,size: 25.r, color: AllColors.grey,),
                                  ),
                                  Expanded(
                                    child: PageView(
                                      controller: _pageController,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical :8.0.r),
                                              child: Text("Personal Loan", style: fontBold.copyWith(fontSize: 13.r, color: AllColors.black),),
                                            ),
                                            Expanded(
                                              child: createCustomerController.checkDuplicateLeadModel.value.data.plData.isNotEmpty?
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: createCustomerController.checkDuplicateLeadModel.value.data.plData.length,
                                                    itemBuilder: (BuildContext context, int index) {
                                                    var plData = createCustomerController.checkDuplicateLeadModel.value.data.plData[index];
                                                    return Container(
                                                      padding: EdgeInsets.all(8.r),
                                                      margin: EdgeInsets.only(bottom: 8.r),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(width: 1.r, color: AllColors.grey),
                                                          borderRadius: BorderRadius.circular(5.r)
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                        RichText(
                                                          text: TextSpan(
                                                            text: 'Amount  ',
                                                            style: fontMedium.copyWith(color: AllColors.grey.withOpacity(0.8)),
                                                            children: [
                                                              TextSpan(text: '${plData.loanAmount??0}', style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.6))),
                                                            ],
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                            text: 'Created By  ',
                                                            style: fontMedium.copyWith(color: AllColors.grey.withOpacity(0.8)),
                                                            children: [
                                                              TextSpan(text: plData.createdByName??"", style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.6))),
                                                            ],
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                            text: 'Stage  ',
                                                            style: fontMedium.copyWith(color: AllColors.grey.withOpacity(0.8)),
                                                            children: [
                                                              TextSpan(text: plData.leadStatus??"", style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.6))),
                                                            ],
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),

                                                      ],
                                                    ),
                                                  );
                                                },
                                                  )
                                                  : Center(child: Text("Data not found!!!", style: fontRegular.copyWith(),)),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical :8.0.r),
                                              child: Text("Business Loan", style: fontBold.copyWith(fontSize: 13.r, color: AllColors.black),),
                                            ),
                                            Expanded(
                                              child: createCustomerController.checkDuplicateLeadModel.value.data.blData.isNotEmpty?
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: createCustomerController.checkDuplicateLeadModel.value.data.blData.length,
                                                    itemBuilder: (BuildContext context, int index) {
                                                    var blData = createCustomerController.checkDuplicateLeadModel.value.data.blData[index];
                                                    return Container(
                                                      padding: EdgeInsets.all(8.r),
                                                      margin: EdgeInsets.only(bottom: 8.r),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(width: 1.r, color: AllColors.grey),
                                                          borderRadius: BorderRadius.circular(5.r)
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          RichText(
                                                            text: TextSpan(
                                                              text: 'Amount  ',
                                                              style: fontMedium.copyWith(color: AllColors.grey.withOpacity(0.8)),
                                                              children: [
                                                                TextSpan(text: '${blData.loanAmount??0}', style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.6))),
                                                              ],
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          RichText(
                                                            text: TextSpan(
                                                              text: 'Created By  ',
                                                              style: fontMedium.copyWith(color: AllColors.grey.withOpacity(0.8)),
                                                              children: [
                                                                TextSpan(text: blData.createdByName??"", style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.6))),
                                                              ],
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          RichText(
                                                            text: TextSpan(
                                                              text: 'Stage  ',
                                                              style: fontMedium.copyWith(color: AllColors.grey.withOpacity(0.8)),
                                                              children: [
                                                                TextSpan(text: blData.leadStatus??"", style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.6))),
                                                              ],
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),

                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  ) : Center(child: Text("Data not found!!!", style: fontRegular.copyWith(),)),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical :8.0.r),
                                              child: Text("Self Employee Loan", style: fontBold.copyWith(fontSize: 13.r, color: AllColors.black),),
                                            ),
                                            Expanded(
                                              child: createCustomerController.checkDuplicateLeadModel.value.data.selData.isNotEmpty?
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: createCustomerController.checkDuplicateLeadModel.value.data.selData.length,
                                                  itemBuilder: (BuildContext context, int index) {
                                                    var selData = createCustomerController.checkDuplicateLeadModel.value.data.selData[index];
                                                    return Container(
                                                      padding: EdgeInsets.all(8.r),
                                                      margin: EdgeInsets.only(bottom: 8.r),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(width: 1.r, color: AllColors.grey),
                                                          borderRadius: BorderRadius.circular(5.r)
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          RichText(
                                                            text: TextSpan(
                                                              text: 'Amount  ',
                                                              style: fontMedium.copyWith(color: AllColors.grey.withOpacity(0.8)),
                                                              children: [
                                                                TextSpan(text: '${selData.loanAmount??0}', style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.6))),
                                                              ],
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          RichText(
                                                            text: TextSpan(
                                                              text: 'Created By  ',
                                                              style: fontMedium.copyWith(color: AllColors.grey.withOpacity(0.8)),
                                                              children: [
                                                                TextSpan(text: selData.createdByName??"", style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.6))),
                                                              ],
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          RichText(
                                                            text: TextSpan(
                                                              text: 'Stage  ',
                                                              style: fontMedium.copyWith(color: AllColors.grey.withOpacity(0.8)),
                                                              children: [
                                                                TextSpan(text: selData.leadStatus??"", style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.6))),
                                                              ],
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),

                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ) : Center(child: Text("Data not found!!!", style: fontRegular.copyWith(),)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      _pageController.nextPage(
                                        duration: const Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                    },
                                    child: Icon(Icons.chevron_right_outlined,size: 25.r, color: AllColors.grey,),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: MediaQuery.of(context).size.width/2.5,
                    child:  InkWell(
                      onTap: ()=> Navigator.pop(context),
                      child: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: AllColors.red,
                        child: Icon(Icons.close_outlined, size: 25.r, color: AllColors.white,),
                  ),
                    ),)
                ],
              ),
            ),
          );
        }
    );
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
