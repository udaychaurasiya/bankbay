// ignore_for_file: invalid_use_of_protected_member, avoid_print, use_build_context_synchronously, deprecated_member_use

import 'package:bank_bay/controllers/auth_conroller.dart';
import 'package:bank_bay/controllers/create_customer_controller.dart';
import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/controllers/permission_controller.dart';
import 'package:bank_bay/demo.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/widgets/Apply%20Loan/Bussiness%20Loan/bussiness_loan_form.dart';
import 'package:bank_bay/widgets/Apply%20Loan/Personal%20Loan/personal_loan_form.dart';
import 'package:bank_bay/widgets/Apply%20Loan/Self%20Employee%20Loan/self_employee_loan_form.dart';
import 'package:bank_bay/widgets/Apply%20Loan/search_customer.dart';
import 'package:bank_bay/widgets/Calculator/credit_score.dart';
import 'package:bank_bay/widgets/Calculator/fd_calculator.dart';
import 'package:bank_bay/widgets/Calculator/sip_calculator.dart';
import 'package:bank_bay/widgets/Profile/Model/profile_complete_model.dart';
import 'package:bank_bay/widgets/Profile/Profile.dart';
import 'package:bank_bay/widgets/User/user_choose_selfie.dart';
import 'package:bank_bay/widgets/User/user_document.dart';
import 'package:bank_bay/widgets/User/user_form_loan.dart';
import 'package:bank_bay/widgets/User/user_loan_form_view.dart';
import 'package:bank_bay/widgets/User/user_otp_verify.dart';
import 'package:bank_bay/widgets/User/user_requirment_loan_form.dart';
import 'package:bank_bay/widgets/User/user_select_loan_type.dart';
import 'package:bank_bay/widgets/dashboard.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'Calculator/emi_calculator.dart';

RxInt indexValue = 1.obs;
RxString genderValue = "My Proof".obs;
class HomeWidget extends StatefulWidget {
  final int? value;
  const HomeWidget({super.key, this.value});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

RxInt sliderValue = 0.obs;
var createCustController = Get.find<CreateCustomerController>();
class _HomeWidgetState extends State<HomeWidget> {
  GetStorage storage = GetStorage();
  var controller = Get.put(LoginController());
  var partnerController = Get.find<PartnerController>();
  var permissionController = Get.find<PermissionController>();
  var authController = Get.put(AuthController());

  @override
  void initState() {
    checkDataApi();
    super.initState();
  }

  checkDataApi()async{
    if (storage.read(AppConstant.cust_id).toString().startsWith("E10") == true) {
      partnerController.getEmployeeDetailsGetAmountNetworkApi(storage.read(AppConstant.cust_id).toString());
    }else if(storage.read(AppConstant.cust_id).toString().startsWith("C10")==true||storage.read(AppConstant.cust_id).toString().startsWith("P10")==true){
      partnerController.getProfileCompleteApi();
      partnerController.getCustomerDetailsNetworkApi(storage.read(AppConstant.cust_id).toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10")){
      selectLoanType.value = "Loan for Someone else";
    }
    print("Id ${storage.read(AppConstant.lead_id).toString().trim()}");
    return Scaffold(
      backgroundColor: Colors.lightBlue.withOpacity(0.1),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.r),
        child: Obx(() {
          return RefreshIndicator(
            color: AllColors.themeColor,
            onRefresh: () {
              return Future.delayed(Duration.zero, () {
                permissionController.userPermissionNetworkApi(storage.read(AppConstant.cust_id).toString());
                if (storage.read(AppConstant.cust_id).toString().startsWith("E10") == true) {
                  partnerController.getEmployeeDetailsGetAmountNetworkApi(storage.read(AppConstant.cust_id).toString());
                }
                if (storage.read(AppConstant.cust_id).toString().startsWith("C10") == true) {
                  partnerController.getUserDetailsApi(storage.read(AppConstant.cust_id).toString());
                }
                Get.off(() => const DashboardScreen());
                controller.index.value = 0;
                indexValue.value = 1;
              });
            },
            child: ListView(
              children: [
                SizedBox(height: 10.r),
                Column(
                  children: [
                    if (indexValue.value == 1) const UserSelectLoanType(),
                    if (indexValue.value == 2) const UserFormLoan(),
                    if (indexValue.value == 3) const UserLoanFormView(),
                    if (indexValue.value == 4) const UserOtpVerify(),
                    if (indexValue.value == 5) const UserRequirementLoanForm(),
                    if (indexValue.value == 6) const UserDocument(),
                    if (indexValue.value == 7) const UserChooseSelfie(),
                  ],
                ),
                if (indexValue.value == 1) SizedBox(height: 20.r),
                if (indexValue.value == 1)
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1.r,
                          color: AllColors.white.withOpacity(0.7),
                        ),
                      ),
                      InkWell(
                        onTap: () => Get.to(() => const DemoPage()),
                        // onTap: () => Get.to(() => const UserStatusTimeLine()),
                        // onTap: ()=> pickPDF(),
                        child: Text(
                          "  Quick tools  ",
                          style: fontMedium.copyWith(fontSize: 16.r),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1.r,
                          color: AllColors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                if (indexValue.value == 1) SizedBox(height: 20.r),
                if (indexValue.value == 1)
                  Container(
                    height: 130.r,
                    color: AllColors.white,
                    child: ListView(
                      padding: EdgeInsets.all(10.r),
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(width: 20.r),
                        InkWell(
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
                        SizedBox(width: 33.r),
                        InkWell(
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
                        SizedBox(width: 33.r),
                        InkWell(
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
                        SizedBox(width: 33.r),
                        InkWell(
                          onTap: (){
                            Get.to(()=> const CreditScore());
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                Images.cibil,
                                height: 70.r,
                                width: 70.r,
                              ),
                              Text(
                                "Credit",
                                style: fontBold.copyWith(
                                    fontSize: 13.r,
                                    color: AllColors.black.withOpacity(0.8)),
                              ),
                              SizedBox(height: 2.r),
                              Text(
                                "Score",
                                style: fontSmall.copyWith(
                                  fontSize: 13.r,
                                  color: AllColors.black.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 20.r),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1.r,
                        color: AllColors.white.withOpacity(0.7),
                      ),
                    ),
                    Text("  Apply Loan  ",
                        style: fontMedium.copyWith(fontSize: 16.r)),
                    Expanded(
                      child: Container(
                        height: 1.r,
                        color: AllColors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.r),
                Container(
                  height: 130.r,
                  color: AllColors.white,
                  child: ListView(
                    padding: EdgeInsets.all(10.r),
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(width: 20.r),
                      InkWell(
                        onTap: (){
                          _checkPanAlertBox(context, "personal Loan");
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              Images.personal_loan,
                              height: 70.r,
                              width: 70.r,
                            ),
                            Text(
                              "Personal",
                              style: fontBold.copyWith(
                                  fontSize: 13.r,
                                  color: AllColors.black.withOpacity(0.8)),
                            ),
                            SizedBox(height: 2.r),
                            Text(
                              "Loan",
                              style: fontSmall.copyWith(
                                fontSize: 13.r,
                                color: AllColors.black.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 33.r),
                      InkWell(
                        onTap: (){
                          _checkPanAlertBox(context, "Business Loan");
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              Images.business_loan,
                              height: 70.r,
                              width: 70.r,
                            ),
                            Text(
                              "Business",
                              style: fontBold.copyWith(
                                  fontSize: 13.r,
                                  color: AllColors.black.withOpacity(0.8)),
                            ),
                            SizedBox(height: 2.r),
                            Text(
                              "Loan",
                              style: fontSmall.copyWith(
                                fontSize: 13.r,
                                color: AllColors.black.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 33.r),
                      InkWell(
                        onTap: (){
                          _checkPanAlertBox(context, "Self Employee Loan");
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              Images.car_loan,
                              height: 70.r,
                              width: 70.r,
                            ),
                            Text(
                              "Self Employee",
                              style: fontBold.copyWith(
                                  fontSize: 13.r,
                                  color: AllColors.black.withOpacity(0.8)),
                            ),
                            SizedBox(height: 2.r),
                            Text(
                              "Loan",
                              style: fontSmall.copyWith(
                                fontSize: 13.r,
                                color: AllColors.black.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Future<void> pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      String path = result.files.single.path.toString();
      print('Selected PDF path: $path');
    } else {
      // User canceled the picker
    }
  }

  // _exitAppAlertDialog(BuildContext context) {
  //   AlertDialog alert = AlertDialog(
  //     backgroundColor: AllColors.lightGrey,
  //     title: const Text("Bankbay is locked"),
  //     actionsPadding: EdgeInsets.zero,
  //     contentPadding: EdgeInsets.zero,
  //     actionsOverflowButtonSpacing: 0,
  //     content: SizedBox(
  //       height: 65.r,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Padding(
  //             padding: EdgeInsets.only(left: 20.0.r, right: 20.r, top: 15.r),
  //             child: Text(
  //               "Authentication is required to access the Bankbay app",
  //               style: fontRegular.copyWith(
  //                   fontSize: 13.r, wordSpacing: 0,
  //                   color: AllColors.black.withOpacity(0.6),
  //                   letterSpacing: 0.2),
  //             ),
  //           ),
  //           Container(
  //             height: 1.r,
  //             width: Get.width,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(5.r),
  //               color: AllColors.black.withOpacity(0.12),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //     actionsAlignment: MainAxisAlignment.center,
  //     actions: [
  //       InkWell(
  //         onTap: (){
  //           Navigator.pop(context);
  //           checkFingerPrint();
  //         },
  //         child: Container(
  //           height: 42.r,
  //           alignment: Alignment.center,
  //           child: Text("Unlock now", style: fontMedium.copyWith(color: AllColors.themeColor,)),
  //         ),
  //       ),
  //     ],
  //   );
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return WillPopScope(
  //         onWillPop: Future.value,
  //         child: alert,
  //       );
  //     },
  //   );
  // }

  var selectLoanType = "Loan for Someone else".obs;
  _checkPanAlertBox(BuildContext context, pageName) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0), // Adjust the left radius
          topRight: Radius.circular(16.0), // Adjust the right radius
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0.r, vertical: 20.r),
          child: SingleChildScrollView(
            child: Obx(() => Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: ()=> Navigator.pop(context),
                    child: Icon(Icons.close_outlined, size: 25.r, color: AllColors.red.withOpacity(0.9),),
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(right: 10.r),
                  child: Text(
                    "Who needs this loan ?",
                    style: fontExtraBold.copyWith(fontSize: 16.sp),
                  ),
                ),
                SizedBox(height: 25.r),
                InkWell(
                  onTap: (){
                    if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10")){
                      BaseController().errorSnack("Employees cannot apply for loan !!");
                    }
                    else {
                      selectLoanType.value = "Loan for me";
                      print("sjbs ${selectLoanType.value}");
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5.r, color: AllColors.grey),
                      borderRadius: BorderRadius.circular(10.r),
                      color: selectLoanType.value == "Loan for me"?AllColors.blue:AllColors.lightGrey.withOpacity(0.5),
                    ),
                    child: Container(
                      height: 90.r,
                      padding: EdgeInsets.symmetric(horizontal: 20.r),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 35.r,
                            backgroundColor: AllColors.blue.withOpacity(0.5),
                            child: CircleAvatar(
                              radius: 34.r,
                              backgroundColor: AllColors.white,
                              // child: Icon(Icons.person, size: 25.r, color: AllColors.black.withOpacity(0.6),),
                              child: Image.asset(Images.user, height: 20.r, width: 20.r,color: AllColors.black.withOpacity(0.6),),
                            ),
                          ),
                          SizedBox(width: 15.r),
                          Text(
                            "Loan for me",
                            style: fontExtraBold.copyWith(
                              fontWeight: FontWeight.w600,
                              color: selectLoanType.value == "Loan for me"?AllColors.white:AllColors.black.withOpacity(0.8),
                              fontSize: 16.r,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 15.r),
                  child: Text(
                    "--OR--",
                    style: fontRegular.copyWith(fontSize: 16.sp),
                  ),
                ),
                InkWell(
                  onTap: (){
                    selectLoanType.value = "Loan for Someone else";
                    print("sjbs ${selectLoanType.value}");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5.r, color: AllColors.grey),
                      borderRadius: BorderRadius.circular(10.r),
                      color: selectLoanType.value == "Loan for Someone else"?AllColors.blue:AllColors.lightGrey.withOpacity(0.5),
                    ),
                    child: Container(
                      height: 90.r,
                      padding: EdgeInsets.symmetric(horizontal: 20.r),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 35.r,
                            backgroundColor: AllColors.blue.withOpacity(0.5),
                            child: CircleAvatar(
                              radius: 34.r,
                              backgroundColor: AllColors.white,
                              child: Image.asset(Images.share, height: 25.r, width: 25.r,color: AllColors.black.withOpacity(0.6),),
                            ),
                          ),
                          SizedBox(width: 15.r),
                          Text(
                            "Loan for Someone else",
                            style: fontExtraBold.copyWith(
                              fontWeight: FontWeight.w600,
                              color: selectLoanType.value == "Loan for Someone else"?AllColors.white:AllColors.black.withOpacity(0.8),
                              fontSize: 16.r,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.r),
                InkWell(
                  onTap: (){
                    createCustController.clearTextField();
                    if(GetStorage().read(AppConstant.name)!=null){
                      if(selectLoanType.value == "Loan for me"){
                        if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10")){
                          BaseController().errorSnack("Please partner login !!");
                        }else{
                          if(pageName == "personal Loan"){
                            Navigator.pop(context);
                            Get.to(()=> const PersonalLoanForm(loanType: "myLoan"));
                          }else if(pageName == "Business Loan"){
                            Navigator.pop(context);
                            Get.to(()=> const BusinessLoanForm(loanType: "myLoan"));
                          }else if(pageName == "Self Employee Loan"){
                            Navigator.pop(context);
                            Get.to(()=> const SelfEmployeeLoanForm(loanType: "myLoan"));
                          }
                        }
                      }else if(selectLoanType.value == "Loan for Someone else"){
                        print("object ${partnerController.profileComplete.value.data.popupStatus}");
                        if(partnerController.profileComplete.value.data.popupStatus.toString()=="true"){
                          if(partnerController.customerDetails.value.data.partnerdetails.partnerStatus.toString().toLowerCase()=="active") {
                            Navigator.pop(context);
                            Get.to(()=> const SearchCustomerWidget());
                          }else{
                            Navigator.pop(context);
                            _underProcessAccess(context);
                          }
                        } else if(storage.read(AppConstant.cust_id).toString().startsWith("E10")){
                          Navigator.pop(context);
                          Get.to(()=> const SearchCustomerWidget());
                        }
                        else{
                          Navigator.pop(context);
                          _profileComplete(context, partnerController.profileComplete.value.data);
                        }
                      }
                    }else{
                      BaseController().errorSnack("You are not Sign In please sign in");
                    }
                  },
                  child: Container(
                    height: 45.r,
                    width: 200.r,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AllColors.darkBlue,
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Text(
                      "Confirm",
                      style: fontBold.copyWith(color: AllColors.white),
                    ),
                  ),
                ),
              ],
            ),
            ),
          ),
        );
      },
    );
  }


  _underProcessAccess(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () => Get.back(),
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


// _permissionFingerprintLock(BuildContext context) {
  //   AlertDialog alert = AlertDialog(
  //     backgroundColor: AllColors.lightGrey,
  //     title: const Text("Fingerprint Enable"),
  //     actionsPadding: EdgeInsets.zero,
  //     contentPadding: EdgeInsets.zero,
  //     actionsOverflowButtonSpacing: 0,
  //     content: SizedBox(
  //       height: 65.r,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Padding(
  //             padding: EdgeInsets.only(left: 20.0.r, right: 20.r, top: 15.r),
  //             child: Text(
  //               "Do you want to turn on fingerprint option, if yes then press yes otherwise no.",
  //               style: fontRegular.copyWith(
  //                   fontSize: 13.r, wordSpacing: 0,
  //                   color: AllColors.black.withOpacity(0.6),
  //                   letterSpacing: 0.2),
  //             ),
  //           ),
  //           Container(
  //             height: 1.r,
  //             width: Get.width,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(5.r),
  //               color: AllColors.black.withOpacity(0.12),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //     // actionsAlignment: MainAxisAlignment.center,
  //     actions: [
  //       TextButton(
  //         onPressed: () async {
  //           bool status = await partnerController.updateFingerprintLockNetworkApi("yes");
  //           if(status==true){
  //             Navigator.pop(context);
  //           }
  //         },
  //         child: Text("YES", style: fontMedium.copyWith(color: AllColors.themeColor,)),
  //       ),
  //       TextButton(
  //         onPressed: () async {
  //           bool status = await partnerController.updateFingerprintLockNetworkApi("no");
  //           if(status==true){
  //             Navigator.pop(context);
  //           }
  //         },
  //         child: Text("NO", style: fontMedium.copyWith(color: AllColors.themeColor,)),
  //       ),
  //     ],
  //   );
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return WillPopScope(
  //         onWillPop: Future.value,
  //         child: alert,
  //       );
  //     },
  //   );
  // }
}
