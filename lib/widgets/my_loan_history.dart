// ignore_for_file: deprecated_member_use

import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_appbar.dart';
import 'package:bank_bay/utils_method/custom_leads_details.dart';
import 'package:bank_bay/utils_method/loading_more_widget.dart';
import 'package:bank_bay/widgets/Customer%20details/customer_details.dart';
import 'package:bank_bay/widgets/Customer%20details/customer_loan_list_details.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

class MyLoanHistory extends StatefulWidget {
  const MyLoanHistory({super.key});

  @override
  State<MyLoanHistory> createState() => _MyLoanHistoryState();
}

class _MyLoanHistoryState extends State<MyLoanHistory> {
  var controller = Get.find<PartnerController>();
  var loginController = Get.find<LoginController>();
  RxBool calender=false.obs;
  var selectedDay = DateTime.now().obs;
  var monthYear = DateTime.now().obs;

  @override
  void initState() {
    controller.myLoanNext = 10;
    controller.myLeadHistoryNetworkApi(true, "","",controller.loanTypeDecode(loginController.selectLoanType.value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.withOpacity(0.1),
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          50.0.r,
        ),
        child: CustomAppBar(
          title: "My Loan History".tr,
          leadingBool: false,
          back: true,
          onTab: ()=> Get.back(),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10.r),
        child: Obx(()=> Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(0, 85.r, 0, 10.r), // Adjust the position of the popup menu
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
                        ],
                      ).then((value) {
                        loginController.selectLoanType.value =value??"All Loan";
                        if(loginController.myLoanTypeSelected.value=="My Loan"){
                          controller.myLeadHistoryNetworkApi(true, "","",controller.loanTypeDecode(loginController.selectLoanType.value));
                        }else if(loginController.myLoanTypeSelected.value=="Draft Loan"){
                          controller.draftLoanLeadNetworkApi(true, "","",controller.loanTypeDecode(loginController.selectLoanType.value));
                        }
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          color: AllColors.blue.withOpacity(0.4),
                          child: Icon(Icons.unfold_more,size: 16.r,color: AllColors.black,),
                        ),
                        SizedBox(width: 8.r),
                        Obx(() => Text(loginController.selectLoanType.value,style: fontSmall.copyWith(letterSpacing: 0,wordSpacing: 0),)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: (){},
                        child: Padding(
                          padding: EdgeInsets.all(5.0.r),
                          child: Icon(
                            Icons.tune,
                            size: 16.r,color: AllColors.black.withOpacity(0.8),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.r),
                      InkWell(
                        onTap: () => calender.value=true,
                        child: Text(
                          DateFormat('yyy-MM-dd').format(selectedDay.value)!=DateFormat('yyy-MM-dd').format(DateTime.now())? DateFormat('MMMM - yyy').format(selectedDay.value).toString() :"All Time",
                          style: fontSmall.copyWith(letterSpacing: 0,wordSpacing: 0),),
                      ),
                      SizedBox(width: 5.r),
                      InkWell(
                        onTap: () => calender.value=true,
                        child: Icon(
                          Icons.calendar_month_outlined,
                          size: 16.r,color: AllColors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildRadioButtonEMP("My Loan", "My Loan"),
                  SizedBox(width: 25.r),
                  buildRadioButtonEMP('Draft Loan', "Draft Loan"),
                ],
              ),
            ),
            SizedBox(height: 12.r),
            if(calender.value==true)
              SizedBox(height: 5.r),
            if(calender.value==true)
              Container(
                margin: EdgeInsets.symmetric(horizontal:10.0.r),
                padding: EdgeInsets.symmetric(horizontal:8.r, vertical: 8.r),
                color: AllColors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){},
                      child: Icon(Icons.arrow_back_ios, size: 15.r, color: AllColors.black,),
                    ),
                    Expanded(
                      child: WeeklyDatePicker(
                        selectedDay: selectedDay.value, // DateTime
                        changeDay: (value)async{
                          selectedDay.value = value;
                          monthYear.value = value;
                          if(loginController.myLoanTypeSelected.value=="My Loan"){
                            await controller.myLeadHistoryNetworkApi(true, DateFormat('yyy-MM-dd').format(value).toString(),DateFormat('yyy-MM').format(value),controller.loanTypeDecode(loginController.selectLoanType.value));
                          }else if(loginController.myLoanTypeSelected.value=="Draft Loan"){
                            await controller.draftLoanLeadNetworkApi(true, DateFormat('yyy-MM-dd').format(value).toString(),DateFormat('yyy-MM').format(value),controller.loanTypeDecode(loginController.selectLoanType.value));
                          }
                        },
                        enableWeeknumberText: false,
                        weeknumberColor: AllColors.lightTeal.withOpacity(0.8),
                        weeknumberTextColor: Colors.white,
                        backgroundColor: AllColors.white,
                        weekdayTextColor: AllColors.black,
                        digitsColor: AllColors.black.withOpacity(0.6),
                        // selectedBackgroundColor: AllColors.lightTeal.withOpacity(0.8),
                        weekdays: const ["S", "M", "T", "W", "T","F", "S"],
                        daysInWeek: 7,
                      ),
                    ),
                    InkWell(
                      onTap: (){},
                      child: Icon(Icons.arrow_forward_ios, size: 15.r, color: AllColors.black,),
                    ),
                  ],
                ),
              ),
            if(calender.value==true)
              SizedBox(height: 5.r),
            Expanded(
              child: RefreshIndicator(
                color: AllColors.themeColor,
                onRefresh: () {
                  return Future.delayed(Duration.zero, () {
                    controller.myLeadHistoryNetworkApi(true, "","",controller.loanTypeDecode(loginController.selectLoanType.value));
                    controller.draftLoanLeadNetworkApi(true, "","",controller.loanTypeDecode(loginController.selectLoanType.value));
                  });
                },
                child:loginController.myLoanTypeSelected.value=="Draft Loan"?
                SingleChildScrollView(
                  controller:controller.draftLoanLeadController,
                  padding: EdgeInsets.only(bottom: 15.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<PartnerController>(builder:(controller){
                        return controller.draft_history_model_loader.value?
                        ListView.builder(
                            itemCount: controller.draft_loan_history_model.value.data.leads.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index){
                              var data = controller.draft_loan_history_model.value.data.leads[index];
                              bool isLastItem = index == controller.draft_loan_history_model.value.data.leads.length - 1;
                              return CustomLeadsDetails(
                                name: data.custName??"NA",
                                leadId: data.leadId??"",
                                leadTypeName: data.leadSource??"",
                                address: data.custPermanentAddress??"NA",
                                createDate: data.leadDateTime??"NA",
                                image: data.custLoanSelfie.toString(),
                                number: "",
                                leadLockStatus: data.leadLockStatus??"false",
                                leadStatus: data.leadStatus??"",
                                holdCount: data.holdCount,
                                lockedBy: data.lockedBy??"",
                                index: isLastItem,
                                detailsTap: ()=> Get.to(()=> CustomerDetails(leadId: "${data.id??""}",customerId: data.custId??"",value: "myLoanHistoryDetails", apiLeadId: data.leadId)),
                                nameTap: ()=> Get.to(()=> CustomerLoanListDetails(leadId: "${data.id??""}",customerId: data.custId??"")),
                                transferLeadStatus: false,
                              );
                            }) :
                        ListView.builder(
                            itemCount: 12,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 10.r),
                            itemBuilder: (context, index){
                              return Container(
                                padding: EdgeInsets.only(left: 5.0.r,right: 5.0.r, top: index==0?8.r:0),
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
                      if(controller.draft_loan_history_model.value.message.toString()=="Data Not Found.")
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 250.r),
                          padding: EdgeInsets.symmetric(vertical: 12.0.r),
                          child: Text("Data not found !!", style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.6),fontWeight: FontWeight.w500),),
                        ),
                      if(controller.partnerLoadMore.value) const LoadingMoreData(),
                    ],
                  ),
                ) :
                SingleChildScrollView(
                  controller: controller.myLoanController,
                  padding: EdgeInsets.only(bottom: 15.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<PartnerController>(builder:(controller){
                        return controller.my_loan_history_model_loader.value?
                        ListView.builder(
                            itemCount: controller.my_loan_history_model.value.data.leads.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index){
                              var data = controller.my_loan_history_model.value.data.leads[index];
                              bool isLastItem = index == controller.my_loan_history_model.value.data.leads.length - 1;
                              return CustomLeadsDetails(
                                name: data.custName??"NA",
                                leadId: data.leadId??"",
                                leadTypeName: data.leadSource??"",
                                address: data.custPermanentAddress??"NA",
                                createDate: data.leadDateTime??"NA",
                                image: data.custLoanSelfie.toString(),
                                number: "",
                                leadLockStatus: data.leadLockStatus??"false",
                                leadStatus: data.leadStatus??"",
                                holdCount: data.holdCount,
                                lockedBy: data.lockedBy??"",
                                index: isLastItem,
                                detailsTap: ()=> Get.to(()=> CustomerDetails(leadId: "${data.id??""}",customerId: data.custId??"",value: "myLoanHistoryDetails", apiLeadId: data.leadId)),
                                nameTap: ()=> Get.to(()=> CustomerLoanListDetails(leadId: "${data.id??""}",customerId: data.custId??"")),
                                transferLeadStatus: false,
                              );
                            }) :
                        ListView.builder(
                            itemCount: 12,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 10.r),
                            itemBuilder: (context, index){
                              return Container(
                                padding: EdgeInsets.only(left: 5.0.r,right: 5.0.r, top: index==0?8.r:0),
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
                      if(controller.my_loan_history_model.value.message.toString()=="Data Not Found.")
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 250.r),
                        padding: EdgeInsets.symmetric(vertical: 12.0.r),
                        child: Text("Data not found !!", style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.6),fontWeight: FontWeight.w500),),
                      ),
                      if(controller.partnerLoadMore.value) const LoadingMoreData(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        ),
      ),
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
            groupValue: loginController.myLoanTypeSelected.value,
            onChanged: (selectedValue) {
              loginController.myLoanTypeSelected.value = selectedValue.toString();
              if(selectedValue=="My Loan"){
                controller.myLoanNext = 10;
                controller.myLeadHistoryNetworkApi(true, "","",controller.loanTypeDecode(loginController.selectLoanType.value));
              }else if(selectedValue=="Draft Loan"){
                controller.draftLoanLeadNext = 10;
                controller.draftLoanLeadNetworkApi(true, "","",controller.loanTypeDecode(loginController.selectLoanType.value));
              }
            },
          ),
        ),
        SizedBox(width: 6.r),
        Text(title),
      ],
    ),
    );
  }
}
