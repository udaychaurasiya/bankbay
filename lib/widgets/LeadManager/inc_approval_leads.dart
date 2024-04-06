// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use, use_build_context_synchronously

import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/controllers/permission_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/custom_leads_details.dart';
import 'package:bank_bay/utils_method/loading_more_widget.dart';
import 'package:bank_bay/utils_method/underline_dropdown.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/utils_method/uppercase_formate.dart';
import 'package:bank_bay/widgets/Customer%20details/customer_details.dart';
import 'package:bank_bay/widgets/Customer%20details/customer_loan_list_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

class IncApprovalLeads extends StatefulWidget {
  const IncApprovalLeads({super.key});

  @override
  State<IncApprovalLeads> createState() => _IncApprovalLeadsState();
}

class _IncApprovalLeadsState extends State<IncApprovalLeads> {
  var controller = Get.find<LoginController>();
  var permissionController = Get.find<PermissionController>();
  var partnerController = Get.find<PartnerController>();
  RxBool calender=false.obs;
  var selectedDay = DateTime.now().obs;
  var monthYear = DateTime.now().obs;
  var selectLoanType = "All Loan".obs;
  var selectedValidation = "All Status".obs;

  @override
  void initState() {
    controller.allLeadsDataNext = 10;
    controller.allLeadsDataNetworkApi("","","",partnerController.loanTypeDecode(selectLoanType.value.toString()),"","","",controller.leadsPageName.value,controller.filterTypeSelected.value,partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.filterTypeSelected.value="All Source";
    return Scaffold(
      backgroundColor: Colors.lightBlue.withOpacity(0.1),
      body: Obx(()=> Column(
        children: [
          Container(
            height: 45.r,
            padding: EdgeInsets.symmetric(horizontal: 12.r, vertical:10.0.r),
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
                      selectLoanType.value = value??"All Loan";
                      controller.allLeadsDataNetworkApi("","","",partnerController.loanTypeDecode(value.toString()),"","","",controller.leadsPageName.value,controller.filterTypeSelected.value,partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        color: AllColors.blue.withOpacity(0.4),
                        child: Icon(Icons.unfold_more,size: 15.r,color: AllColors.black,),
                      ),
                      SizedBox(width: 8.r),
                      Obx(() => Text(selectLoanType.value,style: fontSmall.copyWith(letterSpacing: 0,wordSpacing: 0),)),
                    ],
                  ),
                ),
                SizedBox(width: selectLoanType.value=="All Loan"?25.r:15.r),
                InkWell(
                  onTap: () {
                    showMenu(
                      context: context,
                      position: RelativeRect.fromSize(Rect.fromCircle(center: const Offset(80, 150), radius: 5), const Size(150, 300)),
                      items: <PopupMenuEntry<String>>[
                        PopupMenuItem(
                          value: 'All Source'.tr,
                          child: Text('All Source',style: fontMedium.copyWith()),
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
                      controller.allLeadsDataNetworkApi("","","",partnerController.loanTypeDecode(value.toString()),"","","",controller.leadsPageName.value, controller.filterTypeSelected.value,partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
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
                SizedBox(width: controller.filterTypeSelected.value=="All Source"?25.r:15.r),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => calender.value=true,
                      child: Text(
                        DateFormat('yyy-MM-dd').format(selectedDay.value)!=DateFormat('yyy-MM-dd').format(DateTime.now())? DateFormat('yyyy-MM-dd').format(selectedDay.value).toString() :"All Time",
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
                    SizedBox(width: 15.r),
                    InkWell(
                      onTap: (){
                        controller.loanType.value="All Loan";
                        controller.customerPan.clear();
                        controller.customerPhone.clear();
                        controller.leadStartDate.clear();
                        controller.leadEndDate.clear();
                        _showBottomSheetFilter(context);
                      },
                      child: Icon(
                        Icons.tune,
                        size: 16.r,color: AllColors.black.withOpacity(0.8),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        WeeklyDatePicker(
                          selectedDay: selectedDay.value, // DateTime
                          changeDay: (value)async{
                            selectedDay.value = value;
                            monthYear.value = value;
                            await controller.allLeadsDataNetworkApi(DateFormat('yyy-MM-dd').format(value).toString(),DateFormat('yyy-MM').format(value),"",partnerController.loanTypeDecode(value.toString()),"","","",controller.leadsPageName.value,controller.filterTypeSelected.value,partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
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
                        InkWell(
                          onTap: ()async{
                            bool status = await controller.allLeadsDataNetworkApi("","","",partnerController.loanTypeDecode(selectLoanType.value.toString()),"","","",controller.leadsPageName.value,controller.filterTypeSelected.value,partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                            if(status==true){
                              selectedDay.value=DateTime.now();
                              calender.value=false;
                            }
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text("Reset", style: fontBold.copyWith(fontSize: 12.r, color: AllColors.red.withOpacity(0.7)),),
                          ),
                        ),
                      ],
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
            child: SingleChildScrollView(
              controller: controller.allLeadsScroller,
              child: Container(
                margin: EdgeInsets.only(left:10.0.r, right: 10.r, top: 8.r, bottom: 8.r),
                padding: EdgeInsets.symmetric(horizontal:8.r, vertical: 10.r),
                color: AllColors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(() {
                      return ListView.builder(
                          itemCount: controller.allLeadsDataModel.value.data.newLeade.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(bottom: 5.r),
                          itemBuilder: (context, index){
                            var data = controller.allLeadsDataModel.value.data.newLeade[index];
                            bool isLastItem = index == controller.allLeadsDataModel.value.data.newLeade.length - 1;
                            return CustomLeadsDetails(
                              name: data.custName??"NA",
                              leadId: data.leadId??"",
                              leadTypeName: data.leadSourceBy??"",
                              address: data.custPermanentAddress??"NA",
                              createDate: data.leadDateTime??"NA",
                              image: data.custLoanSelfie.toString(),
                              number: data.custPhone??"",
                              leadLockStatus: data.leadLockStatus??"false",
                              leadStatus: data.leadStatus??"",
                              holdCount: data.holdCount,
                              lockedBy: data.lockedBy??"",
                              leadSource: data.leadSource??"",
                              disbursal: "${data.disbAmt??""}",
                              pageName: "IncDetails",
                              index: isLastItem,
                              detailsTap: ()async{
                                bool checkStatus = await controller.allLeadsDataNetworkApi("","","",partnerController.loanTypeDecode(selectLoanType.value.toString()),"","","",controller.leadsPageName.value,controller.filterTypeSelected.value,partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                if(checkStatus==true){
                                  if(controller.allLeadsDataModel.value.data.newLeade[index].leadLockStatus=="false") {
                                    bool status = await permissionController.lockUnlockLeadNetworkApi(controller.allLeadsDataModel.value.data.newLeade[index].leadId, "true");
                                    if(status==true) {
                                      Get.to(()=> CustomerDetails(leadId: "${data.id??""}",customerId: data.custId??"",value: "incDetails",apiLeadId: data.leadId, pageName: "incApprovalLeads",));
                                      controller.allLeadsDataNetworkApi("","","",partnerController.loanTypeDecode(selectLoanType.value.toString()),"","","",controller.leadsPageName.value,controller.filterTypeSelected.value,partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                    }
                                  }else{
                                    BaseController().errorSnack("Already details View on ${controller.allLeadsDataModel.value.data.newLeade[index].lockedBy.toString()}");
                                    controller.allLeadsDataNetworkApi("","","",partnerController.loanTypeDecode(selectLoanType.value.toString()),"","","",controller.leadsPageName.value,controller.filterTypeSelected.value,partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                  }
                                }
                              },
                              nameTap: ()=> Get.to(()=> CustomerLoanListDetails(leadId: "${data.id??""}",customerId: data.custId??"")),
                              transferLeadStatus: false,
                            )
                            /*:Container(
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
                                  SizedBox(width: 8.r),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
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
                                                  Text(data.custPermanentAddress??"NA", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: "Lead source : ",
                                                      style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),fontSize: 11.r),
                                                      children: [
                                                        TextSpan(text: data.leadSource??"NA", style: fontExtraSmall.copyWith(fontSize: 11.r,color: AllColors.blue)),
                                                        // TextSpan(text: " (${data.custId??"NA"})", style: fontExtraSmall.copyWith(fontSize: 11.r,overflow: TextOverflow.ellipsis)),
                                                      ],
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: "Lead date : ",
                                                      style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),fontSize: 11.r),
                                                      children: [
                                                        TextSpan(text: data.leadDateTime??"NA", style: fontExtraSmall.copyWith(fontSize: 11.r,overflow: TextOverflow.ellipsis)),
                                                      ],
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: "Disbursal : ",
                                                      style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),fontSize: 11.r),
                                                      children: [
                                                        TextSpan(text: "${data.disbAmt??"0"} ${data.sancDate??"00"}", style: fontExtraSmall.copyWith(fontSize: 11.r,overflow: TextOverflow.ellipsis)),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: ()=> launch("tel://+91${data.custPhone}"),
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 12.r,vertical: 3.r),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(100.r),
                                                        border: Border.all(width: 0.5, color: AllColors.grey.withOpacity(0.6))
                                                    ),
                                                    child: Icon(
                                                      Icons.call,
                                                      size: 12.r,
                                                      color: AllColors.red.withOpacity(0.6),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0.r),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              GetBuilder<LoginController>(builder: (controller){
                                                return controller.allLeadsDataModel.value.data.newLeade[index].leadLockStatus=="true"?
                                                Container(
                                                  width: 80.r,
                                                  height: 22.r,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(2.r),
                                                      color: AllColors.lightGrey.withOpacity(0.6),
                                                      border: Border.all(width: 0.5.r, color: AllColors.black.withOpacity(0.5))
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.lock_open_outlined,size: 15.r, color: AllColors.black.withOpacity(0.6)),
                                                      SizedBox(width: 5.r),
                                                      Obx(() => Text(controller.allLeadsDataModel.value.data.newLeade[index].lockedBy.toString(),style: fontMedium.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.6)),textAlign: TextAlign.end,)),
                                                    ],
                                                  ),
                                                ) :
                                                InkWell(
                                                  onTap: ()async{
                                                    bool checkStatus = await controller.allLeadsDataNetworkApi("","","",partnerController.loanTypeDecode(selectLoanType.value.toString()),"","","",controller.leadsPageName.value,controller.filterTypeSelected.value,partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                                    if(checkStatus==true){
                                                      if(controller.allLeadsDataModel.value.data.newLeade[index].leadLockStatus=="false") {
                                                        bool status = await permissionController.lockUnlockLeadNetworkApi(controller.allLeadsDataModel.value.data.newLeade[index].leadId, "true");
                                                        if(status==true) {
                                                          Get.to(()=> CustomerDetails(leadId: "${data.id??""}",customerId: data.custId??"",value: "incDetails",apiLeadId: data.leadId, pageName: "incApprovalLeads",));
                                                          controller.allLeadsDataNetworkApi("","","",partnerController.loanTypeDecode(selectLoanType.value.toString()),"","","",controller.leadsPageName.value,controller.filterTypeSelected.value,partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                                        }
                                                      }else{
                                                        BaseController().errorSnack("Already details View on ${controller.allLeadsDataModel.value.data.newLeade[index].lockedBy.toString()}");
                                                        controller.allLeadsDataNetworkApi("","","",partnerController.loanTypeDecode(selectLoanType.value.toString()),"","","",controller.leadsPageName.value,controller.filterTypeSelected.value,partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    width: 90.r,
                                                    height: 22.r,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(2.r),
                                                      color: AllColors.themeColor,
                                                    ),
                                                    child: Text( "View Details",style: fontMedium.copyWith(fontSize: 12.r, color: AllColors.white.withOpacity(0.8)),),
                                                  ),
                                                );
                                              }),
                                              Row(
                                                children: [
                                                  Icon(Icons.av_timer, size: 18.r, color: AllColors.black,),
                                                  SizedBox(width: 5.r),
                                                  Text("Hold", style: fontSmall.copyWith(color: AllColors.black.withOpacity(0.7)),),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        isLastItem ? const SizedBox():
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
                            )*/;
                          });
                    }),
                    Obx(() => controller.allLeadsDataModel.value.message.toString()=="Data Not Found."?
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: 10.r),
                          child: Text("Data not found !!",style: fontRegular.copyWith(letterSpacing: 0,color: AllColors.black.withOpacity(0.7)),)
                      ): const SizedBox()),
                    Obx(() => controller.isLoadMore.value? const LoadingMoreData():const SizedBox()),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 50.r),
        ],
      ),
      ),

    );
  }
  void _showBottomSheetFilter(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              bottomLeft: Radius.circular(10.r),
              topRight: Radius.zero,
              bottomRight:  Radius.zero,
            )
        ),
        insetPadding: EdgeInsets.only(left: 80.r,top: 40.r),
        child: Container(
          width: Get.width-80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                bottomLeft: Radius.circular(10.r),
                topRight: Radius.zero,
                bottomRight:  Radius.zero,
              )
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: ()=> Navigator.pop(context),
                    icon: CircleAvatar(
                      radius: 10.r,
                      backgroundColor: AllColors.grey.withOpacity(0.7),
                      child: Icon(Icons.close,size: 15.r,color: AllColors.white,),
                    ),
                  ),
                ),
                Container(
                  height: 3.r,
                  color: AllColors.lightGrey,
                ),
                SizedBox(height: 20.r),
                Container(
                  padding: EdgeInsets.only(right: 10.r, left: 15.r),
                  child: Form(
                    // key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Customer PAN",
                          style: fontMedium.copyWith(
                            color: Colors.black.withOpacity(0.8),
                            letterSpacing: 0,
                            wordSpacing: 0,
                          ),
                        ),
                        UnderLineTextField(
                          hint: "type here...".tr,
                          controller: controller.customerPan,
                          label: false,
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter permanent account number (PAN)';
                            }else if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value)) {
                              return 'Please enter valid PAN card';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15.r),
                        Text(
                          "Customer Phone or Email ID",
                          style: fontMedium.copyWith(
                            color: Colors.black.withOpacity(0.8),
                            letterSpacing: 0,
                            wordSpacing: 0,
                          ),
                        ),
                        UnderLineTextField(
                          hint: "type here...".tr,
                          label: false,
                          controller: controller.customerPhone,
                          onTap: () {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15.r),
                        Text(
                          "Loan owner PAN",
                          style: fontMedium.copyWith(
                            color: Colors.black.withOpacity(0.8),
                            letterSpacing: 0,
                            wordSpacing: 0,
                          ),
                        ),
                        UnderLineTextField(
                          hint: "type here...".tr,
                          label: false,
                          controller: controller.loanOwnerPan,
                          onTap: () {},
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter permanent account number (PAN)';
                            }else if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value)) {
                              return 'Please enter valid PAN card';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15.r),
                        Text(
                          "Loan owner Phone",
                          style: fontMedium.copyWith(
                            color: Colors.black.withOpacity(0.8),
                            letterSpacing: 0,
                            wordSpacing: 0,
                          ),
                        ),
                        UnderLineTextField(
                          hint: "type here...".tr,
                          label: false,
                          controller: controller.loanOwnerPhone,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          length: 10,
                          type: TextInputType.number,
                          onTap: () {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15.r),
                        Text(
                          "All Loan",
                          style: fontMedium.copyWith(
                            color: Colors.black.withOpacity(0.8),
                            letterSpacing: 0,
                            wordSpacing: 0,
                          ),
                        ),
                        CustomUnderlineDropdownField(
                          items: ["Personal loan", "Business loan", "Self-Employee Loan"].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                              onTap: (){
                                print("value $value");
                                controller.loanType.value=value;
                              },
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            controller.gender.value = newValue ?? "Personal loan";
                          },
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please select gender';
                          //   }
                          //   return null;
                          // },
                          // value: controller.gender.value,
                          hint: "select All Loan",
                        ),
                        SizedBox(height: 20.r),
                        Text(
                          "Lead updated time",
                          style: fontMedium.copyWith(
                            color: Colors.black.withOpacity(0.8),
                            letterSpacing: 0,
                            wordSpacing: 0,
                          ),
                        ),
                        SizedBox(height: 5.r),
                        Row(
                          children: [
                            Expanded(
                              child:  UnderLineTextField(
                                hint: 'Start Date'.tr,
                                label: false,
                                isRead: true,
                                icon: true,
                                controller: controller.leadStartDate,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2800));

                                  if (pickedDate != null) {
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    controller.leadStartDate.text = formattedDate;
                                    print(formattedDate);
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter start date';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 15.r),
                            Expanded(
                              child:  UnderLineTextField(
                                hint: 'End Date'.tr,
                                label: false,
                                isRead: true,
                                icon: true,
                                controller: controller.leadEndDate,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2800));

                                  if (pickedDate != null) {
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    print(formattedDate);
                                    controller.leadEndDate.text = formattedDate;
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter end date';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.r),
                        Text(
                          "Lead updated time",
                          style: fontMedium.copyWith(
                            color: Colors.black.withOpacity(0.8),
                            letterSpacing: 0,
                            wordSpacing: 0,
                          ),
                        ),
                        SizedBox(height: 5.r),
                        Row(
                          children: [
                            Expanded(
                              child:  UnderLineTextField(
                                hint: 'Start Date'.tr,
                                label: false,
                                isRead: true,
                                icon: true,
                                // controller: controller.etDob,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2800));
                                  if (pickedDate != null) {
                                    print(pickedDate);
                                    String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                    print(formattedDate);
                                    // controller.etDob.text = formattedDate;
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter start date';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 15.r),
                            Expanded(
                              child:  UnderLineTextField(
                                hint: 'End Date'.tr,
                                label: false,
                                isRead: true,
                                icon: true,
                                // controller: controller.etDob,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2800));

                                  if (pickedDate != null) {
                                    print(pickedDate);
                                    String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                    print(formattedDate);
                                    // controller.etDob.text = formattedDate;
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter end date';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40.r),
                        CustomButton(
                          title: "Search now".tr,
                          background: false,
                          radius: 5.r,
                          height: 35.r,
                          bgColor: AllColors.green,
                          width: Get.width,
                          onTap: () async {
                            Navigator.pop(context);
                            controller.allLeadsDataNetworkApi("","", controller.customerPan.text, controller.loanType.value, controller.customerPhone.text, controller.leadStartDate.text, controller.leadEndDate.text,controller.leadsPageName.value,controller.filterTypeSelected.value,partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                            controller.loanType.value="All Loan";
                            controller.customerPan.clear();
                            controller.customerPhone.clear();
                            controller.leadStartDate.clear();
                            controller.leadEndDate.clear();
                          },
                        ),
                        SizedBox(height: 15.r),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget typeRadioButtonFilter(String title, String value) {
    return Obx(() => Row(
      children: [
        SizedBox(
          height: 22.r,
          width: 30.r,
          child: Transform.scale(
            scale: 0.9,
            child: Radio(
              value: value,
              groupValue: controller.filterTypeSelected.value,
              onChanged: (selectedValue) {
                controller.filterTypeSelected.value = selectedValue.toString();
                print("xnbnx $selectedValue");
                controller.allLeadsDataNetworkApi("","","",partnerController.loanTypeDecode(selectLoanType.value.toString()),"","","",controller.leadsPageName.value,controller.filterTypeSelected.value,partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
              },
            ),
          ),
        ),
        Text(title),
      ],
    ),
    );
  }
}
