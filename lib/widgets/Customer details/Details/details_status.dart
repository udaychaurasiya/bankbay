// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, unused_element

import 'dart:io';
import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/controllers/permission_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/edit_text_field.dart';
import 'package:bank_bay/utils_method/underline_dropdown.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/utils_method/uppercase_formate.dart';
import 'package:bank_bay/widgets/Customer%20details/Details/assign_fos.dart';
import 'package:bank_bay/widgets/Customer%20details/Details/assign_tele.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker_widget/flutter_holo_date_picker_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class DetailsStatus extends StatefulWidget {
  final String? leadId;
  final String? apiLeadId;
  final String? leadTransferName;
  final String? pageName;
  const DetailsStatus({super.key, required this.leadId, this.leadTransferName, this.apiLeadId, this.pageName});

  @override
  State<DetailsStatus> createState() => _DetailsStatusState();
}
var controller = Get.find<PartnerController>();
var loginController = Get.find<LoginController>();
var permissionController = Get.find<PermissionController>();
RxInt disbursedTeleFosTab = 1.obs;
RxString findValue = "UID".obs;
class _DetailsStatusState extends State<DetailsStatus> {
  GlobalKey<FormState> formKeyAssignChangeApproval = GlobalKey<FormState>(debugLabel: '_formKeyAssignChangeApproval');
  var formKeyUnassignedRemarks =GlobalKey<FormState>(debugLabel: "_formKeyUnassignedRemarks");
  TextEditingController nextDate = TextEditingController();
  TextEditingController nextTime = TextEditingController();
  TextEditingController remarks = TextEditingController();

  @override
  void initState() {
    checkStatusTransfer();
    nextDate.clear();
    nextTime.clear();
    remarks.clear();
    controller.clearStatusData();
    super.initState();
  }

  checkStatusTransfer()async{
    bool status = await controller.getLeadDetailsNetworkApi(widget.leadId);
    if(status==true){
      if(widget.leadTransferName.toString()=="transferLead"){
        _showDisbursedLeadDetailsBottomSheet(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatusViewData(
              title: "Created on".tr,
              value: "${controller.getLeadDetails.value.data.leadDateTime??"NA"}",
            ),
            StatusViewData(
              title: "Created by".tr,
              value: controller.getLeadDetails.value.data.createdByName??"NA",
              hint: controller.getLeadDetails.value.data.leadSource.toString().isEmpty?"":
              controller.getLeadDetails.value.data.leadSource,
            ),
            StatusViewData(
              title: "Last connect".tr,
              value: controller.getLeadDetails.value.data.lastCallDateTime??"NA",
            ),
            StatusViewData(
              title: "Next Follow-up".tr,
              value: controller.getLeadDetails.value.data.nextFollowupDate??"NA",
            ),
            // if(controller.getLeadDetails.value.data.leadSource.toString()!=GetStorage().read(AppConstant.cust_id)&&GetStorage().read(AppConstant.assignment_change_approval).toString().toLowerCase() == "yes")
              if(controller.getLeadDetails.value.data.leadStatus=="unassigned"
                  || controller.getLeadDetails.value.data.leadStatus=="assigned"
                  || controller.getLeadDetails.value.data.leadStatus=="hold"
                  || controller.getLeadDetails.value.data.leadStatus=="new"
                  || controller.getLeadDetails.value.data.leadStatus=="verified"
                  || controller.getLeadDetails.value.data.leadStatus=="login"
                  || controller.getLeadDetails.value.data.leadStatus=="sanctioned"
                  || controller.getLeadDetails.value.data.leadStatus=="Inc Due"
                  || controller.leadPageNameDecode(loginController.leadsPageName.value)=="rejectedValidationLeads"
                  || controller.leadPageNameDecode(loginController.leadsPageName.value)=="incentiveValidationLeads"
                  || widget.pageName=="loginLead"
                  || widget.pageName=="sanctionedLead"
                  || widget.pageName=="disbursedLead"
                  || widget.pageName=="incentiveLead"
                  || widget.pageName=="incApprovalLead"
                  || widget.pageName=="incPaidLead")
              Padding(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(controller.getLeadDetails.value.data.leadStatus!="unassigned")
                    SizedBox(height: 10.r),
                    if(controller.getLeadDetails.value.data.leadStatus!="unassigned")
                    Text("Set next follow-up", style: fontSmall.copyWith(fontWeight: FontWeight.w600,color: AllColors.black.withOpacity(0.8))),
                    if(controller.getLeadDetails.value.data.leadStatus!="unassigned")
                    SizedBox(height: 10.r),
                    if(controller.getLeadDetails.value.data.leadStatus!="unassigned")
                    Row(
                      children: [
                        Expanded(
                          child: OutlineTextField(
                            hint: "Select Date",
                            controller: nextDate,
                            icon: true,
                            isRead: true,
                            onTap: () async {
                              var datePicked = await DatePicker.showSimpleDatePicker(
                                context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030),
                                dateFormat: "yyyy-MM-dd",
                                locale: DateTimePickerLocale.en_us,
                                looping: true,
                              );
                              nextDate.text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString()));
                            },
                          ),
                        ),
                        SizedBox(width: 10.r),
                        Expanded(
                          child: OutlineTextField(
                            hint: "Select Time",
                            controller: nextTime,
                            icon: true,
                            isRead: true,
                            onTap: () async {
                              var date = DateTime.now();
                              final TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(date),
                              );
                              if (picked != null) {
                                final DateTime selectedDateTime = DateTime(
                                  date.year,
                                  date.month,
                                  date.day,
                                  picked.hour,
                                  picked.minute,
                                );
                                if (selectedDateTime.isAfter(DateTime.now())) {
                                  date = selectedDateTime;
                                  nextTime.text = DateFormat("Hms").format(selectedDateTime);
                                } else {
                                  BaseController().errorSnack("Please select a future time");
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.r),
                    InkWell(
                      onTap: ()=> _showDisbursedLeadDetailsBottomSheet(context),
                      child: RichText(
                        text: TextSpan(
                          text: "Notes",
                          style: fontSmall.copyWith(fontWeight: FontWeight.w600,color: AllColors.black.withOpacity(0.8)),
                          children: [
                            TextSpan(text: " *", style: fontSmall.copyWith(color: AllColors.red)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.r),
                    Form(
                      key: formKeyUnassignedRemarks,
                      child: OutlineTextField(
                        hint: "Remarks here...",
                        controller: remarks,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter remarks';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20.r),
                    CustomButton(
                      title: "Update Remarks".tr,
                      background: false,
                      bgColor: AllColors.green,
                      height: 38.r,
                      onTap: () async {
                        if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                          bool status = await controller.updateLeadStatusNetworkApi2(
                              controller.getLeadDetails.value.data.leadId.toString(),nextDate.text,
                              nextTime.text,remarks.text,controller.getLeadDetails.value.data.custId,"");
                          if(status==true){
                            controller.getLeadDetailsNetworkApi(widget.leadId);
                            controller.getLeadDetails.refresh();
                              nextDate.clear();
                              nextTime.clear();
                              remarks.clear();
                              controller.rejectedStatusList.clear();
                              controller.clearStatusData();
                          }
                        }
                      },
                    ),
                    SizedBox(height: 10.r),
                    if(controller.getLeadDetails.value.data.leadSource.toString()!=GetStorage().read(AppConstant.cust_id).toString())
                      if(loginController.leadsPageName.value!="Rejected" && loginController.leadsPageName.value!="Validated")
                      Column(
                      children: [
                        if(controller.getLeadDetails.value.data.leadStatus=="unassigned" ||
                            controller.getLeadDetails.value.data.leadStatus=="assigned" ||
                            controller.getLeadDetails.value.data.leadStatus=="hold" ||
                            controller.getLeadDetails.value.data.leadStatus=="verified" ||
                            controller.getLeadDetails.value.data.leadStatus=="new" ||
                            controller.getLeadDetails.value.data.leadStatus=="login" ||
                            controller.getLeadDetails.value.data.leadStatus=="sanctioned" ||
                            controller.getLeadDetails.value.data.leadStatus=="Inc Due" ||
                            controller.getLeadDetails.value.data.leadStatus=="inc approval" ||
                            controller.leadPageNameDecode(loginController.leadsPageName.value)=="rejectedValidationLeads" ||
                            controller.leadPageNameDecode(loginController.leadsPageName.value)=="incentiveValidationLeads" ||
                            widget.pageName=="loginLead" ||
                            widget.pageName=="sanctionedLead" ||
                            widget.pageName=="disbursedLead" ||
                            widget.pageName=="incApproval")
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.r),
                            child: Row(
                              children: [
                                Expanded(child: Divider(thickness: 0.8,color: AllColors.grey.withOpacity(0.5),height: 1.r)),
                                SizedBox(width: 8.r),
                                Text("Stage Movement", style: fontBold.copyWith(),),
                                SizedBox(width: 8.r),
                                Expanded(child: Divider(thickness: 0.8,color: AllColors.grey.withOpacity(0.5),height: 1.r)),
                              ],
                            ),
                          ),
                        SizedBox(height: 10.r),
                        if(controller.getLeadDetails.value.data.leadStatus=="unassigned")
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  title: "Transfer".tr,
                                  background: false,
                                  bgColor: AllColors.themeColor,
                                  height: 38.r,
                                  onTap: (){
                                    controller.employeeId.clear();
                                    controller.check_assign_approval_exist_model.value.data.clear();
                                    controller.approvalReason.clear();
                                    if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                      _showDisbursedLeadDetailsBottomSheet(context);
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 15.r),
                              Expanded(
                                child: CustomButton(
                                  title: "Reject".tr,
                                  background: false,
                                  bgColor: controller.getLeadDetails.value.data.validateStatus=="rejected"?AllColors.lightGrey:AllColors.red.withOpacity(0.7),
                                  textColor: controller.getLeadDetails.value.data.validateStatus=="rejected"?AllColors.grey:null,
                                  height: 38.r,
                                  width: Get.width/2,
                                  onTap: (){
                                    controller.isCheckedList.clear();
                                    controller.isCheckedList.assignAll(List<bool>.filled(controller.rejectItemList.length, false));
                                    if(controller.getLeadDetails.value.data.validateStatus=="rejected"){}
                                    else{
                                      if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                        _showBottomSheet(context, "Rejected");
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        if(controller.getLeadDetails.value.data.leadStatus=="unassigned")
                          SizedBox(height: 20.r),
                        if(controller.getLeadDetails.value.data.leadStatus=="unassigned")
                          if(controller.getLeadDetails.value.data.validateStatus!=null&&controller.getLeadDetails.value.data.validateStatus!="")
                            (controller.getLeadDetails.value.data.rejectedHistory.updatedBy == GetStorage().read(AppConstant.cust_id).toString())?
                            const SizedBox() :
                            Center(
                              child: CustomButton(
                                title: "Validate".tr,
                                background: false,
                                bgColor: AllColors.blue.withOpacity(0.9),
                                height: 38.r,
                                width: Get.width/2,
                                onTap: () async {
                                  if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                    bool status = await controller.validateLeadsStatusNetworkApi(controller.getLeadDetails.value.data.leadId, remarks.text);
                                    if(status==true){
                                      _sendScreen();
                                      loginController.allLeadsDataNetworkApi("","","","","","","",loginController.leadsPageName.value,loginController.filterTypeSelected.value,controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value));
                                    }
                                  }
                                },
                              ),
                            ),
                        if(controller.getLeadDetails.value.data.leadStatus=="assigned")
                          Center(
                            child: CustomButton(
                              title: "Submit for Verification".tr,
                              background: false,
                              bgColor: controller.getLeadDetails.value.data.validateStatus=="verified"?AllColors.lightGrey:AllColors.green,
                              textColor: controller.getLeadDetails.value.data.validateStatus=="verified"?AllColors.grey:null,
                              height: 38.r,
                              width: Get.width/1.5,
                              onTap: () async {
                                if(controller.getLeadDetails.value.data.validateStatus=="verified"){}
                                else{
                                  if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                    _showBottomSheet(context, "Verified");
                                  }
                                }
                              },
                            ),
                          ),
                        if(controller.getLeadDetails.value.data.leadStatus=="assigned")
                          SizedBox(height: 20.r),
                        if(controller.getLeadDetails.value.data.leadStatus=="assigned")
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  title: "Save as Draft".tr,
                                  background: false,
                                  bgColor: controller.getLeadDetails.value.data.validateStatus=="draft"?AllColors.lightGrey:AllColors.orange.withOpacity(0.8),
                                  textColor: controller.getLeadDetails.value.data.validateStatus=="draft"?AllColors.grey:null,
                                  height: 38.r,
                                  onTap: () async {
                                    if(controller.getLeadDetails.value.data.validateStatus=="draft") {}
                                    else{
                                      if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                        bool status = await controller.updateLeadStatusNetworkApi2(
                                            controller.getLeadDetails.value.data.leadId.toString(),nextDate.text,
                                            nextTime.text,remarks.text,controller.getLeadDetails.value.data.custId,"Draft");
                                        if(status==true){
                                          nextDate.clear();
                                          nextTime.clear();
                                          remarks.clear();
                                          controller.rejectedStatusList.clear();
                                          controller.clearStatusData();
                                          _sendScreen();
                                        }
                                      }
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 15.r),
                              Expanded(
                                child: CustomButton(
                                  title: "Reject".tr,
                                  background: false,
                                  bgColor: controller.getLeadDetails.value.data.validateStatus=="rejected"?AllColors.lightGrey:AllColors.red.withOpacity(0.7),
                                  textColor: controller.getLeadDetails.value.data.validateStatus=="rejected"?AllColors.grey:null,
                                  height: 38.r,
                                  width: Get.width/2,
                                  onTap: (){
                                    controller.isCheckedList.clear();
                                    controller.isCheckedList.assignAll(List<bool>.filled(controller.rejectItemList.length, false));
                                    if(controller.getLeadDetails.value.data.validateStatus=="rejected"){}
                                    else{
                                      if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                        _showBottomSheet(context, "Rejected");
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        if(controller.getLeadDetails.value.data.leadStatus=="assigned")
                          SizedBox(height: 20.r),
                        if(controller.getLeadDetails.value.data.leadStatus=="assigned")
                          if(controller.getLeadDetails.value.data.validateStatus!=null&&controller.getLeadDetails.value.data.validateStatus!="")
                            if(controller.getLeadDetails.value.data.rejectedHistory.updatedBy.toString().isNotEmpty||controller.getLeadDetails.value.data.verifiedHistory.updatedBy.toString().isNotEmpty)
                              (controller.getLeadDetails.value.data.rejectedHistory.updatedBy == GetStorage().read(AppConstant.cust_id).toString()||
                                  controller.getLeadDetails.value.data.verifiedHistory.updatedBy == GetStorage().read(AppConstant.cust_id).toString())?
                              const SizedBox() :
                              Center(
                                child: CustomButton(
                                  title: "Validate".tr,
                                  background: false,
                                  bgColor: AllColors.blue.withOpacity(0.9),
                                  height: 38.r,
                                  width: Get.width/2,
                                  onTap: () async {
                                    if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                      bool status = await controller.validateLeadsStatusNetworkApi(controller.getLeadDetails.value.data.leadId, remarks.text);
                                      if(status==true){
                                        _sendScreen();
                                      }
                                    }
                                  },
                                ),
                              ),
                        if(controller.getLeadDetails.value.data.leadStatus=="new")
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  title: "Verified".tr,
                                  background: false,
                                  bgColor: controller.getLeadDetails.value.data.validateStatus=="verified"?AllColors.lightGrey:AllColors.green,
                                  textColor: controller.getLeadDetails.value.data.validateStatus=="verified"?AllColors.grey:null,
                                  height: 38.r,
                                  onTap: (){
                                    if(controller.getLeadDetails.value.data.validateStatus=="verified"){}
                                    else{
                                      if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                        _showBottomSheet(context, "Verified");
                                      }
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 15.r),
                              Expanded(
                                child: CustomButton(
                                  title: "Reject".tr,
                                  background: false,
                                  bgColor: controller.getLeadDetails.value.data.validateStatus=="rejected"?AllColors.lightGrey:AllColors.red.withOpacity(0.7),
                                  textColor: controller.getLeadDetails.value.data.validateStatus=="rejected"?AllColors.grey:null,
                                  height: 38.r,
                                  width: Get.width/2,
                                  onTap: (){
                                    controller.isCheckedList.clear();
                                    controller.isCheckedList.assignAll(List<bool>.filled(controller.rejectItemList.length, false));
                                    if(controller.getLeadDetails.value.data.validateStatus=="rejected"){}
                                    else{
                                      if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                        _showBottomSheet(context, "Rejected");
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        if(controller.getLeadDetails.value.data.leadStatus=="new")
                          SizedBox(height: 20.r),
                        if(controller.getLeadDetails.value.data.leadStatus=="new")
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  title: "Hold".tr,
                                  background: false,
                                  bgColor: controller.getLeadDetails.value.data.validateStatus=="hold"?AllColors.lightGrey:AllColors.orange.withOpacity(0.8),
                                  textColor: controller.getLeadDetails.value.data.validateStatus=="hold"?AllColors.grey:null,
                                  height: 38.r,
                                  onTap: (){
                                    if(controller.getLeadDetails.value.data.validateStatus=="hold"){}
                                    else{
                                      if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                        _showBottomSheet(context, "Hold");
                                      }
                                    }
                                  },
                                ),
                              ),
                              if(controller.getLeadDetails.value.data.validateStatus!=null&&controller.getLeadDetails.value.data.validateStatus!="")
                                (controller.getLeadDetails.value.data.verifiedHistory.updatedBy == GetStorage().read(AppConstant.cust_id).toString()||
                                    controller.getLeadDetails.value.data.rejectedHistory.updatedBy == GetStorage().read(AppConstant.cust_id).toString()||
                                    controller.getLeadDetails.value.data.holdHistory.updatedBy == GetStorage().read(AppConstant.cust_id).toString()) ?
                                const SizedBox() : SizedBox(width: 15.r),
                              if(controller.getLeadDetails.value.data.validateStatus!=null&&controller.getLeadDetails.value.data.validateStatus!="")
                                (controller.getLeadDetails.value.data.verifiedHistory.updatedBy == GetStorage().read(AppConstant.cust_id).toString()||
                                    controller.getLeadDetails.value.data.rejectedHistory.updatedBy == GetStorage().read(AppConstant.cust_id).toString()||
                                    controller.getLeadDetails.value.data.holdHistory.updatedBy == GetStorage().read(AppConstant.cust_id).toString()) ?
                                const SizedBox() :
                                Expanded(
                                  child: CustomButton(
                                    title: "Validated".tr,
                                    background: false,
                                    bgColor: AllColors.themeColor,
                                    height: 38.r,
                                    width: Get.width/2,
                                    onTap: () async {
                                      if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                        bool status = await controller.validateLeadsStatusNetworkApi(controller.getLeadDetails.value.data.leadId, remarks.text);
                                        if(status==true){
                                          _sendScreen();
                                        }
                                      }
                                    },
                                  ),
                                ),
                            ],
                          ),
                        if(controller.getLeadDetails.value.data.leadStatus=="hold")
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  title: "Submit for Verified".tr,
                                  background: false,
                                  bgColor: controller.getLeadDetails.value.data.validateStatus=="verified"?AllColors.lightGrey:AllColors.green,
                                  textColor: controller.getLeadDetails.value.data.validateStatus=="verified"?AllColors.grey:null,
                                  height: 38.r,
                                  onTap: (){
                                    if(controller.getLeadDetails.value.data.validateStatus=="verified"){}
                                    else{
                                      if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                        _showBottomSheet(context, "Verified");
                                      }
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 10.r),
                              Expanded(
                                child: CustomButton(
                                  title: "Reject".tr,
                                  background: false,
                                  bgColor: controller.getLeadDetails.value.data.validateStatus=="rejected"?AllColors.lightGrey:AllColors.red.withOpacity(0.7),
                                  textColor: controller.getLeadDetails.value.data.validateStatus=="rejected"?AllColors.grey:null,
                                  height: 38.r,
                                  width: Get.width/2,
                                  onTap: (){
                                    controller.isCheckedList.clear();
                                    controller.isCheckedList.assignAll(List<bool>.filled(controller.rejectItemList.length, false));
                                    if(controller.getLeadDetails.value.data.validateStatus=="rejected"){}
                                    else{
                                      if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                        _showBottomSheet(context, "Rejected");
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        if(controller.getLeadDetails.value.data.leadStatus=="hold")
                          SizedBox(height: 20.r),
                        if(controller.getLeadDetails.value.data.leadStatus=="hold")
                          if(controller.getLeadDetails.value.data.validateStatus!=null&&controller.getLeadDetails.value.data.validateStatus!="")
                            (controller.getLeadDetails.value.data.verifiedHistory.updatedBy == GetStorage().read(AppConstant.cust_id).toString()||
                                controller.getLeadDetails.value.data.rejectedHistory.updatedBy == GetStorage().read(AppConstant.cust_id).toString())?
                            const SizedBox() :
                            Center(
                              child: CustomButton(
                                title: "Validated".tr,
                                background: false,
                                bgColor: AllColors.themeColor,
                                height: 38.r,
                                width: Get.width/2,
                                onTap: () async {
                                  if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                    bool status = await controller.validateLeadsStatusNetworkApi(controller.getLeadDetails.value.data.leadId, remarks.text);
                                    if(status==true){
                                      _sendScreen();
                                    }
                                  }
                                },
                              ),
                            ),
                        if(controller.getLeadDetails.value.data.leadStatus=="verified")
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  title: "Login".tr,
                                  background: false,
                                  bgColor: controller.getLeadDetails.value.data.validateStatus=="login"?AllColors.lightGrey:AllColors.green,
                                  textColor: controller.getLeadDetails.value.data.validateStatus=="login"?AllColors.grey:null,
                                  height: 38.r,
                                  width: Get.width/2,
                                  onTap: (){
                                    if(controller.getLeadDetails.value.data.validateStatus=="login"){}else{
                                      if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                        _showBottomSheet(context, "Login");
                                      }
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 15.r),
                              Expanded(
                                child: CustomButton(
                                  title: "Reject".tr,
                                  background: false,
                                  bgColor: controller.getLeadDetails.value.data.validateStatus=="rejected"?AllColors.lightGrey:AllColors.red.withOpacity(0.7),
                                  textColor: controller.getLeadDetails.value.data.validateStatus=="rejected"?AllColors.grey:null,
                                  height: 38.r,
                                  width: Get.width/2,
                                  onTap: (){
                                    controller.isCheckedList.clear();
                                    controller.isCheckedList.assignAll(List<bool>.filled(controller.rejectItemList.length, false));
                                    if(controller.getLeadDetails.value.data.validateStatus=="rejected"){}else{
                                      if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                        _showBottomSheet(context, "Rejected");
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        if(controller.getLeadDetails.value.data.leadStatus=="verified")
                          SizedBox(height: 20.r),
                        if(controller.getLeadDetails.value.data.leadStatus=="verified")
                          if(controller.getLeadDetails.value.data.validateStatus!=null&&controller.getLeadDetails.value.data.validateStatus!="")
                            (controller.getLeadDetails.value.data.loginHistory.updatedBy.toString() == GetStorage().read(AppConstant.cust_id).toString()||
                                controller.getLeadDetails.value.data.rejectedHistory.updatedBy.toString() == GetStorage().read(AppConstant.cust_id).toString())?
                            const SizedBox() :
                            Center(
                              child: CustomButton(
                                title: "Validated".tr,
                                background: false,
                                bgColor: AllColors.themeColor,
                                height: 38.r,
                                width: Get.width/2,
                                onTap: () async {
                                  if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                    bool status = await controller.validateLeadsStatusNetworkApi(controller.getLeadDetails.value.data.leadId, remarks.text);
                                    if(status==true){
                                      _sendScreen();
                                    }
                                  }
                                },
                              ),
                            ),
                        if(controller.getLeadDetails.value.data.leadStatus=="login")
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  title: "Sanctioned".tr,
                                  background: false,
                                  bgColor: controller.getLeadDetails.value.data.validateStatus=="sanctioned"?AllColors.lightGrey:AllColors.green,
                                  textColor: controller.getLeadDetails.value.data.validateStatus=="sanctioned"?AllColors.grey:null,
                                  height: 38.r,
                                  width: Get.width/2,
                                  onTap: (){
                                    if(controller.getLeadDetails.value.data.validateStatus=="sanctioned"){}else{
                                      if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                        _showBottomSheet(context, "Sanctioned");
                                      }
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 15.r),
                              Expanded(
                                child: CustomButton(
                                  title: "Reject".tr,
                                  background: false,
                                  bgColor: controller.getLeadDetails.value.data.validateStatus=="rejected"?AllColors.lightGrey:AllColors.red.withOpacity(0.7),
                                  textColor: controller.getLeadDetails.value.data.validateStatus=="rejected"?AllColors.grey:null,
                                  height: 38.r,
                                  width: Get.width/2,
                                  onTap: (){
                                    controller.isCheckedList.clear();
                                    controller.isCheckedList.assignAll(List<bool>.filled(controller.rejectItemList.length, false));
                                    if(controller.getLeadDetails.value.data.validateStatus=="rejected"){}else{
                                      if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                        _showBottomSheet(context, "Rejected");
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        if(controller.getLeadDetails.value.data.leadStatus=="login")
                          SizedBox(height: 20.r),
                        if(controller.getLeadDetails.value.data.leadStatus=="login")
                          if(controller.getLeadDetails.value.data.validateStatus!=null&&controller.getLeadDetails.value.data.validateStatus!="")
                            (controller.getLeadDetails.value.data.sanctionedHistory.updatedBy == GetStorage().read(AppConstant.cust_id).toString()||
                                controller.getLeadDetails.value.data.rejectedHistory.updatedBy == GetStorage().read(AppConstant.cust_id).toString()) ?
                            const SizedBox() :
                            Center(
                              child: CustomButton(
                                title: "Validated".tr,
                                background: false,
                                bgColor: AllColors.themeColor,
                                height: 38.r,
                                width: Get.width/2,
                                onTap: () async {
                                  if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                    bool status = await controller.validateLeadsStatusNetworkApi(controller.getLeadDetails.value.data.leadId, remarks.text);
                                    if(status==true){
                                      _sendScreen();
                                    }
                                  }
                                },
                              ),
                            ),
                        if(controller.getLeadDetails.value.data.leadStatus=="sanctioned")
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  title: "Disbursed".tr,
                                  background: false,
                                  bgColor: controller.getLeadDetails.value.data.validateStatus=="Inc Due"?AllColors.lightGrey:AllColors.green,
                                  textColor: controller.getLeadDetails.value.data.validateStatus=="Inc Due"?AllColors.grey:null,
                                  height: 38.r,
                                  width: Get.width/2,
                                  onTap: (){
                                    if(controller.getLeadDetails.value.data.validateStatus=="Inc Due"){}else{
                                      if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                        _showBottomSheet(context, "Disbursed");
                                      }
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 15.r),
                              Expanded(
                                child: CustomButton(
                                  title: "Reject".tr,
                                  background: false,
                                  bgColor: controller.getLeadDetails.value.data.validateStatus=="rejected"?AllColors.lightGrey:AllColors.red.withOpacity(0.7),
                                  textColor: controller.getLeadDetails.value.data.validateStatus=="rejected"?AllColors.grey:null,
                                  height: 38.r,
                                  width: Get.width/2,
                                  onTap: (){
                                    controller.isCheckedList.clear();
                                    controller.isCheckedList.assignAll(List<bool>.filled(controller.rejectItemList.length, false));
                                    if(controller.getLeadDetails.value.data.validateStatus=="rejected"){}else{
                                      if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                        _showBottomSheet(context, "Rejected");
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        if(controller.getLeadDetails.value.data.leadStatus=="sanctioned")
                          SizedBox(height: 20.r),
                        if(controller.getLeadDetails.value.data.leadStatus=="sanctioned")
                          if(controller.getLeadDetails.value.data.validateStatus!=null&&controller.getLeadDetails.value.data.validateStatus!="")
                            (controller.getLeadDetails.value.data.incDueHistory.updatedBy == GetStorage().read(AppConstant.cust_id).toString()||
                                controller.getLeadDetails.value.data.rejectedHistory.updatedBy == GetStorage().read(AppConstant.cust_id).toString())?
                            const SizedBox() :
                            Center(
                              child: CustomButton(
                                title: "Validated".tr,
                                background: false,
                                bgColor: AllColors.themeColor,
                                height: 38.r,
                                width: Get.width/2,
                                onTap: () async {
                                  if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                    bool status = await controller.validateLeadsStatusNetworkApi(controller.getLeadDetails.value.data.leadId, remarks.text);
                                    if(status==true){
                                      _sendScreen();
                                    }
                                  }
                                },
                              ),
                            ),
                        if(controller.getLeadDetails.value.data.leadStatus=="Inc Due")
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  title: "Inc Verified".tr,
                                  background: false,
                                  bgColor: controller.getLeadDetails.value.data.validateStatus=="Inc Approval"?AllColors.lightGrey:AllColors.green,
                                  textColor: controller.getLeadDetails.value.data.validateStatus=="Inc Approval"?AllColors.grey:null,
                                  height: 38.r,
                                  width: Get.width/2,
                                  onTap: () async {
                                    if(controller.getLeadDetails.value.data.validateStatus=="Inc Approval") {}
                                    else{
                                      if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                        bool status = await controller.updateLeadStatusNetworkApi2(
                                            controller.getLeadDetails.value.data.leadId.toString(),nextDate.text,
                                            nextTime.text,remarks.text,controller.getLeadDetails.value.data.custId,"Inc Approval");
                                        if(status==true){
                                          // permissionController.lockUnlockLeadNetworkApi(widget.apiLeadId, "false");
                                          nextDate.clear();
                                          nextTime.clear();
                                          remarks.clear();
                                          controller.rejectedStatusList.clear();
                                          controller.clearStatusData();
                                          _sendScreen();
                                        }
                                      }
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 15.r),
                              Expanded(
                                child: CustomButton(
                                  title: "Reject".tr,
                                  background: false,
                                  bgColor: controller.getLeadDetails.value.data.validateStatus=="rejected"?AllColors.lightGrey:AllColors.red.withOpacity(0.7),
                                  textColor: controller.getLeadDetails.value.data.validateStatus=="rejected"?AllColors.grey:null,
                                  height: 38.r,
                                  width: Get.width/2,
                                  onTap: (){
                                    controller.isCheckedList.clear();
                                    controller.isCheckedList.assignAll(List<bool>.filled(controller.rejectItemList.length, false));
                                    if(controller.getLeadDetails.value.data.validateStatus=="rejected"){}else{
                                      if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                        _showBottomSheet(context, "Rejected");
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        if(controller.getLeadDetails.value.data.leadStatus=="Inc Due")
                          SizedBox(height: 20.r),
                        if(controller.getLeadDetails.value.data.leadStatus=="Inc Due")
                          if(controller.getLeadDetails.value.data.validateStatus!=null&&controller.getLeadDetails.value.data.validateStatus!="")
                            (controller.getLeadDetails.value.data.incApproveHistory.updatedBy == GetStorage().read(AppConstant.cust_id).toString()||
                                controller.getLeadDetails.value.data.rejectedHistory.updatedBy == GetStorage().read(AppConstant.cust_id).toString())?
                            const SizedBox() :
                            Center(
                              child: CustomButton(
                                title: "Validated".tr,
                                background: false,
                                bgColor: AllColors.themeColor,
                                height: 38.r,
                                width: Get.width/2,
                                onTap: () async {
                                  if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                    bool status = await controller.validateLeadsStatusNetworkApi(controller.getLeadDetails.value.data.leadId, remarks.text);
                                    if(status==true){
                                      nextDate.clear();
                                      nextTime.clear();
                                      remarks.clear();
                                      controller.rejectedStatusList.clear();
                                      controller.clearStatusData();
                                      _sendScreen();
                                    }
                                  }
                                },
                              ),
                            ),
                        if(controller.getLeadDetails.value.data.leadStatus=="Inc Approval")
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  title: "Inc Approval".tr,
                                  background: false,
                                  bgColor: controller.getLeadDetails.value.data.validateStatus=="Inc Paid"?AllColors.lightGrey:AllColors.green,
                                  textColor: controller.getLeadDetails.value.data.validateStatus=="Inc Paid"?AllColors.grey:null,
                                  height: 38.r,
                                  width: Get.width/2,
                                  onTap: () async {
                                    if(controller.getLeadDetails.value.data.validateStatus=="Inc Paid") {}
                                    else{
                                      if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                        // bool status = await controller.updateLeadStatusNetworkApi2(
                                        //     controller.getLeadDetails.value.data.leadId.toString(),nextDate.text,
                                        //     nextTime.text,remarks.text,controller.getLeadDetails.value.data.custId,"Inc Paid");
                                        // if(status==true){
                                        //   permissionController.lockUnlockLeadNetworkApi(widget.apiLeadId, "false");
                                        //   nextDate.clear();
                                        //   nextTime.clear();
                                        //   remarks.clear();
                                        //   controller.rejectedStatusList.clear();
                                        //   controller.clearStatusData();
                                        //   _sendScreen();
                                        // }
                                        print("update Inc Due Network Api");
                                        bool status = await controller.updateIncDueNetworkApi(
                                          controller.getLeadDetails.value.data.leadId??"",
                                          "Approve",
                                          nextDate.text,
                                          remarks.text,controller.getLeadDetails.value.data.custId??"",
                                        );
                                        // bool status = await controller.validateLeadsStatusNetworkApi(controller.getLeadDetails.value.data.leadId, remarks.text);
                                        if(status==true){
                                          nextDate.clear();
                                          nextTime.clear();
                                          remarks.clear();
                                          controller.rejectedStatusList.clear();
                                          controller.clearStatusData();
                                          _sendScreen();
                                        }
                                      }
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 15.r),
                              Expanded(
                                child: CustomButton(
                                  title: "Reject".tr,
                                  background: false,
                                  bgColor: controller.getLeadDetails.value.data.validateStatus=="rejected"?AllColors.lightGrey:AllColors.red.withOpacity(0.7),
                                  textColor: controller.getLeadDetails.value.data.validateStatus=="rejected"?AllColors.grey:null,
                                  height: 38.r,
                                  width: Get.width/2,
                                  onTap: (){
                                    controller.isCheckedList.clear();
                                    controller.isCheckedList.assignAll(List<bool>.filled(controller.rejectItemList.length, false));
                                    if(controller.getLeadDetails.value.data.validateStatus=="rejected"){}else{
                                      if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                        _showBottomSheet(context, "Rejected");
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        if(controller.getLeadDetails.value.data.leadStatus=="Inc Approval")
                          SizedBox(height: 20.r),
                        if(controller.getLeadDetails.value.data.leadStatus=="Inc Approval")
                          if(controller.getLeadDetails.value.data.validateStatus!=null&&controller.getLeadDetails.value.data.validateStatus!="")
                            (controller.getLeadDetails.value.data.incPaidHistory.updatedBy == GetStorage().read(AppConstant.cust_id).toString()||
                                controller.getLeadDetails.value.data.rejectedHistory.updatedBy == GetStorage().read(AppConstant.cust_id).toString())?
                            const SizedBox() :
                            Center(
                              child: CustomButton(
                                title: "Validated".tr,
                                background: false,
                                bgColor: AllColors.themeColor,
                                height: 38.r,
                                width: Get.width/2,
                                onTap: () async {
                                  if (formKeyUnassignedRemarks.currentState != null && formKeyUnassignedRemarks.currentState!.validate()){
                                    bool status = await controller.updateIncDueNetworkApi(
                                      controller.getLeadDetails.value.data.leadId??"",
                                      "Approve",
                                      nextDate.text,
                                      remarks.text,controller.getLeadDetails.value.data.custId??"",
                                    );
                                    // bool status = await controller.validateLeadsStatusNetworkApi(controller.getLeadDetails.value.data.leadId, remarks.text);
                                    if(status==true){
                                      nextDate.clear();
                                      nextTime.clear();
                                      remarks.clear();
                                      controller.rejectedStatusList.clear();
                                      controller.clearStatusData();
                                      _sendScreen();
                                    }
                                  }
                                },
                              ),
                            ),
                      ],
                    ),
                  ],
                ),
              ),
            SizedBox(height: 10.r),
          ],
        ),
      ),
    );
  }

  _sendScreen(){
    permissionController.lockUnlockLeadNetworkApi(widget.apiLeadId, "false");
    switch (widget.pageName) {
      case "myLead":
        Get.back(
            result: {
              loginController.freshLeadNetworkApi(),
              loginController.getMyLeadNetworkApi("","",controller.loanTypeDecode(loginController.selectLoanType.value),"","","","",controller.leadStageStatusDecode(loginController.selectStageType.value)),
              loginController.fresh_lead_model.refresh(),
              loginController.get_my_lead_model.refresh(),
              controller.getLeadDetailsNetworkApi(widget.leadId),
              controller.getLeadDetails.refresh(),
              Navigator.of(context).pop(),
            }
        );
        break;
      case "teamLead":
        Get.back(
            result: {
              loginController.teamLeadsNetworkApi("","",controller.loanTypeDecode(loginController.selectLoanType.value),"","","","",controller.leadStageStatusDecode(loginController.selectStageType.value),controller.sourceFilterSendValue(loginController.filterTypeSelected.value.toString()),controller.leadStatusNameFilter(loginController.isTeamLeadEmpSelected.value),controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value)),
              loginController.team_leads_model.refresh(),
              controller.getLeadDetailsNetworkApi(widget.leadId),
              controller.getLeadDetails.refresh(),
              Navigator.of(context).pop(),
            }
        );
        break;
      case "newLead":
        Get.back(
            result: {
              loginController.allLeadsDataNetworkApi("","","",controller.loanTypeDecode(loginController.selectLoanType.value.toString()),"","","",controller.leadStatusNameFilter(loginController.leadsPageName.value.toString()),controller.sourceFilterSendValue(loginController.filterTypeSelected.value.toString()),controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value)),
              loginController.allLeadsDataModel.refresh(),
              controller.getLeadDetailsNetworkApi(widget.leadId),
              controller.getLeadDetails.refresh(),
              Navigator.of(context).pop(),
            }
        );
        break;
      case "verificationLead":
        Get.back(
            result: {
              loginController.verificationNetworkApi("","","",controller.loanTypeDecode(loginController.selectLoanType.value.toString()),"","","",controller.leadStatusNameFilter(loginController.leadsPageName.value),controller.sourceFilterSendValue(loginController.filterTypeSelected.value),controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value)),
              loginController.verified_leads_model.refresh(),
              controller.getLeadDetailsNetworkApi(widget.leadId),
              controller.getLeadDetails.refresh(),
              Navigator.of(context).pop(),
            }
        );
        break;
      case "loginLead":
        Get.back(
            result: {
              loginController.loginLeadsNetworkApi("","",controller.loanTypeDecode(loginController.selectLoanType.value.toString()),"","","","","",controller.leadStatusNameFilter(loginController.leadsPageName.value), controller.sourceFilterSendValue(loginController.filterTypeSelected.value),controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value)),
              loginController.login_leads_model.refresh(),
              controller.getLeadDetailsNetworkApi(widget.leadId),
              controller.getLeadDetails.refresh(),
              Navigator.of(context).pop(),
            }
        );
        break;
      case "sanctionedLead":
        Get.back(
            result: {
              loginController.sanctionedLeadsNetworkApi("","",controller.loanTypeDecode(loginController.selectLoanType.value.toString()),"","","","","", controller.sourceFilterSendValue(loginController.filterTypeSelected.value),controller.leadStatusNameFilter(loginController.leadsPageName.value),controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value)),
              loginController.sanctioned_leads_model.refresh(),
              controller.getLeadDetailsNetworkApi(widget.leadId),
              controller.getLeadDetails.refresh(),
              Navigator.of(context).pop(),
            }
        );
        break;
      case "disbursedLead":
        Get.back(
            result: {
              loginController.disbursedLeadsNetworkApi("","",controller.loanTypeDecode(loginController.selectLoanType.value.toString()),"","","","","", controller.sourceFilterSendValue(loginController.filterTypeSelected.value),controller.leadStatusNameFilter(loginController.leadsPageName.value),controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value)),
              loginController.disbursed_data_model.refresh(),
              controller.getLeadDetailsNetworkApi(widget.leadId),
              controller.getLeadDetails.refresh(),
              Navigator.of(context).pop(),
            }
        );
        break;
      case "incentiveLead":
        Get.back(
            result: {
              loginController.incentiveDataNetworkApi("","",controller.loanTypeDecode(loginController.selectLoanType.value.toString()),"","","","","", controller.sourceFilterSendValue(loginController.filterTypeSelected.value),controller.leadStatusNameFilter(loginController.leadsPageName.value),controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value)),
              loginController.incentive_model.refresh(),
              controller.getLeadDetailsNetworkApi(widget.leadId),
              controller.getLeadDetails.refresh(),
              Navigator.of(context).pop(),
            }
        );
        break;

    }
  }

  void _showBottomSheet(BuildContext context, String selectedValue) {
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
        switch (selectedValue) {
          case "Hold":
            return _buildHoldBottomSheet(context);
          case "Verified":
            return _buildVerifiedBottomSheet(context);
          case "Login":
            return _buildLoginBottomSheet(context);
          case "Rejected":
            return _buildRejectedBottomSheet(context);
          case "Sanctioned":
            return _buildSanctionedBottomSheet(context);
          case "Disbursed":
            return _buildDisbursedBottomSheet(context);
          default:
            return Container();
        }
      },
    );
  }

  Widget _buildHoldBottomSheet(BuildContext context) {
    final ValueNotifier<bool> isChecked1 = ValueNotifier<bool>(false);
    final ValueNotifier<bool> isChecked2 = ValueNotifier<bool>(false);
    final ValueNotifier<bool> isChecked3 = ValueNotifier<bool>(false);
    return Padding(
      padding: EdgeInsets.only(right: 15.r,  left: 15.r, bottom: MediaQuery.of(Get.context!).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.r),
            Container(
              height: 4.r,
              width: 60.r,
              decoration: BoxDecoration(
                color: AllColors.grey.withOpacity(0.7),
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            SizedBox(height: 15.r),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(),
                Text("You are about to change Active Lead status",style: fontBold.copyWith(fontSize: 13.sp),textAlign: TextAlign.center,),
                InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(Icons.clear,size: 25.sp,color: AllColors.red),),
              ],
            ),
            SizedBox(height: 15.r),
            Text("Update Hold loan reason(s)",style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.7),fontSize: 12.r),),
            SizedBox(height: 20.r),
            Row(
              children: [
                ValueListenableBuilder(
                  valueListenable: isChecked1,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return Checkbox(
                      value: value,
                      onChanged: (bool? newValue) {
                        isChecked1.value = newValue ?? false;
                        if(isChecked1.value==true) {
                          controller.holdStatusList.add({
                          "reason" : "customer not contactable",
                        });
                        }else{
                          controller.holdStatusList.removeWhere((element) => element["reason"]=="customer not contactable");
                        }
                      },
                    );
                  },
                ),
                const Text("customer not contactable")
              ],
            ),
            Row(
              children: [
                ValueListenableBuilder(
                  valueListenable: isChecked2,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return Checkbox(
                      value: value,
                      onChanged: (bool? newValue) {
                        isChecked2.value = newValue ?? false;
                        if(isChecked2.value==true) {
                          controller.holdStatusList.add({
                            "reason" : "document update required",
                          });
                        }else{
                          controller.holdStatusList.removeWhere((element) => element["reason"]=="document update required");
                        }
                      },
                    );
                  },
                ),
                const Text("document update required")
              ],
            ),
            Row(
              children: [
                ValueListenableBuilder(
                  valueListenable: isChecked3,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return Checkbox(
                      value: value,
                      onChanged: (bool? newValue) {
                        isChecked3.value = newValue ?? false;
                        if(isChecked2.value==true) {
                          controller.holdStatusList.add({
                            "reason" : "customer photo",
                          });
                        }else{
                          controller.holdStatusList.removeWhere((element) => element["reason"]=="customer photo");
                        }
                      },
                    );
                  },
                ),
                const Text("customer photo")
              ],
            ),
            SizedBox(height: 30.r),
            CustomButton(
              title: "Confirm",
              height: 35.r,
              width: Get.width-65,
              background: false,
              bgColor: AllColors.darkBlue,
              onTap: () async {
                bool status = await controller.updateLeadStatusNetworkApi2(
                    controller.getLeadDetails.value.data.leadId.toString(),nextDate.text,
                    nextTime.text,remarks.text,controller.getLeadDetails.value.data.custId, "Hold");
                if(status==true){
                  Navigator.pop(context);
                  controller.holdStatusList.clear();
                  controller.rejectedStatusList.clear();
                  controller.cust_interested_loan.value = "No";
                  controller.cust_wants_loan.value = "No";
                  controller.cust_applied_last_month.value = "No";
                  controller.cust_processing_loan.value = "No";
                  controller.cust_bankbay_application.value = "No";
                  _sendScreen();
                  loginController.allLeadsDataNetworkApi("","","",controller.loanTypeDecode(loginController.selectLoanType.value.toString()),"","","",controller.leadStatusNameFilter(loginController.leadsPageName.value.toString()),controller.sourceFilterSendValue(loginController.filterTypeSelected.value.toString()),controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value));
                }
              },
            ),
            SizedBox(height: 20.r)
          ],
        ),
      ),
    );
  }

  Widget _buildVerifiedBottomSheet(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15.r,  left: 15.r, bottom: MediaQuery.of(Get.context!).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.r),
            Container(
              height: 4.r,
              width: 60.r,
              decoration: BoxDecoration(
                color: AllColors.grey.withOpacity(0.7),
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            SizedBox(height: 15.r),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(),
                Text("You are about to change Active Lead status",style: fontBold.copyWith(fontSize: 13.sp),textAlign: TextAlign.center,),
                InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(Icons.clear,size: 25.sp,color: AllColors.red),
                ),
              ],
            ),
            SizedBox(height: 15.r),
            Text("Validate Verified Verification details",style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.7),fontSize: 12.r),),
            SizedBox(height: 20.r),
            CustomUnderlineDropdownField(
              items: ["No","Yes",].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                  onTap: (){
                    print("value $value");
                  },
                );
              }).toList(),
              onChanged: (String? newValue) {
                print("value $newValue");
                controller.cust_interested_loan.value = newValue??"No";
              },
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please select gender';
              //   }
              //   return null;
              // },
              value: controller.cust_interested_loan.value,
              hint: "Is customer interested in availing loan",
            ),
            SizedBox(height: 8.r),
            CustomUnderlineDropdownField(
              items: ["No", "Yes"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                  onTap: () {
                    print("value $value");
                  },
                );
              }).toList(),
              value: controller.cust_wants_loan.value, // Set the default value here
              onChanged: (String? newValue) {
              },
              hint: "How soon the customer wants loan",
            ),
            SizedBox(height: 8.r),
            CustomUnderlineDropdownField(
              items: ["No", "Yes"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              value: controller.cust_applied_last_month.value, // Set the default value here
              onChanged: (String? newValue) {
                controller.cust_applied_last_month.value = newValue??"No";
              },
              hint: "Has customer applied for loan in last 12 months",
            ),
            SizedBox(height: 8.r),
            CustomUnderlineDropdownField(
              items: ["No", "Yes"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                  onTap: () {
                    print("value $value");
                  },
                );
              }).toList(),
              value: controller.cust_processing_loan.value, // Set the default value here
              onChanged: (String? newValue) {
                controller.cust_processing_loan.value = newValue??"No";
              },
              hint: "Is somebody else is processing loan as well",
            ),
            SizedBox(height: 8.r),
            CustomUnderlineDropdownField(
              items: ["No", "Yes"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              value: controller.cust_bankbay_application.value, // Set the default value here
              onChanged: (String? newValue) {
                controller.cust_bankbay_application.value = newValue??"No";
              },
              hint: "Is customer user of Bankbay application",
            ),
            SizedBox(height: 30.r),
            InkWell(
              onTap: (){},
              child: Center(child: Text("Share Bankbay application link on whatsapp",
                style: fontBold.copyWith(fontSize: 13.sp,color: AllColors.darkBlue),)),
            ),
            SizedBox(height: 30.r),
            CustomButton(
              title: "Confirm",
              height: 35.r,
              background: false,
              bgColor: AllColors.darkBlue,
              onTap: () async {
                bool status = await controller.updateLeadStatusNetworkApi2(
                    controller.getLeadDetails.value.data.leadId.toString(),nextDate.text, nextTime.text,
                    remarks.text,controller.getLeadDetails.value.data.custId, "Verified");
                if(status==true){
                  Navigator.pop(context);
                  controller.holdStatusList.clear();
                  controller.rejectedStatusList.clear();
                  controller.cust_interested_loan.value = "No";
                  controller.cust_wants_loan.value = "No";
                  controller.cust_applied_last_month.value = "No";
                  controller.cust_processing_loan.value = "No";
                  controller.cust_bankbay_application.value = "No";
                  bool status = await permissionController.lockUnlockLeadNetworkApi(widget.apiLeadId, "false");
                  if(status==true){
                    _sendScreen();
                  }
                }
              },
            ),
            SizedBox(height: 20.r)
          ],
        ),
      ),
    );
  }

  Widget _buildLoginBottomSheet(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15.r,  left: 15.r, bottom: MediaQuery.of(Get.context!).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.r),
            Container(
              height: 4.r,
              width: 60.r,
              decoration: BoxDecoration(
                color: AllColors.grey.withOpacity(0.7),
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            SizedBox(height: 15.r),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(),
                Text("You are about to change Active Lead status",style: fontBold.copyWith(fontSize: 13.sp),textAlign: TextAlign.center,),
                InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(Icons.clear,size: 25.sp,color: AllColors.red),
                ),
              ],
            ),
            SizedBox(height: 15.r),
            Text("Update Login details",style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.7),fontSize: 12.r),),
            SizedBox(height: 20.r),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 10.r),
                hintText: "Login Bank Name",
                hintStyle: fontSmall.copyWith(
                  wordSpacing: 0.2,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w400,
                  color: AllColors.black.withOpacity(0.7),
                ),
              ),
              items: controller.statusLoginBankList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              value: controller.loginBankName.value,
              onChanged: (newValue) {
                print("Selected value: $newValue");
                controller.loginBankName.value = newValue??"select bank";
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select bank';
                }
                return null;
              },
            ),
            SizedBox(height: 15.h,),
            UnderLineTextField(
              hint: "Enter Login date".tr,
              labelText: "Enter Login date".tr,
              controller: controller.loginDate,
              label: true,
              icon: true,
              isRead: true,
              type: TextInputType.text,
              onTap: () async {
                var datePicked = await DatePicker.showSimpleDatePicker(
                  context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  dateFormat: "yyyy-MM-dd",
                  locale: DateTimePickerLocale.en_us,
                  looping: true,
                );
                controller.loginDate.text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString())).toString();
              },
              length: 30,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter first name';
                }
                return null;
              },
            ),
            SizedBox(height: 8.h,),
            UnderLineTextField(
              hint: "Enter Application ID".tr,
              labelText: "Enter Application ID".tr,
              controller: controller.loginAppId,
              label: true,
              icon: false,
              type: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              length: 30,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter application Id';
                }
                return null;
              },
            ),
            SizedBox(height: 8.h,),
            UnderLineTextField(
              hint: "Enter Amount".tr,
              labelText: "Enter Amount".tr,
              controller: controller.loginAmount,
              label: true,
              icon: false,
              type: TextInputType.number,
              length: 30,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter first name';
                }
                return null;
              },
            ),
            SizedBox(height: 8.h,),
            UnderLineTextField(
              hint: "Login Tenure".tr,
              labelText: "Login Tenure".tr,
              controller: controller.loginTenure,
              label: true,
              icon: false,
              type: TextInputType.text,
              length: 30,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Tenure';
                }
                return null;
              },
            ),
            SizedBox(height: 20.r),
            Obx(() => CustomerStatusWidget(
              title: "Application Form".tr,
              image: controller.loginFilterImage.value,
              subTitle: "Attached stamped and signed copy of bank's application form",
              onTap: () => customerFilterTypeImageBox(context, 1),
            )),
            SizedBox(height: 30.r),
            CustomButton(
              title: "Confirm",
              height: 35.r,
              background: false,
              bgColor: AllColors.darkBlue,
              onTap: () async {
                bool status = await controller.updateLeadStatusNetworkApi(controller.getLeadDetails.value.data.leadId.toString(),nextDate.text,
                  nextTime.text,remarks.text,controller.getLeadDetails.value.data.custId,"Login");
                if(status==true){
                  Navigator.pop(context);
                  nextDate.clear();
                  nextTime.clear();
                  remarks.clear();
                  bool status = await permissionController.lockUnlockLeadNetworkApi(widget.apiLeadId, "false");
                  if(status==true){
                    _sendScreen();
                  }
                }
              },
            ),
            SizedBox(height: 20.r)
          ],
        ),
      ),
    );
  }

  Widget _buildRejectedBottomSheet(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15.r,  left: 15.r, bottom: MediaQuery.of(Get.context!).viewInsets.bottom),
      child: SingleChildScrollView(
        child: SizedBox(
          height: 620.r,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.r),
              Center(
                child: Container(
                  height: 4.r,
                  width: 60.r,
                  decoration: BoxDecoration(
                    color: AllColors.grey.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
              ),
              SizedBox(height: 15.r),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(),
                  Text("You are about to change Active Lead status", style: fontBold.copyWith(fontSize: 13.sp),textAlign: TextAlign.center,),
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Icon(Icons.clear,size: 25.sp,color: AllColors.red),
                  ),
                ],
              ),
              SizedBox(height: 15.r),
              Text("Update Rejected Hold reason(s)",style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.7),fontSize: 12.r),),
              SizedBox(height: 10.r),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.rejectItemList.length,
                itemBuilder: (context, index) {
                  return GetBuilder<PartnerController>(builder: (controller){
                    return  Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0.r),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 20.r,
                            width: 20.r,
                            child: Obx(() => Checkbox(
                              value: controller.isCheckedList[index],
                              onChanged: (value) {
                                controller.isCheckedList[index] = value!;
                                if(controller.isCheckedList[index]==true) {
                                  controller.rejectedStatusList.add({
                                    "reason" : controller.rejectItemList[index].title,
                                  });
                                }else{
                                  controller.rejectedStatusList.removeWhere((element) => element["reason"]==controller.rejectItemList[index].title);
                                }
                              },
                            ),
                            ),
                          ),
                          SizedBox(width: 15.r),
                          Text(controller.rejectItemList[index].title, style: fontRegular.copyWith(fontSize: 13.r),)
                        ],
                      ),
                    );
                  });
                },
              ),
              SizedBox(height: 25.r),
              CustomButton(
                title: "Confirm",
                height: 35.r,
                width: Get.width-65,
                background: false,
                bgColor: AllColors.darkBlue,
                onTap: () async {
                  bool status = await controller.updateLeadStatusNetworkApi2(
                      controller.getLeadDetails.value.data.leadId.toString(),nextDate.text,
                      nextTime.text,remarks.text,controller.getLeadDetails.value.data.custId, "Rejected");
                  if(status==true){
                    Navigator.pop(context);
                    List<ListItem> selectedItems = [];
                    for (int i = 0; i < controller.rejectItemList.length; i++) {
                      if (controller.isCheckedList[i]) {
                        selectedItems.add(controller.rejectItemList[i]);
                        print(selectedItems.length);
                      }
                    }
                    controller.holdStatusList.clear();
                    controller.rejectedStatusList.clear();
                    controller.cust_interested_loan.value = "No";
                    controller.cust_wants_loan.value = "No";
                    controller.cust_applied_last_month.value = "No";
                    controller.cust_processing_loan.value = "No";
                    controller.cust_bankbay_application.value = "No";
                    bool status = await permissionController.lockUnlockLeadNetworkApi(widget.apiLeadId, "false");
                    if(status==true){
                      controller.isCheckedList.clear();
                      controller.isCheckedList.assignAll(List<bool>.filled(controller.rejectItemList.length, false));
                      _sendScreen();
                      loginController.allLeadsDataNetworkApi("","","","","","","",loginController.leadsPageName.value,loginController.filterTypeSelected.value,controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value));
                    }
                  }
                },
              ),
              SizedBox(height: 20.r),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSanctionedBottomSheet(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(right: 15.r,  left: 15.r, bottom: MediaQuery.of(Get.context!).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.r),
              Container(
                height: 4.r,
                width: 60.r,
                decoration: BoxDecoration(
                  color: AllColors.grey.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              SizedBox(height: 15.r),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(),
                  Text("You are about to change Active Lead status",style: fontBold.copyWith(fontSize: 13.sp),textAlign: TextAlign.center,),
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Icon(Icons.clear,size: 25.sp,color: AllColors.red),
                  ),
                ],
              ),
              SizedBox(height: 15.r),
              Text("Update Sanctioned Section details",style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.7),fontSize: 12.r),),
              SizedBox(height: 20.r),
              UnderLineTextField(
                hint: "Sanction Amount".tr,
                labelText: "Sanction Amount".tr,
                controller: controller.sanctionAmount,
                label: true,
                icon: false,
                type: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                length: 30,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter section amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 5.r),
              UnderLineTextField(
                hint: "Sanction ROI".tr,
                labelText: "Sanction ROI".tr,
                controller: controller.sanctionRoi,
                label: true,
                icon: false,
                type: TextInputType.text,
                length: 30,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter section amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 5.r),
              UnderLineTextField(
                hint: "Sanction Tenure".tr,
                labelText: "Sanction Tenure".tr,
                controller: controller.sanctionTenure,
                label: true,
                icon: false,
                type: TextInputType.text,
                length: 30,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter section amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 5.r),
              UnderLineTextField(
                hint: "Sanction date".tr,
                labelText: "Sanction date".tr,
                label: true,
                controller: controller.sanctionDate,
                icon: true,
                isRead: true,
                type: TextInputType.text,
                length: 30,
                onTap: () async {
                  var datePicked = await DatePicker.showSimpleDatePicker(
                    context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    dateFormat: "yyyy-MM-dd",
                    locale: DateTimePickerLocale.en_us,
                    looping: true,
                  );
                  controller.sanctionDate.text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString())).toString();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter section amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.r),
              Obx(() => CustomerStatusWidget(
                title: "Sanction letter or Note".tr,
                image: controller.sanctionedFilterImage.value,
                subTitle: "attach a document showing sanction details",
                onTap: () => customerFilterTypeImageBox(context, 2),
              )),
              SizedBox(height: 30.r),
              CustomButton(
                title: "Confirm",
                height: 35.r,
                background: false,
                bgColor: AllColors.darkBlue,
                onTap: ()async{
                  bool status = await controller.updateLeadStatusNetworkApi(
                      controller.getLeadDetails.value.data.leadId.toString(),nextDate.text, nextTime.text,
                      remarks.text,controller.getLeadDetails.value.data.custId, "Sanctioned");
                  if(status==true){
                    Navigator.pop(context);
                    nextDate.clear();
                    nextTime.clear();
                    remarks.clear();
                    bool status = await permissionController.lockUnlockLeadNetworkApi(widget.apiLeadId, "false");
                    if(status==true){
                      _sendScreen();
                      loginController.sanctionedLeadsNetworkApi("","",controller.loanTypeDecode(loginController.selectLoanType.value.toString()),"","","","","",controller.leadStatusNameFilter(loginController.leadsPageName.value), controller.sourceFilterSendValue(loginController.filterTypeSelected.value),controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value));
                      loginController.sanctioned_leads_model.refresh();
                    }
                  }
                },
              ),
              SizedBox(height: 20.r),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDisbursedBottomSheet(BuildContext context) {
    return Container(
      height: Get.height-21.r,
      padding: EdgeInsets.only(right: 15.r,  left: 15.r, bottom: MediaQuery.of(Get.context!).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.r),
            Center(
              child: Container(
                height: 4.r,
                width: 60.r,
                decoration: BoxDecoration(
                  color: AllColors.grey.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
            ),
            SizedBox(height: 15.r),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(),
                Text("You are about to change Active Lead status", style: fontBold.copyWith(fontSize: 13.sp),textAlign: TextAlign.center,),
                InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(Icons.clear,size: 25.sp,color: AllColors.red),
                ),
              ],
            ),
            SizedBox(height: 15.r),
            Text("Update Disbursed Disbursement details",style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.7),fontSize: 12.r),),
            SizedBox(height: 20.r),
            UnderLineTextField(
              hint: "Disbursed Amount exm-100000".tr,
              labelText: "Disbursed Amount".tr,
              controller: controller.disbursedAmount,
              label: true,
              icon: false,
              type: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              length: 30,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter section amount';
                }
                return null;
              },
            ),
            SizedBox(height: 5.h,),
            UnderLineTextField(
              hint: "Disbursed Tenure".tr,
              labelText: "Disbursed Tenure".tr,
              controller: controller.disbursedTenure,
              label: true,
              icon: false,
              type: TextInputType.number,
              length: 30,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter section amount';
                }
                return null;
              },
            ),
            SizedBox(height: 5.h,),
            UnderLineTextField(
              hint: "Disbursed ROI        example- 10.5,11.25,etc".tr,
              labelText: "Disbursed ROI".tr,
              controller: controller.disbursedRoi,
              label: true,
              icon: false,
              type: TextInputType.number,
              length: 30,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter disbursed ROI';
                }
                return null;
              },
            ),
            SizedBox(height: 5.h,),
            UnderLineTextField(
              hint: "Disbursed Bank Name".tr,
              labelText: "Disbursed Bank Name".tr,
              controller: controller.disbursedBankName,
              label: true,
              icon: false,
              inputFormatters: [UpperCaseTextFormatter()],
              type: TextInputType.text,
              length: 30,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter disbursed disbursed bank name';
                }
                return null;
              },
            ),
            SizedBox(height: 5.h,),
            UnderLineTextField(
              hint: "Disbursed Bank Account Name".tr,
              labelText: "Disbursed Bank Account Name".tr,
              controller: controller.disbursedBankAccountName,
              label: true,
              icon: false,
              inputFormatters: [UpperCaseTextFormatter()],
              type: TextInputType.text,
              length: 30,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter disbursed bank account name';
                }
                return null;
              },
            ),
            SizedBox(height: 5.h,),
            UnderLineTextField(
              hint: "Disbursed Bank Account Number".tr,
              labelText: "Disbursed Bank Account Number".tr,
              controller: controller.disbursedBankAccountNumber,
              label: true,
              icon: false,
              type: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              length: 16,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter section amount';
                }
                return null;
              },
            ),
            SizedBox(height: 5.h,),
            UnderLineTextField(
              hint: "Disbursed Bank IFSC Code".tr,
              labelText: "Disbursed Bank IFSC Code".tr,
              controller: controller.disbursedBankIFSCCode,
              label: true,
              icon: false,
              type: TextInputType.text,
              inputFormatters: [UpperCaseTextFormatter()],
              length: 30,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter section amount';
                }
                return null;
              },
            ),
            SizedBox(height: 5.h,),
            UnderLineTextField(
              hint: "Disbursement Method".tr,
              labelText: "Disbursement Method".tr,
              controller: controller.disbursedMethod,
              label: true,
              icon: false,
              type: TextInputType.text,
              length: 30,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter section amount';
                }
                return null;
              },
            ),
            SizedBox(height: 5.h,),
            UnderLineTextField(
              hint: "Disbursement Date".tr,
              labelText: "Disbursement Date".tr,
              controller: controller.disbursedDate,
              label: true,
              icon: true,
              isRead: true,
              onTap: () async {
                var datePicked = await DatePicker.showSimpleDatePicker(
                  context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  dateFormat: "yyyy-MM-dd",
                  locale: DateTimePickerLocale.en_us,
                  looping: true,
                );
                controller.disbursedDate.text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString())).toString();
              },
              type: TextInputType.text,
              length: 30,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter section amount';
                }
                return null;
              },
            ),
            SizedBox(height: 10.r),
            Container(
              height: 33.r,
              padding: EdgeInsets.symmetric(horizontal: 10.r),
              decoration: BoxDecoration(
                color: AllColors.lightGrey,
                border: Border(bottom: BorderSide(color: AllColors.black.withOpacity(0.3)))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "${controller.getLeadDetails.value.data.fosAssignEmpName??"--NA--"} ",
                      style: fontSmall.copyWith(
                        wordSpacing: 0.2,
                        letterSpacing: 0.8,
                        fontWeight: FontWeight.w400,
                        color: AllColors.black.withOpacity(0.7),
                      ),
                      children: [
                        TextSpan(text: controller.getLeadDetails.value.data.fosAssignEmpId!=null&&controller.getLeadDetails.value.data.fosAssignEmpId!=""?"(${controller.getLeadDetails.value.data.fosAssignEmpId??""})":"", style: fontSmall.copyWith(
                          wordSpacing: 0.2,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w400,
                          color: AllColors.black.withOpacity(0.5),
                        ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      findValue.value="UID";
                      disbursedTeleFosTab.value=2;
                      _showDisbursedLeadDetailsBottomSheet(context);
                    },
                    child: Text("Edit FOS", style: fontSmall.copyWith(
                      wordSpacing: 0.2,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w600,
                      color: AllColors.blue.withOpacity(0.7),
                    ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.r),
            Container(
              height: 33.r,
              padding: EdgeInsets.symmetric(horizontal: 10.r),
              decoration: BoxDecoration(
                color: AllColors.lightGrey,
                border: Border(bottom: BorderSide(color: AllColors.black.withOpacity(0.3)))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "${controller.getLeadDetails.value.data.teleAssignEmpName??"--NA--"} ",
                      style: fontSmall.copyWith(
                        wordSpacing: 0.2,
                        letterSpacing: 0.8,
                        fontWeight: FontWeight.w400,
                        color: AllColors.black.withOpacity(0.7),
                      ),
                      children: [
                        TextSpan(text: controller.getLeadDetails.value.data.teleAssignEmpId!=null&&controller.getLeadDetails.value.data.teleAssignEmpId!=""?"(${controller.getLeadDetails.value.data.teleAssignEmpId??""})":"", style: fontSmall.copyWith(
                          wordSpacing: 0.2,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w400,
                          color: AllColors.black.withOpacity(0.5),
                        ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      findValue.value="UID";
                      disbursedTeleFosTab.value=1;
                      _showDisbursedLeadDetailsBottomSheet(context);
                    },
                    child: Text("Edit Tele", style: fontSmall.copyWith(
                      wordSpacing: 0.2,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w600,
                      color: AllColors.blue.withOpacity(0.7),
                    ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.r),
            Obx(() => CustomerStatusWidget(
              title: "Disbursement letter".tr,
              title2: "Note".tr,
              image: controller.disbursedFilterImage.value,
              subTitle: "document showing disbursement details like Disbursement "
                  "letter or Borrower's bank statement or other bank supporting artifact",
              onTap: () => customerFilterTypeImageBox(context, 3),
            )),
            SizedBox(height: 30.r),
            CustomButton(
              title: "Confirm",
              height: 35.r,
              background: false,
              bgColor: AllColors.darkBlue,
              onTap: () async {
                bool status = await controller.updateLeadStatusNetworkApi(
                    controller.getLeadDetails.value.data.leadId.toString(),nextDate.text, nextTime.text,
                    remarks.text,controller.getLeadDetails.value.data.custId, "Inc Due");
                if(status==true){
                  Navigator.pop(context);
                  nextDate.clear();
                  nextTime.clear();
                  remarks.clear();
                  bool status = await permissionController.lockUnlockLeadNetworkApi(widget.apiLeadId, "false");
                  if(status==true){
                    _sendScreen();
                  }
                }
              },
            ),
            SizedBox(height: 20.r),
          ],
        ),
      ),
    );
  }

  void _showDisbursedLeadDetailsBottomSheet(BuildContext context) {
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
        return WillPopScope(
          onWillPop: Future.value,
          child: Container(
            height: Get.height-21.r,
            padding: EdgeInsets.only(right: 15.r,  left: 15.r, bottom: MediaQuery.of(Get.context!).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.r),
                  Center(
                    child: Container(
                      height: 4.r,
                      width: 60.r,
                      decoration: BoxDecoration(
                        color: AllColors.grey.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.r),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(),
                      Text("Assign Lead",style: fontBold.copyWith(fontSize: 14.sp),textAlign: TextAlign.center,),
                      InkWell(
                        onTap: (){
                         Get.back();
                         },
                        child: Icon(Icons.clear,size: 25.sp,color: AllColors.red),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.r),
                  Padding(
                    padding: EdgeInsets.only(left:8.0.r),
                    child: Text("Lead Details", style: fontBold.copyWith(),),
                  ),
                  SizedBox(height: 15.r),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 18.r,
                        backgroundColor: AllColors.lightTeal.withOpacity(0.6),
                      ),
                      SizedBox(width: 10.r),
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
                                      RichText(
                                        text: TextSpan(
                                          text: "${controller.getLeadDetails.value.data.custName} ",
                                          style: fontSmall.copyWith(fontWeight: FontWeight.w500),
                                          children: [
                                            TextSpan(text: "(${controller.getLeadDetails.value.data.custId})", style: fontSmall.copyWith()),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 3.r),
                                      Text(controller.getLeadDetails.value.data.custPermanentAddress??"NA", style: fontSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                      SizedBox(height: 3.r),
                                      Text("Lead date : ${controller.getLeadDetails.value.data.leadDateTime??"NA"}", style: fontSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.r),
                  RichText(
                    text: TextSpan(
                      text: "Present Assignment ", style: fontBold.copyWith(),
                      children: [
                        TextSpan(text: "(Tele)",style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.5), fontSize: 13.r,),),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.r),
                  GetBuilder<PartnerController>(
                    builder: (controller) {
                      return controller.getLeadDetails.value.data.teleAssignEmpId!=null&&controller.getLeadDetails.value.data.teleAssignEmpId!=""?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text("${controller.getLeadDetails.value.data.teleAssignEmpName??"NA"} (${controller.getLeadDetails.value.data.teleAssignEmpId??"NA"} )" ,style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.6), fontSize: 13.r,),),
                          SizedBox(height: 4.r),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${controller.getLeadDetails.value.data.teleAssignEmpAddress??"NA"} " ,style: fontMedium.copyWith(color: AllColors.black, fontSize: 13.r,),),
                            ],
                          ),
                          SizedBox(height: 4.r),
                          RichText(
                            text: TextSpan(
                              text: 'Sup ID : ',
                              style: fontMedium.copyWith(color: AllColors.grey),
                              children: [
                                TextSpan(text: "${controller.getLeadDetails.value.data.teleSupName??"NA"}  (${controller.getLeadDetails.value.data.teleAssignSupId??"NA"} )",style: fontMedium.copyWith(color: AllColors.black, fontSize: 13.r,),),
                              ],
                            ),
                          ),
                          SizedBox(height: 4.r),
                          RichText(
                            text: TextSpan(
                              text: 'Function : ',
                              style: fontMedium.copyWith(color: AllColors.grey),
                              children: [
                                TextSpan(text: "${controller.getLeadDetails.value.data.teleAssignEmpFunction??"NA"} ",style: fontMedium.copyWith(color: AllColors.black, fontSize: 13.r,),),
                              ],
                            ),
                          ),
                        ],
                      ) :
                        Text("Unassigned" ,style: fontMedium.copyWith(color: AllColors.red, fontSize: 13.r,),);
                    }
                  ),
                  Center(
                    child: Container(
                      height: 1.r,
                      margin: EdgeInsets.symmetric(vertical: 15.r),
                      decoration: BoxDecoration(
                        color: AllColors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Present Assignment ", style: fontBold.copyWith(),
                      children: [
                        TextSpan(text: "(FOS)",style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.5), fontSize: 13.r,),),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.r),
                  GetBuilder<PartnerController>(
                      builder: (controller) {
                        return controller.getLeadDetails.value.data.fosAssignEmpId!=null&&controller.getLeadDetails.value.data.fosAssignEmpId!=""?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${controller.getLeadDetails.value.data.fosAssignEmpName??"NA"} (${controller.getLeadDetails.value.data.fosAssignEmpId??"NA"} )" ,style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.6), fontSize: 13.r,),),
                            SizedBox(height: 4.r),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${controller.getLeadDetails.value.data.fosAssignEmpAddress??"NA"} " ,style: fontMedium.copyWith(color: AllColors.black, fontSize: 13.r,),),
                              ],
                            ),
                            SizedBox(height: 4.r),
                            RichText(
                              text: TextSpan(
                                text: 'Sup ID : ',
                                style: fontMedium.copyWith(color: AllColors.grey),
                                children: [
                                  TextSpan(text: "${controller.getLeadDetails.value.data.fosSupName??"NA"}  (${controller.getLeadDetails.value.data.fosAssignSupId??"NA"} )",style: fontMedium.copyWith(color: AllColors.black, fontSize: 13.r,),),
                                ],
                              ),
                            ),
                            SizedBox(height: 4.r),
                            RichText(
                              text: TextSpan(
                                text: 'Function : ',
                                style: fontMedium.copyWith(color: AllColors.grey),
                                children: [
                                  TextSpan(text: "${controller.getLeadDetails.value.data.fosAssignEmpFunction??"NA"} ",style: fontMedium.copyWith(color: AllColors.black, fontSize: 13.r,),),
                                ],
                              ),
                            ),
                          ],
                        ) :
                        Text("Unassigned" ,style: fontMedium.copyWith(color: AllColors.red, fontSize: 13.r,),);
                      }
                  ),
                  Center(
                    child: Container(
                      height: 1.r,
                      margin: EdgeInsets.symmetric(vertical: 15.r),
                      decoration: BoxDecoration(
                        color: AllColors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                  ),
                  Obx(()=> SizedBox(
                    height: 35.r,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            disbursedTeleFosTab.value=1;
                          },
                          child: AnimatedContainer(
                            curve: Curves.linearToEaseOut,
                            duration: const Duration(milliseconds: 200),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 20.r),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 3.r, color: disbursedTeleFosTab.value==1?AllColors.red:AllColors.none))
                            ),
                            child: Text("Assign Tele".tr,
                              style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color: disbursedTeleFosTab.value==1?AllColors.red: AllColors.themeColor),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.r),
                        InkWell(
                          onTap: (){
                            disbursedTeleFosTab.value=2;
                          },
                          child: AnimatedContainer(
                            curve: Curves.linearToEaseOut,
                            duration: const Duration(milliseconds: 200),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 20.r),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 3.r, color: disbursedTeleFosTab.value==2? AllColors.red:AllColors.none))
                            ),
                            child: Text("Assign FOS".tr,
                              style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color: disbursedTeleFosTab.value==2?AllColors.red:AllColors.themeColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                  SizedBox(height: 15.r),
                  Obx((){
                    if(disbursedTeleFosTab.value==1){
                      return AssignTele(leadId: widget.leadId,leadTransferName: widget.leadTransferName, apiLeadId: widget.apiLeadId,pageName: widget.pageName);
                    }else if(disbursedTeleFosTab.value==2){
                      return AssignFos(leadId: widget.leadId,leadTransferName: widget.leadTransferName, apiLeadId: widget.apiLeadId,pageName: widget.pageName);
                    }else{
                      return const SizedBox();
                    }
                  }),
                  SizedBox(height: 20.r),
                  GetBuilder<PartnerController>(
                    builder: (controller) {
                      return Center(
                        child: CustomButton(
                          title: "Assign Lead",
                          height: 40.r,
                          radius: 8.r,
                          width: Get.width-160,
                          background: false,
                          bgColor: AllColors.green,
                          onTap: ()async{
                            bool status = await controller.updateAssignLeadNetworkApi(
                              controller.getLeadDetails.value.data.leadId??"",
                              (controller.check_owner_exist_tele.value.data.isNotEmpty&&controller.check_owner_exist_tele.value.data!=null)?
                              controller.check_owner_exist_tele.value.data[0].eid.toString():"",
                              (controller.check_owner_exist_fos.value.data.isNotEmpty&&controller.check_owner_exist_fos.value.data!=null)?
                              controller.check_owner_exist_fos.value.data[0].eid.toString():"",
                            );
                            if(status==true) {
                              controller.employeeId.clear();
                              controller.check_assign_approval_exist_model.value.data.clear();
                              controller.approvalReason.clear();
                              Navigator.pop(context);
                              _showDisbursedEditTeleBottomSheet(context);
                            }
                          },
                        ),
                      );
                    }
                  ),
                  SizedBox(height: 20.r)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDisbursedEditTeleBottomSheet(BuildContext context) {
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
        return WillPopScope(
          onWillPop: Future.value,
          child: Container(
            padding: EdgeInsets.only(right: 15.r,  left: 15.r, bottom: MediaQuery.of(Get.context!).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.r),
                  Center(
                    child: Container(
                      height: 4.r,
                      width: 60.r,
                      decoration: BoxDecoration(
                        color: AllColors.grey.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.r),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(),
                      Text("Assignment change Approval",style: fontBold.copyWith(fontSize: 14.sp),textAlign: TextAlign.center,),
                      InkWell(onTap: ()=> Get.back(),
                        child: Icon(Icons.clear,size: 25.sp,color: AllColors.red),),
                    ],
                  ),
                  SizedBox(height: 20.r),
                  Form(
                    key: formKeyAssignChangeApproval,
                    child: TextFormField(
                      controller: controller.employeeId,
                      keyboardType: TextInputType.text,
                      maxLength: 10,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return  "Please fill approver ID";
                        }
                        return null;
                      },
                      maxLines: 1,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: "Enter Approver ID",
                        labelText: "Enter Approver ID",
                        hintStyle: fontRegular.copyWith(color: AllColors.black.withOpacity(0.6), fontSize: 13.r, wordSpacing: 0, letterSpacing: 0),
                        isDense: true,
                        // filled: true,
                        // fillColor: AllColors.white.withOpacity(0.9),
                        contentPadding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 8.h),
                        labelStyle: fontRegular.copyWith(color: AllColors.black.withOpacity(0.6), fontSize: 13.r, wordSpacing: 0, letterSpacing: 0),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                        ),
                        focusedBorder:  OutlineInputBorder(
                            borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                        ),
                        errorBorder:   OutlineInputBorder(
                            borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                        ),
                        suffixIconConstraints: BoxConstraints(
                          minHeight: 35.r,
                          maxHeight: 35.r,
                        ),
                        suffixIcon: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: (){
                            if (formKeyAssignChangeApproval.currentState != null && formKeyAssignChangeApproval.currentState!.validate()) {
                              controller.checkAssignmentApprovalExistNetworkApi(controller.employeeId.text);
                            }
                          },
                          child: Text("Check", style: fontBold.copyWith(color: AllColors.themeColor),),
                        ),
                      ),
                    ),
                  ),
                  controller.check_assign_approval_exist_model.value.data.isNotEmpty?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.r),
                      Text("${controller.check_assign_approval_exist_model.value.data[0].empFname} ${controller.check_assign_approval_exist_model.value.data[0].empLname} (${controller.check_assign_approval_exist_model.value.data[0].eid})" ,style: fontMedium.copyWith(color: AllColors.black, fontSize: 13.r,),),
                      SizedBox(height: 4.r),
                      Text(controller.check_assign_approval_exist_model.value.data[0].empPresentAddress??"NA",style: fontMedium.copyWith(color: AllColors.black, fontSize: 13.r,),),
                      SizedBox(height: 4.r),
                      RichText(
                        text: TextSpan(
                          text: 'Sup ID : ',
                          style: fontMedium.copyWith(color: AllColors.grey),
                          children: [
                            TextSpan(text: "${controller.check_assign_approval_exist_model.value.data[0].supName??"NA"} (${controller.check_assign_approval_exist_model.value.data[0].supId??0})",style: fontMedium.copyWith(color: AllColors.black, fontSize: 13.r,),),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.r),
                      RichText(
                        text: TextSpan(
                          text: 'Function : ',
                          style: fontMedium.copyWith(color: AllColors.grey),
                          children: [
                            TextSpan(text:  controller.check_assign_approval_exist_model.value.data[0].empFunction??"NA",style: fontMedium.copyWith(color: AllColors.black, fontSize: 13.r,),),
                          ],
                        ),
                      ),
                    ],
                  ) :
                  const SizedBox(),
                  SizedBox(height: 20.r),
                  TextField(
                    controller: controller.approvalReason,
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Mention reason for assignment change",
                      isDense: true,
                      // filled: true,
                      // fillColor: AllColors.white.withOpacity(0.9),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.h),
                      hintStyle: fontRegular.copyWith(color: AllColors.black.withOpacity(0.6), fontStyle: FontStyle.italic, fontSize: 13.r, wordSpacing: 0.3, letterSpacing: 0.5),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                      ),
                      focusedBorder:  OutlineInputBorder(
                          borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                      ),
                      errorBorder:   OutlineInputBorder(
                          borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                      ),
                    ),
                  ),
                  SizedBox(height: 30.r),
                  Center(
                    child: CustomButton(
                      title: "Request Approve",
                      height: 40.r,
                      radius: 8.r,
                      width: Get.width-160,
                      background: false,
                      bgColor: AllColors.deepPurple,
                      onTap: ()async{
                        if(controller.check_assign_approval_exist_model.value.data.isNotEmpty){
                          bool status = await controller.assignmentChangeApprovalNetworkApi(
                            controller.getLeadDetails.value.data.leadId.toString(),
                            "Request",
                            controller.check_assign_approval_exist_model.value.data[0].eid.toString(),
                            controller.approvalReason.text,
                          );
                          if(status==true) {
                            if(widget.leadTransferName=="transferLead"||widget.leadTransferName=="unassignedTransferLead"){
                              Navigator.pop(context);
                              _sendScreen();
                            }
                            else{
                              Navigator.pop(context);
                            }
                          }
                        }else{
                          BaseController().errorSnack("details data not found this id !!");
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20.r)
                ],
              ),
              ),
            ),
          ),
        );
      },
    );
  }

  customerFilterTypeImageBox(BuildContext context, type) {
    showDialog(
      context: context,
      builder: (BuildContext context,) {
        return AlertDialog(
          content: SizedBox(
            height: 180.r,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25.r, right: 25.r, top: 20.r),
                  child: Column(
                    children: [
                      Text(
                        "Choose Image",
                        style: fontBold.copyWith(fontSize: 18.r),
                      ),
                      SizedBox(height: 15.r),
                      Container(
                        height: 2.r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: AllColors.lightGrey.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.r),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        controller.customerDetailsStatusImages(false,type);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0.r),
                        child: Column(
                          children: [
                            Image.asset(
                              Images.gallery,
                              height: 50.r,
                              width: 50.r,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 5.r),
                            Text(
                              "Gallery",
                              style: fontMedium.copyWith(fontSize: 15.r),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 1.r,
                      height: 40.r,
                      color: AllColors.lightGrey.withOpacity(0.8),
                      margin: EdgeInsets.symmetric(vertical: 5.r),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        controller.customerDetailsStatusImages(true,type);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0.r),
                        child: Column(
                          children: [
                            Image.asset(
                              Images.camera,
                              height: 50.r,
                              width: 50.r,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 5.r),
                            Text(
                              "Camera",
                              style: fontMedium.copyWith(fontSize: 15.r),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
          contentPadding: EdgeInsets.zero,
          actionsOverflowButtonSpacing: 0,
          actionsOverflowDirection: VerticalDirection.down,
          actions: [
            Container(
              color: Colors.red,
            )
          ],
        );
      },
    );
  }

  _checkStatusNodeList(List data, name){
    if(data.isNotEmpty&&data!=null){
      return name=name;
    }else{
      return name="Bad";
    }
  }

  _checkStatusNodeValue(String data, name){
    if(data!="null"&&data!=""){
      return name=name;
    }else{
      return name="Bad";
    }
  }

}

class StatusViewData extends StatelessWidget {
  final String title;
  final String? value;
  final String? hint;
  const StatusViewData({super.key, required this.title, this.value, this.hint=""});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.r),
      child: Row(
        children: [
          SizedBox(
            width: Get.width/3-15.r,
            child: Text(title,
              style: fontMedium.copyWith(
                fontSize: 12.r,
                color: AllColors.black.withOpacity(0.5),
              ),
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: ":  ${value.toString()}",
                style: fontRegular.copyWith(
                  wordSpacing: 0,
                  letterSpacing: 0.2,
                  fontSize: 12.r,
                  color: AllColors.black.withOpacity(0.5),
                ),
                children: [
                  if(hint.toString().isNotEmpty)
                    TextSpan(text: " (${hint.toString()})", style: fontSmall.copyWith(color: AllColors.black.withOpacity(0.5))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListItem {
  String title;
  bool isSelected;
  ListItem({required this.title, this.isSelected = false});
}

class CustomerStatusWidget extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String title;
  final String? title2;
  final String? subTitle;
  final String image;
  const CustomerStatusWidget(
      {super.key, this.onTap, required this.title, this.subTitle, required this.image, this.title2=""});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DottedBorder(
          borderType: BorderType.Rect,
          radius: Radius.circular(5.r),
          strokeWidth: 1.5.r,
          dashPattern: const [5, 4],
          color: AllColors.black.withOpacity(0.5),
          child: image!=""?
          Container(
            height: 100.r,
            width: 150.r,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: FileImage(File(image.toString()),
                  )
              ),
            ),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: onTap,
                child: Container(
                  height: 22.r,
                  alignment: Alignment.center,
                  color: AllColors.black.withOpacity(0.4),
                  child: Text("Browser Files",style: fontMedium.copyWith(color: AllColors.white.withOpacity(0.9),fontSize: 12.r),),
                ),
              ),
            ),
          ) :
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 5.r),
            child: Column(
              children: [
                Icon(Icons.cloud_download_rounded, size: 25.r,
                    color: Colors.black.withOpacity(0.6)),
                SizedBox(height: 3.r),
                Text(
                  "Drag & Drop files here",
                  style: fontExtraSmall.copyWith(
                      color: Colors.black.withOpacity(0.6)),
                ),
                SizedBox(height: 5.r),
                Text(
                  "or",
                  style: fontExtraSmall.copyWith(
                      color: Colors.black.withOpacity(0.6)),
                ),
                SizedBox(height: 5.r),
                InkWell(
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.r, vertical: 3.r),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.r),
                      border: Border.all(
                          width: 1.r, color: AllColors.blue.withOpacity(0.9)),
                    ),
                    child: Text("Browser Files", style: fontExtraSmall.copyWith(
                        color: AllColors.blue.withOpacity(0.9),
                        letterSpacing: 0.1),),
                  ),
                ),
                SizedBox(height: 5.r),
              ],
            ),
          ),
        ),
        SizedBox(width: 20.r),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: title.toString(),
                    style: fontBold.copyWith(
                      color: AllColors.black.withOpacity(0.9),
                      fontSize: 12.r,
                      wordSpacing: 0.0,
                      letterSpacing: 0.0,
                    ),
                    children: [
                      if(title2.toString()!="")
                      TextSpan(text: ' or ', style: fontBold.copyWith(
                          color: AllColors.black.withOpacity(0.6),
                          fontSize: 11.5.r,
                        wordSpacing: 0.0,
                        letterSpacing: 0.0,
                      ),
                      ),
                      TextSpan(text: title2.toString(), style: fontBold.copyWith(
                          color: AllColors.black.withOpacity(0.9),
                          fontSize: 12.r,
                          wordSpacing: 0.0,
                          letterSpacing: 0.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3.r),
                Text(subTitle ?? "",
                  style: fontRegular.copyWith(
                    color: AllColors.black.withOpacity(0.7),
                    fontSize: 11.5.r,
                    letterSpacing: 0.2,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
