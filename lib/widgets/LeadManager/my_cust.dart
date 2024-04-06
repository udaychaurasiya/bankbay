// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use

import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/custom_image.dart';
import 'package:bank_bay/utils_method/custom_image_view.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/widgets/Customer%20details/customer_loan_list_details.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/Profile/Model/profile_complete_model.dart';
import 'package:bank_bay/widgets/Profile/Profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

class MyCustScreen extends StatefulWidget {
  const MyCustScreen({super.key});

  @override
  State<MyCustScreen> createState() => _MyCustScreenState();
}

class _MyCustScreenState extends State<MyCustScreen> {
  var controller = Get.find<LoginController>();
  var partnerController = Get.find<PartnerController>();
  var selectedValidation = "All Status".obs;

  @override
  void initState() {
    controller.getMyCustNetworkApi(_sourceFilterSendValue(controller.isMyCustEMPSelected.value), partnerController.sourceFilterSendValue(controller.filterTypeSelected.value),partnerController.loanTypeDecode(controller.selectLoanType.value),_statusFilterValue(selectedValidation.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    controller.selectEmployeePartnerValue.value ="All Reports";
    return Scaffold(
      backgroundColor: Colors.lightBlue.withOpacity(0.1),
      body: Obx(() => Column(
          children: [
           // SizedBox(height: 5.r),
            Container(
              height:45.h,
              padding: EdgeInsets.only(left: 12.0.r, right: 10, top: 0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  InkWell(
                    onTap: () {
                      showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(0, 130.r, 0, 10.r), // Adjust the position of the popup menu
                        items: <PopupMenuEntry<String>>[
                          PopupMenuItem(
                            value: 'All Loan'.tr,
                            child: Text('All Loan',style: fontMedium.copyWith()),
                          ),
                          PopupMenuItem(
                            value: 'Personal Loan'.tr,
                            child: Text('Personal Loan',style: fontMedium.copyWith()),
                          ),
                          PopupMenuItem(
                            value: 'Business Loan'.tr,
                            child: Text('Business Loan',style: fontMedium.copyWith()),
                          ),
                          PopupMenuItem(
                            value: 'Self-Employee Loan'.tr,
                            child: Text('Self-Employee Loan',style: fontMedium.copyWith()),
                          ),
                          PopupMenuItem(
                            value: 'No Loan Customer'.tr,
                            child: Text('No Loan Customer',style: fontMedium.copyWith()),
                          ),
                        ],
                      ).then((value) {
                        controller.selectLoanType.value = value??"All Loan";
                        controller.getMyCustNetworkApi(_sourceFilterSendValue(controller.isMyCustEMPSelected.value), partnerController.sourceFilterSendValue(controller.filterTypeSelected.value),partnerController.loanTypeDecode(controller.selectLoanType.value),_statusFilterValue(selectedValidation.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          color: AllColors.blue.withOpacity(0.4),
                          child: Icon(Icons.unfold_more,size: 15.r,color: AllColors.black,),
                        ),
                        SizedBox(width: 8.r),
                        Obx(() => Text(controller.selectLoanType.value,style: fontSmall.copyWith(letterSpacing: 0,wordSpacing: 0),)),
                      ],
                    ),
                  ),
                  SizedBox(width: 20,),
                  InkWell(
                    onTap: () {
                      showMenu(
                        context: context,
                        position: RelativeRect.fromSize(Rect.fromCircle(center: const Offset(70, 150), radius: 5), const Size(150, 300)),
                        items: <PopupMenuEntry<String>>[
                          PopupMenuItem(
                            value: 'All Status'.tr,
                            child: Text('All Status',style: fontMedium.copyWith()),
                          ),
                          PopupMenuItem(
                            value: 'Pending Validation'.tr,
                            child: Text('Pending Validation',style: fontMedium.copyWith()),
                          ),
                          PopupMenuItem(
                            value: 'Validated'.tr,
                            child: Text('Validated',style: fontMedium.copyWith()),
                          ),
                        ],
                      ).then((value) {
                        selectedValidation.value = value??"All Status";
                        controller.getMyCustNetworkApi(_sourceFilterSendValue(controller.isMyCustEMPSelected.value), partnerController.sourceFilterSendValue(controller.filterTypeSelected.value),partnerController.loanTypeDecode(controller.selectLoanType.value),_statusFilterValue(selectedValidation.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          color: AllColors.blue.withOpacity(0.4),
                          child: Icon(Icons.unfold_more,size: 15.r,color: AllColors.black,),
                        ),
                        SizedBox(width: 8.r),
                        Obx(() => Text(selectedValidation.value,style: fontSmall.copyWith(letterSpacing: 0,wordSpacing: 0),)),
                      ],
                    ),
                  ),
                  SizedBox(width: 20,),
                  if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10"))
                  InkWell(
                    onTap: () {
                      showMenu(
                        context: context,
                        position: RelativeRect.fromSize(Rect.fromCircle(center: const Offset(80, 150), radius: 5), const Size(150, 300)),
                        items: <PopupMenuEntry<String>>[
                          PopupMenuItem(
                            value: 'All Source'.tr,
                            child: SizedBox(
                              width: 100.r,
                              child: Text('All Source',style: fontMedium.copyWith()),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'Employee'.tr,
                            child: Text('Employee',style: fontMedium.copyWith()),
                          ),
                          PopupMenuItem(
                            value: 'Partner'.tr,
                            child: Text('Partner',style: fontMedium.copyWith()),
                          ),
                          PopupMenuItem(
                            value: 'Customer'.tr,
                            child: Text('Customer',style: fontMedium.copyWith()),
                          ),

                        ],
                      ).then((value) {
                        controller.filterTypeSelected.value = value??"All Source";
                        controller.getMyCustNetworkApi(_sourceFilterSendValue(controller.isMyCustEMPSelected.value), partnerController.sourceFilterSendValue(controller.filterTypeSelected.value),partnerController.loanTypeDecode(controller.selectLoanType.value),_statusFilterValue(selectedValidation.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          color: AllColors.blue.withOpacity(0.4),
                          child: Icon(Icons.unfold_more,size: 15.r,color: AllColors.black,),
                        ),
                        SizedBox(width: 8.r),
                        Obx(() => Text(controller.filterTypeSelected.value,style: fontSmall.copyWith(letterSpacing: 0,wordSpacing: 0),)),
                      ],
                    ),
                  ),
                  if(controller.filterTypeSelected.value=="Employee" || controller.filterTypeSelected.value=="Partner")
                    Padding(
                      padding: EdgeInsets.only(right:0.w,left: 15.w),
                      child: InkWell(
                        onTap: () {
                          showMenu(
                            context: context,
                            position: RelativeRect.fromSize(Rect.fromCircle(center:Offset(120.w, 140.h), radius: 5),  Size(150.w, 287.h)),
                            items: <PopupMenuEntry<String>>[
                              PopupMenuItem(
                                value: 'All Reports'.tr,
                                child: SizedBox(
                                  width: 100.r,
                                  child: Text('All Reports',style: fontMedium.copyWith()),
                                ),
                              ),
                              PopupMenuItem(
                                value: 'Direct'.tr,
                                child: Text('Direct',style: fontMedium.copyWith()),
                              ),
                              PopupMenuItem(
                                value: 'Indirect'.tr,
                                child: Text('Indirect',style: fontMedium.copyWith()),
                              ),
                            ],
                          ).then((value) {
                            controller.selectEmployeePartnerValue.value = value??"All Reports";
                            controller.getMyCustNetworkApi(_sourceFilterSendValue(controller.isMyCustEMPSelected.value), partnerController.sourceFilterSendValue(controller.filterTypeSelected.value),partnerController.loanTypeDecode(controller.selectLoanType.value),_statusFilterValue(selectedValidation.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              color: AllColors.blue.withOpacity(0.4),
                              child: Icon(Icons.unfold_more,size: 15.r,color: AllColors.black,),
                            ),
                            SizedBox(width: 8.r),
                            Obx(() => Text(controller.selectEmployeePartnerValue.value,style: fontSmall.copyWith(letterSpacing: 0,wordSpacing: 0),)),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(),
                ],
              ),
            ),
           /* if(controller.filterTypeSelected.value=="Employee"||controller.filterTypeSelected.value=="Partner")
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildRadioButtonEMP("All", "All"),
                  SizedBox(width: 15.r),
                  buildRadioButtonEMP('Direct', "Direct"),
                  SizedBox(width: 15.r),
                  buildRadioButtonEMP("Indirect", "Indirect"),
                ],
              ),*/
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: AllColors.white,
                  margin: EdgeInsets.only(left: 12.r,right:12.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height:controller.my_cust_model.value.message.toString()=="Data Not Found."?0:15.r),
                      GetBuilder<LoginController>(builder:(controller) {
                        return controller.my_cust_loader.value?
                        ListView.builder(
                            itemCount: controller.my_cust_model.value.data.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(bottom: 15.r),
                            itemBuilder: (context, index){
                              var data = controller.my_cust_model.value.data[index];
                              bool isLastItem = index == controller.my_cust_model.value.data.length - 1;
                              return Container(
                                padding: EdgeInsets.only(left: 10.0.r, right: 10.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: ()=> Get.to(()=> CustomImageView(imageUrls: AppConstants.BASE_URL+data.custProfilePic.toString())),
                                      child: CircleAvatar(
                                        radius: 20.r,
                                        backgroundColor: AllColors.lightTeal.withOpacity(0.6),
                                        child: CustomImage(
                                          image: data.custProfilePic.toString(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.r),
                                    Expanded(
                                      child: InkWell(
                                        onTap:  ()async{
                                          Get.to(()=> CustomerLoanListDetails(customerId: data.custId??"", pageName: "myTeamLeads", leadId: data.id.toString()));
                                        },
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: data.custName??"NA",
                                                style: fontSmall.copyWith(fontWeight: FontWeight.w500,fontSize: 13.5.r),
                                                children: [
                                                  TextSpan(text: " (${data.custId??"NA"})", style: fontSmall.copyWith(fontSize: 13.r)),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 2.r),
                                            Text(data.custAddress??"address", style: fontSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                            SizedBox(height: 2.r),
                                            Text(data.custCreateDatetime??"NA", style: fontSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                            isLastItem ? const SizedBox():
                                            Container(
                                              height: 1.r,
                                              margin: EdgeInsets.symmetric(vertical: 15.r),
                                              color: AllColors.lightGrey.withOpacity(0.8),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }) :
                        ListView.builder(
                            itemCount: 12,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.r),
                            itemBuilder: (context, index){
                              return Container(
                                padding: EdgeInsets.only(left: 5.0.r,right: 5.0.r),
                                color: AllColors.white,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      enabled: true,
                                      child: CircleAvatar(
                                        radius: 18.r,
                                        backgroundColor: AllColors.white,
                                      ),
                                    ),
                                    SizedBox(width: 10.r),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Shimmer.fromColors(
                                                    baseColor: Colors.grey.shade300,
                                                    highlightColor: Colors.grey.shade100,
                                                    enabled: true,
                                                    child: Container(
                                                      width: 150.r,
                                                      height: 15.r,
                                                      color: AllColors.white,
                                                      margin: EdgeInsets.only(right: 5.r),
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.r),
                                                  Shimmer.fromColors(
                                                    baseColor: Colors.grey.shade300,
                                                    highlightColor: Colors.grey.shade100,
                                                    enabled: true,
                                                    child: Container(
                                                      width: 80.r,
                                                      height: 10.r,
                                                      color: AllColors.white,
                                                      margin: EdgeInsets.only(right: 5.r),
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.r),
                                                  Shimmer.fromColors(
                                                    baseColor: Colors.grey.shade300,
                                                    highlightColor: Colors.grey.shade100,
                                                    enabled: true,
                                                    child: Container(
                                                      width: 120.r,
                                                      height: 10.r,
                                                      color: AllColors.white,
                                                      margin: EdgeInsets.only(right: 5.r),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          if(index!=11)
                                            Container(
                                              height: 1.r,
                                              margin: EdgeInsets.symmetric(vertical: 10.r),
                                              color: AllColors.lightGrey,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      }),
                      if(controller.my_cust_model.value.message.toString()=="Data Not Found.")
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 15.r),
                            child: Text("Data not found !!",style: fontRegular.copyWith(letterSpacing: 0,color: AllColors.black.withOpacity(0.7)),)
                        ),
                      if(controller.my_cust_model.value.data.length > 7)
                        SizedBox(height: 50.r),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  myTeamDefaultScreen(BuildContext context) {
    return Container(
      color: AllColors.none,
      padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 30.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical:30.0.r),
            child: Text("You are yet to build your team",style: fontBold.copyWith(),),
          ),
          Icon(Icons.account_circle,size: 25.r),
          SizedBox(height: 20.r),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for(var i = 0; i < 14; i++)
                Image.asset(Images.people,height: 22.r,width: 22.r,)
            ],
          ),
          SizedBox(height: 25.r),
          RichText(
            text: TextSpan(
              text: "BankBay offers our partners with ",
              style: fontRegular.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.7)),
              children: [
                TextSpan(text: 'Direct ', style: fontMedium.copyWith(fontSize: 12.r)),
                TextSpan(text: 'and ', style: fontRegular.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.7))),
                TextSpan(text: 'Indirect incentive ', style: fontMedium.copyWith(fontSize: 12.r)),
                TextSpan(text: 'beset under is Partners program', style: fontRegular.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.7))),
              ],
            ),
          ),
          SizedBox(height: 20.r),
          RichText(
            text: TextSpan(
              text: "What's more, you can refer ",
              style: fontRegular.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.7)),
              children: [
                TextSpan(text: "unlimited partners ", style: fontMedium.copyWith(fontSize: 12.r)),
                TextSpan(text: "and build your own team and ", style: fontRegular.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.7))),
                TextSpan(text: 'run your business without any investment ar rick. ', style: fontMedium.copyWith(fontSize: 12.r)),
              ],
            ),
          ),
          SizedBox(height: 20.r),
          Text("Join our Partner program and create long term earning stream?", style: fontRegular.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.7))),
          SizedBox(height: 60.r),
          CustomButton(
            title: "Refer & Build Team".tr,
            background: true,
            onTap: (){
              if(partnerController.profileComplete.value.data.popupStatus.toString()=="true"){
                print("jhss ${partnerController.profileComplete.value.data.popupStatus}");
                if(partnerController.customerDetails.value.data.partnerdetails.partnerStatus.toString().toLowerCase()=="active") {
                  shareAlertDialog(context);
                }else{
                  _underProcessAccess(context);
                }
              }else if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10")==true){
                shareAlertDialog(context);
              }else{
                _profileComplete(context, partnerController.profileComplete.value.data);
              }
            },
            width: Get.width-80,
          ),
          SizedBox(height: 40.r),
        ],
      ),
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

  shareAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Build your team !! Invite members", style:fontBold.copyWith(),textAlign: TextAlign.center),
      content: SizedBox(
        height: 130.r,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Note-This invite will be sent as text message (SMS). Please advise your contact to click on link in the message and install Bankbay app",
                style: fontRegular.copyWith(fontSize: 12.r, wordSpacing: 0.2, letterSpacing: 0.2),
              ),
              SizedBox(height: 20.r),
              UnderLineTextField(
                hint: "Phone Number".tr,
                labelText: "Phone Number".tr,
                controller: partnerController.sendInvite,
                onTap: () {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
                isRead: false,
                length: 10,
                type: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
      actions: [
        Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(bottom: 20.r),
          child: CustomButton(
            title: "Send Invite".tr,
            width: 150.r,
            height: 35.r,
            background: true,
            onTap:  ()async{
              bool status = await partnerController.appShareNetworkApi();
              if(status==true){
                Navigator.pop(context);
                await Share.share("Here's your special discount worth ₹100 on Bankbay. Ready to loan? "
                    "\n1. Download the Bankbay app from here: https://cruid1.wisdomlife.in/admin_assets/img/avtar.png"
                    "\n2. Use my invite code ${GetStorage().read(AppConstant.name).toString().replaceAll(" ", "").toLowerCase()}. Get ₹100 in discounts \n\nLet the loan apply!");
              }
            },
          ),
        ),
      ],
    );
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget buildRadioButtonEMP(String title, String value) {
    return Obx(() => Row(
      children: [
        SizedBox(
          height: 22.r,
          width: 25.r,
          child: Radio(
            value: value,
            groupValue: controller.isMyCustEMPSelected.value,
            onChanged: (selectedValue) {
              controller.isMyCustEMPSelected.value = selectedValue.toString();
              controller.getMyCustNetworkApi(_sourceFilterSendValue(controller.isMyCustEMPSelected.value), partnerController.sourceFilterSendValue(controller.filterTypeSelected.value),partnerController.loanTypeDecode(controller.selectLoanType.value),_statusFilterValue(selectedValidation.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
            },
          ),
        ),
        SizedBox(width: 6.r),
        Text(title),
      ],
    ),
    );
  }

  _sourceFilterSendValue(String value){
    if(controller.filterTypeSelected.value=="Employee"||controller.filterTypeSelected.value=="Partner") {
      switch (value) {
      case "All":
        return "";
      case "Direct":
        return "direct";
      case "Indirect":
        return "indirect";
      default:
        return "";
    }
    }else{
      return "";
    }
  }

  _statusFilterValue(String value){
    switch (value) {
      case "All Status":
        return "";
      case "Pending Validation":
        return "no";
      case "Validated":
        return "yes";
      default:
        return "";
    }
  }
}
