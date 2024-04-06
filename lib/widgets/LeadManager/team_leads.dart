// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use, use_build_context_synchronously

import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/controllers/permission_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
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
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

class TeamLeadsScreen extends StatefulWidget {
  const TeamLeadsScreen({super.key});

  @override
  State<TeamLeadsScreen> createState() => _TeamLeadsScreenState();
}

class _TeamLeadsScreenState extends State<TeamLeadsScreen> {
  LoginController controller = Get.find<LoginController>();
  var permissionController = Get.find<PermissionController>();
  var partnerController = Get.find<PartnerController>();
  RxBool calender=false.obs;
  var selectedDay = DateTime.now().obs;
  var monthYear = DateTime.now().obs;
  var selectedMenu = "Set Follow-up".obs;

  @override
  void initState() {
    controller.teamLeadsNext = 10;
    controller.teamLeadsNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value),partnerController.sourceFilterSendValue(controller.filterTypeSelected.value.toString()),partnerController.leadStatusNameFilter(controller.isTeamLeadEmpSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.selectEmployeePartnerValue.value ="All Reports";
    return Scaffold(
      backgroundColor: Colors.lightBlue.withOpacity(0.1),
      body: Obx(()=> Column(
        children: [
          SizedBox(height: 5.r),
          Container(
            height: 45.r,
            padding: EdgeInsets.only(left: 12.0.r, right: 10, top: 10),
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
                      ],
                    ).then((value) {
                      controller.selectLoanType.value=value??"All Loan";
                      controller.teamLeadsNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()), "", "", "", "",partnerController.leadStageStatusDecode(controller.selectStageType.value),partnerController.sourceFilterSendValue(controller.filterTypeSelected.value.toString()),partnerController.leadStatusNameFilter(controller.isTeamLeadEmpSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(1.r),
                        color: AllColors.blue.withOpacity(0.4),
                        child: Icon(Icons.unfold_more,size: 14.r,color: AllColors.black,),
                      ),
                      SizedBox(width: 6.r),
                      Obx(() => Text(controller.selectLoanType.value,style: fontSmall.copyWith(letterSpacing: 0,wordSpacing: 0),)),
                    ],
                  ),
                ),
                SizedBox(width: controller.selectLoanType.value=="All Loan"?25.r:15.r),
                InkWell(
                  onTap: () {
                    showMenu(
                      context: context,
                      position: RelativeRect.fromSize(Rect.fromCircle(center: const Offset(70, 150), radius: 5), const Size(150, 300)),
                      items: <PopupMenuEntry<String>>[
                        PopupMenuItem(
                          value: 'All Stage'.tr,
                          child: SizedBox(
                            width: 150.r,
                            child: Text('All Stage',style: fontMedium.copyWith()),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'Draft'.tr,
                          child: Text('Draft',style: fontMedium.copyWith()),
                        ),
                        PopupMenuItem(
                          value: 'Submitted'.tr,
                          child: Text('Submitted',style: fontMedium.copyWith()),
                        ),
                        PopupMenuItem(
                          value: 'Hold'.tr,
                          child: Text('Hold',style: fontMedium.copyWith()),
                        ),
                        PopupMenuItem(
                          value: 'Released'.tr,
                          child: Text('Released',style: fontMedium.copyWith()),
                        ),
                        PopupMenuItem(
                          value: 'Verified'.tr,
                          child: Text('Verified',style: fontMedium.copyWith()),
                        ),
                        PopupMenuItem(
                          value: 'Login'.tr,
                          child: Text('Login',style: fontMedium.copyWith()),
                        ),
                        PopupMenuItem(
                          value: 'Sanction'.tr,
                          child: Text('Sanction',style: fontMedium.copyWith()),
                        ),
                        PopupMenuItem(
                          value: 'Disbursed'.tr,
                          child: Text('Disbursed',style: fontMedium.copyWith()),
                        ),
                        PopupMenuItem(
                          value: 'Inc Due'.tr,
                          child: Text('Inc Due',style: fontMedium.copyWith()),
                        ),
                        PopupMenuItem(
                          value: 'Inc Paid'.tr,
                          child: Text('Inc Paid',style: fontMedium.copyWith()),
                        ),
                        PopupMenuItem(
                          value: 'Rejected'.tr,
                          child: Text('Rejected',style: fontMedium.copyWith()),
                        ),
                      ],
                    ).then((value) {
                      controller.selectStageType.value=value??"All Stage";
                      controller.teamLeadsNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","", "","", partnerController.leadStageStatusDecode(controller.selectStageType.value),partnerController.sourceFilterSendValue(controller.filterTypeSelected.value.toString()),partnerController.leadStatusNameFilter(controller.isTeamLeadEmpSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                      });
                  },
                  child: Row(
                    children: [
                      Container(
                        color: AllColors.blue.withOpacity(0.4),
                        child: Icon(Icons.unfold_more,size: 16.r,color: AllColors.black,),
                      ),
                      SizedBox(width: 8.r),
                      Obx(() => Text(controller.selectStageType.value,style: fontSmall.copyWith(letterSpacing: 0,wordSpacing: 0),)),
                    ],
                  ),
                ),
                SizedBox(width: controller.selectStageType.value=="All Stage"?25.r:15.r),
                if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10"))
                InkWell(
                  onTap: () {
                    showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(Get.width/2.5, Get.width/2.6, Get.width/2, 0), // Adjust the position of the popup menu
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
                      controller.teamLeadsNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value),partnerController.sourceFilterSendValue(controller.filterTypeSelected.value.toString()),partnerController.leadStatusNameFilter(controller.isTeamLeadEmpSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                    });
                  },
                  child:  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(1.r),
                        color: AllColors.blue.withOpacity(0.4),
                        child: Icon(Icons.unfold_more,size: 14.r,color: AllColors.black,),
                      ),
                      SizedBox(width: 6.r),
                      Obx(() => Text(controller.filterTypeSelected.value ,style: fontSmall.copyWith(letterSpacing: 0,wordSpacing: 0),)),
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
                          controller.teamLeadsNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value),partnerController.sourceFilterSendValue(controller.filterTypeSelected.value.toString()),partnerController.leadStatusNameFilter(controller.isTeamLeadEmpSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
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
                SizedBox(width: 20.r),
                Row(
                  children: [
                    InkWell(
                      onTap: () => calender.value=true,
                      child: Icon(
                        Icons.calendar_month_outlined,
                        size: 16.r,color: AllColors.black,
                      ),
                    ),
                    InkWell(
                      onTap: () => calender.value=true,
                      child: Text(
                        DateFormat('yyy-MM-dd').format(selectedDay.value)!=DateFormat('yyy-MM-dd').format(DateTime.now())? DateFormat('MMMM - yyy').format(selectedDay.value).toString() :"All Time",
                        style: fontSmall.copyWith(letterSpacing: 0,wordSpacing: 0),),
                    ),
                    SizedBox(width: 5.r),
                    InkWell(
                      onTap: (){
                        controller.loanType.value="All Loan";
                        controller.customerPan.clear();
                        controller.customerPhone.clear();
                        controller.leadStartDate.clear();
                        controller.leadEndDate.clear();
                        _showBottomSheetFilter(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0.r),
                        child: Icon(
                          Icons.tune,
                          size: 16.r,color: AllColors.black.withOpacity(0.8),
                        ),
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
                    child: Obx(()=> Column(
                      children: [
                        WeeklyDatePicker(
                          selectedDay: selectedDay.value, // DateTime
                          changeDay: (value)async{
                            selectedDay.value = value;
                            monthYear.value = value;
                            await controller.teamLeadsNetworkApi(DateFormat('yyy-MM-dd').format(value).toString(),DateFormat('yyy-MM').format(value),partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","","",controller.filterTypeSelected.value,controller.isTeamLeadEmpSelected.value,partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
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
                            bool status = await controller.teamLeadsNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","","",controller.filterTypeSelected.value,controller.isTeamLeadEmpSelected.value,partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
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
            child: SingleChildScrollView(
              controller: controller.teamLeadsController,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal:10.0.r,vertical: 5.r),
                padding: EdgeInsets.symmetric(horizontal:8.r, vertical: 8.r),
                color: AllColors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// counts list widget
                    Container(
                      height: 60.r,
                      padding: EdgeInsets.symmetric(vertical: 8.r),
                      child: Row(
                        children: [
                          InkWell(
                            child: Icon(
                              Icons.keyboard_arrow_left_rounded,
                              size: 22.r,color:
                            AllColors.black,
                            ),
                          ),
                          Expanded(
                            child: GetBuilder<LoginController>(builder: (controller) {
                                return controller.team_leads_loader.value?
                                ListView.builder(
                                  itemCount: controller.team_leads_model.value.data.counts.length,
                                  // shrinkWrap: true,
                                  reverse: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index){
                                    var data1= controller.team_leads_model.value.data.counts[index];
                                    return Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 25.r, right: 25.r,),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(data1.title??"NA",style: fontSmall.copyWith(),),
                                              Text("${data1.count??0}",style: fontRegular.copyWith(fontSize: 16.r),),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 1.r,
                                          color: AllColors.lightGrey.withOpacity(0.8),
                                        )
                                      ],
                                    );
                                  },
                                ):
                                ListView.builder(
                                  itemCount: 5,
                                  shrinkWrap: true,
                                  reverse: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index){
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical:5.0.r),
                                      child: Row(
                                        children: [
                                          Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor: Colors.grey.shade100,
                                            enabled: true,
                                            child: Container(
                                              width: 90.r,
                                              color: AllColors.white,
                                              margin: EdgeInsets.only(right: 8.r),
                                            ),
                                          ),
                                          Container(
                                            width: 1.r,
                                            color: AllColors.lightGrey.withOpacity(0.8),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          InkWell(
                            child: Icon(
                              Icons.keyboard_arrow_right_rounded,
                              size: 22.r,color:
                            AllColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.r),
                    /// all teams leads data show
                    GetBuilder<LoginController>(builder: (controller){
                      return  controller.team_leads_loader.value?
                      ListView.builder(
                        itemCount: controller.team_leads_model.value.data.teamLead.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 5.r),
                        itemBuilder: (context, index){
                            var teamLeadsData=controller.team_leads_model.value.data.teamLead[index];
                            bool isLastItem = index == controller.team_leads_model.value.data.teamLead.length - 1;
                            return CustomLeadsDetails3(
                              pageName: "teamLead",
                              name: teamLeadsData.custName??"NA",
                              leadId: teamLeadsData.leadId??"",
                              leadTypeName: teamLeadsData.leadSource??"",
                              address: teamLeadsData.custPermanentAddress??"NA",
                              createDate: teamLeadsData.leadDateTime??"NA",
                              image: teamLeadsData.custLoanSelfie.toString(),
                              number: teamLeadsData.custPhone??"",
                              leadLockStatus: teamLeadsData.leadLockStatus??"false",
                              leadStatus: teamLeadsData.leadStatus??"",
                              holdCount: teamLeadsData.holdCount,
                              lockedBy: teamLeadsData.lockedBy??"",
                              leadDateTime: teamLeadsData.leadDateTime??"NA",
                              index: isLastItem,
                              detailsTap: ()async{
                                bool checkStatus = await controller.teamLeadsNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value),partnerController.sourceFilterSendValue(controller.filterTypeSelected.value.toString()),partnerController.leadStatusNameFilter(controller.isTeamLeadEmpSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                if(checkStatus==true){
                                  if(controller.team_leads_model.value.data.teamLead[index].leadLockStatus=="false") {
                                    bool status = await permissionController.lockUnlockLeadNetworkApi(controller.team_leads_model.value.data.teamLead[index].leadId, "true");
                                    if(status==true) {
                                      Get.to(()=> CustomerDetails(leadId: "${teamLeadsData.id??""}",customerId: teamLeadsData.custId??"",value: "leadDetails",apiLeadId: teamLeadsData.leadId,pageName: "teamLead",));
                                      controller.teamLeadsNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value),partnerController.sourceFilterSendValue(controller.filterTypeSelected.value.toString()),partnerController.leadStatusNameFilter(controller.isTeamLeadEmpSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                    }
                                  }else{
                                    BaseController().errorSnack("Already details View on ${controller.team_leads_model.value.data.teamLead[index].lockedBy.toString()}");
                                    controller.teamLeadsNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value),partnerController.sourceFilterSendValue(controller.filterTypeSelected.value.toString()),partnerController.leadStatusNameFilter(controller.isTeamLeadEmpSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                  }
                                }
                              },
                              nameTap: ()=> Get.to(()=> CustomerLoanListDetails(leadId: "${teamLeadsData.id??""}",customerId: teamLeadsData.custId??"", apiLeadId: teamLeadsData.leadId)),
                              transferLeadStatus: teamLeadsData.leadSource.toString()!=GetStorage().read(AppConstant.cust_id)&&GetStorage().read(AppConstant.assignment_change_approval).toString().toLowerCase() == "yes"?true:false,
                              child: Obx(()=> PopupMenuButton(
                                initialValue: selectedMenu.value,
                                onSelected: (value) async {
                                  selectedMenu.value = value.toString();
                                  if(value == "Transfer Lead"){
                                    bool checkStatus = await controller.teamLeadsNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value),partnerController.sourceFilterSendValue(controller.filterTypeSelected.value.toString()),partnerController.leadStatusNameFilter(controller.isTeamLeadEmpSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                    if(checkStatus==true){
                                      if(controller.team_leads_model.value.data.teamLead[index].leadLockStatus=="false") {
                                        bool status = await permissionController.lockUnlockLeadNetworkApi(controller.team_leads_model.value.data.teamLead[index].leadId, "true");
                                        if(status==true) {
                                          Get.to(()=> CustomerDetails(leadId: "${teamLeadsData.id??""}",customerId: teamLeadsData.custId??"",value: "leadDetails",apiLeadId: teamLeadsData.leadId,pageName: "teamLead",leadTransferName: "transferLead",));
                                          controller.teamLeadsNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value),partnerController.sourceFilterSendValue(controller.filterTypeSelected.value.toString()),partnerController.leadStatusNameFilter(controller.isTeamLeadEmpSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                        }
                                      }else{
                                        BaseController().errorSnack("Already details View on ${controller.team_leads_model.value.data.teamLead[index].lockedBy.toString()}");
                                        controller.teamLeadsNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value),partnerController.sourceFilterSendValue(controller.filterTypeSelected.value.toString()),partnerController.leadStatusNameFilter(controller.isTeamLeadEmpSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                      }
                                    }
                                  }else{
                                    bool checkStatus = await controller.teamLeadsNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value),partnerController.sourceFilterSendValue(controller.filterTypeSelected.value.toString()),partnerController.leadStatusNameFilter(controller.isTeamLeadEmpSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                    if(checkStatus==true){
                                      if(controller.team_leads_model.value.data.teamLead[index].leadLockStatus=="false") {
                                        bool status = await permissionController.lockUnlockLeadNetworkApi(controller.team_leads_model.value.data.teamLead[index].leadId, "true");
                                        if(status==true) {
                                          Get.to(()=> CustomerDetails(leadId: "${teamLeadsData.id??""}",customerId: teamLeadsData.custId??"",value: "leadDetails",apiLeadId: teamLeadsData.leadId,pageName: "teamLead",));
                                          controller.teamLeadsNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value),partnerController.sourceFilterSendValue(controller.filterTypeSelected.value.toString()),partnerController.leadStatusNameFilter(controller.isTeamLeadEmpSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                        }
                                      }else{
                                        BaseController().errorSnack("Already details View on ${controller.team_leads_model.value.data.teamLead[index].lockedBy.toString()}");
                                        controller.teamLeadsNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value),partnerController.sourceFilterSendValue(controller.filterTypeSelected.value.toString()),partnerController.leadStatusNameFilter(controller.isTeamLeadEmpSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                      }
                                    }
                                  }
                                },
                                itemBuilder: (BuildContext context) => [
                                  PopupMenuItem(
                                    value: 'Set Follow-up'.tr,
                                    child: Text('Set Follow-up',style: fontMedium.copyWith()),
                                  ),
                                  PopupMenuItem(
                                    value: 'Mark Hot Lead'.tr,
                                    child: Text('Mark Hot Lead',style: fontMedium.copyWith()),
                                  ),
                                  PopupMenuItem(
                                    value: 'Transfer Lead'.tr,
                                    child: Text('Transfer Lead',style: fontMedium.copyWith()),
                                  ),
                                  PopupMenuItem(
                                    value: 'Delete Lead'.tr,
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Delete Lead ',
                                        style: fontMedium.copyWith(),
                                        children: [
                                          TextSpan(text: '(Draft)', style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.5))),
                                        ],
                                      ),
                                    ),
                                    // child: Text('Delete Lead',style: fontMedium.copyWith()),
                                  ),
                                ],
                                icon: Container(
                                  padding: EdgeInsets.all(2.r),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100.r),
                                      border: Border.all(width: 0.5, color: AllColors.grey.withOpacity(0.6))
                                  ),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 16.r,
                                    color: AllColors.black.withOpacity(0.6),
                                  ),
                                ),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(
                                  minHeight: 50.r,
                                ),
                              )),
                            );
                          }) :
                      ListView.builder(
                          itemCount: 10,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(bottom: 5.r),
                          itemBuilder: (context, index){
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 5.0.r),
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
                                            SizedBox(width: 30.r),
                                            Row(
                                              children: [
                                                Shimmer.fromColors(
                                                  baseColor: Colors.grey.shade300,
                                                  highlightColor: Colors.grey.shade100,
                                                  enabled: true,
                                                  child: Container(
                                                    width: 40.r,
                                                    height: 20.r,
                                                    decoration: BoxDecoration(
                                                      color: AllColors.white,
                                                      borderRadius: BorderRadius.circular(100.r),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 8.r),
                                                Shimmer.fromColors(
                                                  baseColor: Colors.grey.shade300,
                                                  highlightColor: Colors.grey.shade100,
                                                  enabled: true,
                                                  child: CircleAvatar(
                                                    radius: 12.r,
                                                    backgroundColor: AllColors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        if(index!=9)
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
                    Obx(() => controller.team_leads_model.value.message.toString()=="Data Not Found."?
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: 10.r),
                          child: Text("Data not found !!",style: fontRegular.copyWith(letterSpacing: 0,color: AllColors.black.withOpacity(0.7)),)
                      ): const SizedBox(),
                    ),
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
                            // controller.teamLeadsNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),controller.customerPan.text,
                            //     controller.customerPhone.text, "", "",controller.selectStageType.value,partnerController.sourceFilterSendValue(controller.filterTypeSelected.value.toString()),controller.isTeamLeadEmpSelected.value);
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

  Widget buildRadioButtonEMP(String title, String value) {
    return Obx(() => Row(
      children: [
        SizedBox(
          height: 35.r,
          width: 40.r,
          child: Radio(
            value: value,
            groupValue: controller.isTeamLeadEmpSelected.value,
            onChanged: (selectedValue) {
              controller.isTeamLeadEmpSelected.value = selectedValue.toString();
              controller.teamLeadsNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value),partnerController.sourceFilterSendValue(controller.filterTypeSelected.value.toString()),partnerController.leadStatusNameFilter(controller.isTeamLeadEmpSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
              print("xnbnx $selectedValue khs ${controller.isTeamLeadEmpSelected.value}");
            },
          ),
        ),
        Text(title),
      ],
    ),
    );
  }
}
