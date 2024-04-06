// ignore_for_file: deprecated_member_use

import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils_method/custom_appbar.dart';
import 'package:bank_bay/utils_method/custom_image.dart';
import 'package:bank_bay/utils_method/custom_image_view.dart';
import 'package:bank_bay/utils_method/loading_more_widget.dart';
import 'package:bank_bay/widgets/Customer%20details/customer_details.dart';
import 'package:bank_bay/widgets/Customer%20details/customer_loan_list_details.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

class DraftLeadLoan extends StatefulWidget {
  const DraftLeadLoan({super.key});

  @override
  State<DraftLeadLoan> createState() => _DraftLeadLoan();
}

class _DraftLeadLoan extends State<DraftLeadLoan> {
  var controller = Get.find<PartnerController>();
  var loginController = Get.find<LoginController>();

  @override
  void initState() {
    controller.draftLoanLeadNext = 10;
    controller.myLeadHistoryNetworkApi(true, "","",controller.loanTypeDecode(loginController.selectLoanType.value));
    super.initState();
  }

  void setFilter(String filter) {
    loginController.selectLoanType.value = filter;
  }

  @override
  Widget build(BuildContext context) {
    RxBool calender=false.obs;
    var selectedDay = DateTime.now().obs;
    var monthYear = DateTime.now().obs;

    return Scaffold(
      backgroundColor: Colors.lightBlue.withOpacity(0.1),
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          50.0.r,
        ),
        child: CustomAppBar(
          title: "Draft Lead History".tr,
          leadingBool: false,
          back: true,
          onTab: ()=> Get.back(),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10.r),
        // margin: EdgeInsets.all(10.r),
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
                        position: RelativeRect.fromLTRB(0, 130.r, 0, 10.r), // Adjust the position of the popup menu
                        items: <PopupMenuEntry<String>>[
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
                        setFilter(value??"Personal Loan");
                        controller.draftLoanLeadNetworkApi(true, "","", controller.loanTypeDecode(loginController.selectLoanType.value));
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
                      child: Obx(()=> WeeklyDatePicker(
                        selectedDay: selectedDay.value, // DateTime
                        changeDay: (value)async{
                          selectedDay.value = value;
                          monthYear.value = value;
                          await controller.draftLoanLeadNetworkApi(true, DateFormat('yyy-MM-dd').format(value).toString(),DateFormat('yyy-MM').format(value), controller.loanTypeDecode(loginController.selectLoanType.value));
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
                      ),),
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
                    controller.draftLoanLeadNetworkApi(true, "","","");
                  });
                },
                child: SingleChildScrollView(
                  controller: controller.draftLoanLeadController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx((){
                        return controller.draft_loan_history_model.value.data.leads.isNotEmpty?
                          ListView.builder(
                              itemCount: controller.draft_loan_history_model.value.data.leads.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index){
                                var data = controller.draft_loan_history_model.value.data.leads[index];
                                bool isLastItem = index == controller.draft_loan_history_model.value.data.leads.length - 1;
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5.0.r),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: ()=> Get.to(()=> CustomImageView(imageUrls: AppConstants.BASE_URL+data.custLoanSelfie.toString())),
                                        child: CircleAvatar(
                                          radius: 18.r,
                                          backgroundColor: AllColors.lightTeal.withOpacity(0.6),
                                          child: CustomImage(
                                            image: data.custLoanSelfie.toString(),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.r),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: ()=> Get.to(()=> CustomerLoanListDetails(leadId: "${data.id??""}",customerId: data.custId??"")),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      text: data.custName??"NA",
                                                      style: fontSmall.copyWith(fontWeight: FontWeight.w500),
                                                      children: [
                                                        TextSpan(text: " (${data.leadId??"NA"})", style: fontSmall.copyWith()),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Text(data.custPermanentAddress??"Lucknow, Utter Pradesh", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                                Text(data.leadDateTime??"NA", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 8.0.r),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: () async{
                                                      Get.to(()=> CustomerDetails(leadId: "${data.id??""}",customerId: data.custId??"",value: "myLoanHistoryDetails", apiLeadId: data.leadId));
                                                    },
                                                    child: Container(
                                                      width: 90.r,
                                                      height: 22.r,
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(2.r),
                                                        color: AllColors.themeColor,
                                                      ),
                                                      child: Text("View Details",style: fontMedium.copyWith(fontSize: 12.r, color: AllColors.white.withOpacity(0.8)),),
                                                    ),
                                                  ),
                                                  Text("${data.leadStatus.toString().capitalize}",style: fontBold.copyWith(
                                                    color: data.leadStatus.toString()=="verified"?AllColors.green:AllColors.red.withOpacity(0.65),
                                                    fontSize: 14.r,
                                                    letterSpacing: 0.2,
                                                  ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            isLastItem ? SizedBox(height: 10.r):
                                            Container(
                                              height: 1.r,
                                              margin: EdgeInsets.symmetric(vertical: 12.r),
                                              color: AllColors.lightGrey.withOpacity(0.8),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }) :
                          const SizedBox();
                      }),
                      Obx(() =>controller.draft_loan_history_model.value.message.toString()=="Data Not Found."?
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 250.r),
                          padding: EdgeInsets.symmetric(vertical: 12.0.r),
                          child: Text("Data not found !!", style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.6),fontWeight: FontWeight.w500),),
                        ):
                        const SizedBox(),
                      ),
                      Obx(() => controller.partnerLoadMore.value? const LoadingMoreData():const SizedBox()),
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
}
