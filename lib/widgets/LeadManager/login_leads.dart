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

class LoginLeads extends StatefulWidget {
  const LoginLeads({super.key});

  @override
  State<LoginLeads> createState() => _LoginLeadsState();
}

class _LoginLeadsState extends State<LoginLeads> {
  var controller = Get.find<LoginController>();
  var permissionController = Get.find<PermissionController>();
  var partnerController = Get.find<PartnerController>();
  RxBool calender=false.obs;
  var selectedDay = DateTime.now().obs;
  var monthYear = DateTime.now().obs;
  var selectedValidation = "All Status".obs;
  var selectedMenu = "Set Follow-up".obs;

  @override
  void initState() {
    controller.allLeadsDataNext = 10;
    controller.loginLeadsNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","","",partnerController.leadStatusNameFilter(controller.leadsPageName.value), partnerController.sourceFilterSendValue(controller.filterTypeSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    controller.leadsPageName.value = "All";
    controller.filterTypeSelected.value ="All Source";
    controller.selectEmployeePartnerValue.value ="All Reports";
    return Scaffold(
      backgroundColor: Colors.lightBlue.withOpacity(0.1),
      body: Obx(()=> Column(
        children: [
          Container(
            height: 45.r,
            padding: EdgeInsets.symmetric(horizontal: 12.r, vertical:10.0.r),
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
                      controller.selectLoanType.value = value??"All Loan";
                      controller.loginLeadsNetworkApi("","","",partnerController.loanTypeDecode(value.toString()),"","","","",partnerController.leadStatusNameFilter(controller.leadsPageName.value), partnerController.sourceFilterSendValue(controller.filterTypeSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
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
                if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10"))
                SizedBox(width: controller.filterTypeSelected.value=="All Source" || controller.filterTypeSelected.value=="Customer"?40.r:15.r),
                if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10"))
                InkWell(
                  onTap: () {
                    showMenu(
                      context: context,
                      position: RelativeRect.fromSize(Rect.fromCircle(center: const Offset(77, 165), radius: 5), const Size(150, 300)),
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
                      controller.loginLeadsNetworkApi("","","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStatusNameFilter(controller.leadsPageName.value), partnerController.sourceFilterSendValue(controller.filterTypeSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
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
                          controller.loginLeadsNetworkApi("","","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStatusNameFilter(controller.leadsPageName.value), partnerController.sourceFilterSendValue(controller.filterTypeSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
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

                SizedBox(width: controller.filterTypeSelected.value=="All Source" || controller.filterTypeSelected.value=="Customer"?40.r:10.r),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        DateFormat('yyy-MM-dd').format(selectedDay.value)!=DateFormat('yyy-MM-dd').format(DateTime.now())? DateFormat('yyyy-MM-dd').format(selectedDay.value).toString() :"All Time",
                        style: fontSmall.copyWith(letterSpacing: 0,wordSpacing: 0),),
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
          Container(
            padding: EdgeInsets.only(left: 5.r,right: 10.r),
            height: 18.r,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                buildRadioButtonEMP("All", "All"),
                SizedBox(width: 15.r),
                buildRadioButtonEMP("Login Validation", "Login Validation"),
                SizedBox(width: 15.r),
                buildRadioButtonEMP("Pending Validation", "Pending Validation"),
                SizedBox(width: 15.r),
                buildRadioButtonEMP("Validated", "Validated"),
                SizedBox(width: 15.r),
                buildRadioButtonEMP("Rejected Validation", "Rejected Validation"),
                SizedBox(width: 15.r),
                buildRadioButtonEMP("Rejected", "Rejected"),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        WeeklyDatePicker(
                          selectedDay: selectedDay.value, // DateTime
                          changeDay: (value)async{
                            selectedDay.value = value;
                            monthYear.value = value;
                            await controller.loginLeadsNetworkApi(DateFormat('yyy-MM-dd').format(value).toString(),DateFormat('yyy-MM').format(value),"",partnerController.loanTypeDecode(value.toString()),"","","","",partnerController.leadStatusNameFilter(controller.leadsPageName.value), partnerController.sourceFilterSendValue(controller.filterTypeSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
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
                            bool status = await controller.loginLeadsNetworkApi("","","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStatusNameFilter(controller.leadsPageName.value), partnerController.sourceFilterSendValue(controller.filterTypeSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
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
              controller: controller.loginLeadController,
              child: Container(
                margin: EdgeInsets.only(left:10.0.r, right: 10.r, bottom: 8.r),
                padding: EdgeInsets.symmetric(horizontal:8.r, vertical: 10.r),
                color: AllColors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GetBuilder<LoginController>(builder: (controller) {
                      return controller.login_leads_loader.value?
                      ListView.builder(
                          itemCount: controller.login_leads_model.value.data.loginLeade.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(bottom: 5.r),
                          itemBuilder: (context, index){
                            var data = controller.login_leads_model.value.data.loginLeade[index];
                            bool isLastItem = index == controller.login_leads_model.value.data.loginLeade.length - 1;
                            return CustomLeadsDetails(
                              name: data.custName??"NA",
                              leadId: data.leadId??"",
                              leadTypeName: data.leadSource??"",
                              address: data.custPermanentAddress??"NA",
                              createDate: data.leadDateTime??"NA",
                              image: data.custLoanSelfie.toString(),
                              number: data.custPhone??"",
                              leadLockStatus: data.leadLockStatus??"",
                              leadStatus: data.leadStatus??"",
                              holdCount: data.holdCount,
                              lockedBy: data.lockedBy??"",
                              index: isLastItem,
                              detailsTap: ()async{
                                bool checkStatus = await controller.loginLeadsNetworkApi("","","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStatusNameFilter(controller.leadsPageName.value), partnerController.sourceFilterSendValue(controller.filterTypeSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                if(checkStatus==true){
                                  if(controller.login_leads_model.value.data.loginLeade[index].leadLockStatus=="false") {
                                    bool status = await permissionController.lockUnlockLeadNetworkApi(controller.login_leads_model.value.data.loginLeade[index].leadId, "true");
                                    if(status==true) {
                                      Get.to(()=> CustomerDetails(leadId: "${data.id??""}",customerId: data.custId??"",value: "leadDetails",apiLeadId: data.leadId, pageName: "loginLead",));
                                      controller.loginLeadsNetworkApi("","","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStatusNameFilter(controller.leadsPageName.value), partnerController.sourceFilterSendValue(controller.filterTypeSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                    }
                                  }else{
                                    BaseController().errorSnack("Already details View on ${controller.login_leads_model.value.data.loginLeade[index].lockedBy.toString()}");
                                    controller.loginLeadsNetworkApi("","","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStatusNameFilter(controller.leadsPageName.value), partnerController.sourceFilterSendValue(controller.filterTypeSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                  }
                                }
                              },
                              nameTap: ()=> Get.to(()=> CustomerLoanListDetails(leadId: "${data.id??""}",customerId: data.custId??"")),
                              transferLeadStatus: data.leadSource.toString()!=GetStorage().read(AppConstant.cust_id)&&GetStorage().read(AppConstant.assignment_change_approval).toString().toLowerCase() == "yes"?true:false,
                              child: Obx(()=> PopupMenuButton(
                                initialValue: selectedMenu.value,
                                onSelected: (value) async {
                                  selectedMenu.value = value.toString();
                                  if(value == "Transfer Lead"){
                                    bool checkStatus = await controller.loginLeadsNetworkApi("","","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStatusNameFilter(controller.leadsPageName.value), partnerController.sourceFilterSendValue(controller.filterTypeSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                    if(checkStatus==true){
                                      if(controller.login_leads_model.value.data.loginLeade[index].leadLockStatus=="false") {
                                        bool status = await permissionController.lockUnlockLeadNetworkApi(controller.login_leads_model.value.data.loginLeade[index].leadId, "true");
                                        if(status==true) {
                                          Get.to(()=> CustomerDetails(leadId: "${data.id??""}",customerId: data.custId??"",value: "leadDetails",apiLeadId: data.leadId, pageName: "loginLead",leadTransferName: "transferLead",));
                                          controller.loginLeadsNetworkApi("","","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStatusNameFilter(controller.leadsPageName.value), partnerController.sourceFilterSendValue(controller.filterTypeSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                        }
                                      }else{
                                        BaseController().errorSnack("Already details View on ${controller.login_leads_model.value.data.loginLeade[index].lockedBy.toString()}");
                                        controller.loginLeadsNetworkApi("","","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStatusNameFilter(controller.leadsPageName.value), partnerController.sourceFilterSendValue(controller.filterTypeSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                      }
                                    }
                                  }else{
                                    bool checkStatus = await controller.loginLeadsNetworkApi("","","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStatusNameFilter(controller.leadsPageName.value), partnerController.sourceFilterSendValue(controller.filterTypeSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                    if(checkStatus==true){
                                      if(controller.login_leads_model.value.data.loginLeade[index].leadLockStatus=="false") {
                                        bool status = await permissionController.lockUnlockLeadNetworkApi(controller.login_leads_model.value.data.loginLeade[index].leadId, "true");
                                        if(status==true) {
                                          Get.to(()=> CustomerDetails(leadId: "${data.id??""}",customerId: data.custId??"",value: "leadDetails",apiLeadId: data.leadId, pageName: "loginLead",));
                                          controller.loginLeadsNetworkApi("","","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStatusNameFilter(controller.leadsPageName.value), partnerController.sourceFilterSendValue(controller.filterTypeSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                        }
                                      }else{
                                        BaseController().errorSnack("Already details View on ${controller.login_leads_model.value.data.loginLeade[index].lockedBy.toString()}");
                                        controller.loginLeadsNetworkApi("","","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStatusNameFilter(controller.leadsPageName.value), partnerController.sourceFilterSendValue(controller.filterTypeSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                                      }
                                    }
                                  }
                                  print("object $value");
                                  // controller.getMyLeadNetworkApi("","",value=="Personal Loan"?"PL":value=="Business Loan"?"BL":value=="Self-Employee Loan"?"SEL":"Pl");
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
                          }):
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
                          }) ;
                    }),
                    Obx(() => controller.login_leads_model.value.message.toString()=="Data Not Found."?
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
  Widget buildRadioButtonEMP(String title, String value) {
    return Obx(() => Row(
      children: [
        SizedBox(
          height: 22.r,
          width: 25.r,
          child: Radio(
            value: value,
            groupValue: controller.leadsPageName.value,
            onChanged: (selectedValue) {
              controller.loginLeadNext = 10;
              controller.leadsPageName.value = selectedValue.toString();
              controller.loginLeadsNetworkApi("","","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStatusNameFilter(controller.leadsPageName.value), partnerController.sourceFilterSendValue(controller.filterTypeSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
            },
          ),
        ),
        SizedBox(width: 4.r),
        Text(title),
      ],
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
                            controller.loginLeadsNetworkApi("","","",controller.customerPan.text, controller.customerPhone.text, controller.leadStartDate.text, controller.leadEndDate.text,"",partnerController.leadStatusNameFilter(controller.leadsPageName.value), partnerController.sourceFilterSendValue(controller.filterTypeSelected.value),partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
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
}
