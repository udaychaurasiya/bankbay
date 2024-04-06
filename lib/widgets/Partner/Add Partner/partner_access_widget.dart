import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_dropdown.dart';
import 'package:bank_bay/widgets/Partner/create_partner.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/dashboard.dart';
import 'package:bank_bay/widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class PartnerAccessScreen extends StatefulWidget {
  const PartnerAccessScreen({super.key});

  @override
  State<PartnerAccessScreen> createState() => _PartnerAccessScreenState();
}
class _PartnerAccessScreenState extends State<PartnerAccessScreen> {
var controller = Get.find<PartnerController>();
var loginController = Get.find<LoginController>();
var formKeyAssignChangeApprovalFormKey1 = GlobalKey<FormState>(debugLabel: "_formKeyAssignChangeApprovalFormKey");

  @override
  void initState() {
    controller.getAddEmployeeAccessNetworkApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AllColors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.0.r),
      margin: EdgeInsets.only(bottom: 10.0.r),
      child: Column(
        children: [
          SizedBox(height: 10.r),
          GetBuilder<PartnerController>(builder:(controller) {
            controller.partnerEmpViewAll.value = (controller.add_partner_access_model.value.data.empViewAll!=null&&controller.add_partner_access_model.value.data.empViewAll!=""?controller.add_partner_access_model.value.data.empViewAll.toString().capitalize:"No").toString();
            controller.partnerAddEMP.value = (controller.add_partner_access_model.value.data.addEmp!=null&&controller.add_partner_access_model.value.data.addEmp!=""?controller.add_partner_access_model.value.data.addEmp.toString().capitalize:"No").toString();
            controller.partnerUpdateEMP.value = (controller.add_partner_access_model.value.data.updateEmp!=null&&controller.add_partner_access_model.value.data.updateEmp!=""?controller.add_partner_access_model.value.data.updateEmp.toString().capitalize:"No").toString();
            controller.partnerEmpPushBack.value = (controller.add_partner_access_model.value.data.empPushBack!=null&&controller.add_partner_access_model.value.data.empPushBack!=""?controller.add_partner_access_model.value.data.empPushBack.toString().capitalize:"No").toString();
            controller.partnerEmpApprove.value = (controller.add_partner_access_model.value.data.empApprove!=null&&controller.add_partner_access_model.value.data.empApprove!=""?controller.add_partner_access_model.value.data.empApprove.toString().capitalize:"No").toString();
            controller.partnerEmpPendingApprove.value = (controller.add_partner_access_model.value.data.empPendingApproval!=null&&controller.add_partner_access_model.value.data.empPendingApproval!=""?controller.add_partner_access_model.value.data.empPendingApproval.toString().capitalize:"No").toString();
            controller.partnerPartnerViewAll.value = (controller.add_partner_access_model.value.data.partnerViewAll!=null&&controller.add_partner_access_model.value.data.partnerViewAll!=""?controller.add_partner_access_model.value.data.partnerViewAll.toString().capitalize:"No").toString();
            controller.partnerPartnerAdd.value = (controller.add_partner_access_model.value.data.partnerAdd!=null&&controller.add_partner_access_model.value.data.partnerAdd!=""?controller.add_partner_access_model.value.data.partnerAdd.toString().capitalize:"No").toString();
            controller.partnerPartnerUpdate.value = (controller.add_partner_access_model.value.data.partnerUpdate!=null&&controller.add_partner_access_model.value.data.partnerUpdate!=""?controller.add_partner_access_model.value.data.partnerUpdate.toString().capitalize:"No").toString();
            controller.partnerPartnerPushBack.value = (controller.add_partner_access_model.value.data.partnerPushBack!=null&&controller.add_partner_access_model.value.data.partnerPushBack!=""?controller.add_partner_access_model.value.data.partnerPushBack.toString().capitalize:"No").toString();
            controller.unassignedLeads.value = (controller.add_partner_access_model.value.data.unassignedLeads!=null&&controller.add_partner_access_model.value.data.unassignedLeads!=""?controller.add_partner_access_model.value.data.unassignedLeads.toString().capitalize:"No").toString();
            controller.partnerAssignAllLead.value = (controller.add_partner_access_model.value.data.assignAllLead!=null&&controller.add_partner_access_model.value.data.assignAllLead!=""?controller.add_partner_access_model.value.data.assignAllLead.toString().capitalize:"No").toString();
            controller.partnerAssignMyLead.value = (controller.add_partner_access_model.value.data.assignMyLead!=null&&controller.add_partner_access_model.value.data.assignMyLead!=""?controller.add_partner_access_model.value.data.assignMyLead.toString().capitalize:"No").toString();
            controller.partnerAssignMyTeamLead.value = (controller.add_partner_access_model.value.data.assignMyteamLead!=null&&controller.add_partner_access_model.value.data.assignMyteamLead!=""?controller.add_partner_access_model.value.data.assignMyteamLead.toString().capitalize:"No").toString();
            controller.partnerAssignMyPartnerLead.value = (controller.add_partner_access_model.value.data.assignMypartnerLead!=null&&controller.add_partner_access_model.value.data.assignMypartnerLead!=""?controller.add_partner_access_model.value.data.assignMypartnerLead.toString().capitalize:"No").toString();
            controller.partnerAddLead.value = (controller.add_partner_access_model.value.data.addLead!=null&&controller.add_partner_access_model.value.data.addLead!=""?controller.add_partner_access_model.value.data.addLead.toString().capitalize:"No").toString();
            controller.partnerMyLead.value = (controller.add_partner_access_model.value.data.myLead!=null&&controller.add_partner_access_model.value.data.myLead!=""?controller.add_partner_access_model.value.data.myLead.toString().capitalize:"No").toString();
            controller.partnerMyTeamLead.value = (controller.add_partner_access_model.value.data.myteamLead!=null&&controller.add_partner_access_model.value.data.myteamLead!=""?controller.add_partner_access_model.value.data.myteamLead.toString().capitalize:"No").toString();
            controller.partnerMyPartnerLead.value = (controller.add_partner_access_model.value.data.mypartnerLead!=null&&controller.add_partner_access_model.value.data.mypartnerLead!=""?controller.add_partner_access_model.value.data.mypartnerLead.toString().capitalize:"No").toString();
            controller.partnerAllCust.value = (controller.add_partner_access_model.value.data.allCust!=null&&controller.add_partner_access_model.value.data.allCust!=""?controller.add_partner_access_model.value.data.allCust.toString().capitalize:"No").toString();
            controller.partnerMyCust.value = (controller.add_partner_access_model.value.data.myCust!=null&&controller.add_partner_access_model.value.data.myCust!=""?controller.add_partner_access_model.value.data.myCust.toString().capitalize:"No").toString();
            controller.partnerMyTeamCust.value = (controller.add_partner_access_model.value.data.myteamCust!=null&&controller.add_partner_access_model.value.data.myteamCust!=""?controller.add_partner_access_model.value.data.myteamCust.toString().capitalize:"No").toString();
            controller.partnerMyPartnerCust.value = (controller.add_partner_access_model.value.data.mypartnerCust!=null&&controller.add_partner_access_model.value.data.mypartnerCust!=""?controller.add_partner_access_model.value.data.mypartnerCust.toString().capitalize:"No").toString();
            controller.partnerMySales.value = (controller.add_partner_access_model.value.data.mySales!=null&&controller.add_partner_access_model.value.data.mySales!=""?controller.add_partner_access_model.value.data.mySales.toString().capitalize:"No").toString();
            controller.partnerIncentiveMGMTView.value = (controller.add_partner_access_model.value.data.incentiveMgmtView!=null&&controller.add_partner_access_model.value.data.incentiveMgmtView!=""?controller.add_partner_access_model.value.data.incentiveMgmtView.toString().capitalize:"No").toString();
            controller.partnerIncentiveMGMTEdit.value = (controller.add_partner_access_model.value.data.incentiveMgmtEdit!=null&&controller.add_partner_access_model.value.data.incentiveMgmtEdit!=""?controller.add_partner_access_model.value.data.incentiveMgmtEdit.toString().capitalize:"No").toString();
            controller.partnerPanelManagePartner.value = (controller.add_partner_access_model.value.data.panelManagePartner!=null&&controller.add_partner_access_model.value.data.panelManagePartner!=""?controller.add_partner_access_model.value.data.panelManagePartner.toString().capitalize:"No").toString();
            controller.partnerPanelManageEmployee.value = (controller.add_partner_access_model.value.data.panelManageEmployee!=null&&controller.add_partner_access_model.value.data.panelManageEmployee!=""?controller.add_partner_access_model.value.data.panelManageEmployee.toString().capitalize:"No").toString();
            controller.partnerPanelManageCustomer.value = (controller.add_partner_access_model.value.data.panelManageCustomer!=null&&controller.add_partner_access_model.value.data.panelManageCustomer!=""?controller.add_partner_access_model.value.data.panelManageCustomer.toString().capitalize:"No").toString();
            controller.partnerNewLeadTab.value = (controller.add_partner_access_model.value.data.newLeadTab!=null&&controller.add_partner_access_model.value.data.newLeadTab!=""?controller.add_partner_access_model.value.data.newLeadTab.toString().capitalize:"No").toString();
            controller.partnerVerificationTab.value = (controller.add_partner_access_model.value.data.verificationLeadTab!=null&&controller.add_partner_access_model.value.data.verificationLeadTab!=""?controller.add_partner_access_model.value.data.verificationLeadTab.toString().capitalize:"No").toString();
            controller.partnerDisbursedTab.value = (controller.add_partner_access_model.value.data.disbursedLeadTab!=null&&controller.add_partner_access_model.value.data.disbursedLeadTab!=""?controller.add_partner_access_model.value.data.disbursedLeadTab.toString().capitalize:"No").toString();
            controller.partnerIncentiveTab.value = (controller.add_partner_access_model.value.data.incentiveLeadTab!=null&&controller.add_partner_access_model.value.data.incentiveLeadTab!=""?controller.add_partner_access_model.value.data.incentiveLeadTab.toString().capitalize:"No").toString();
            return Column(
                children: [
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerEmpViewAll.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                      if(controller.partnerPanelManageEmployee.value.toLowerCase()=="yes"){
                        controller.partnerEmpViewAll.value=newValue??"No";
                      }else{
                        controller.partnerEmpViewAll.value="No";
                        confirmationDialogBox(
                          context,
                          "Please Select Employee Panel",
                          "Check the employee panel first otherwise you cannot use any other functionality.",
                        );
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select emp view all';
                      }
                      return null;
                    },
                    value: controller.partnerEmpViewAll.value,
                    hint: "EMP View All",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerAddEMP.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if(controller.partnerPanelManageEmployee.value.toLowerCase()=="yes"){
                        controller.partnerAddEMP.value=newValue??"No";
                      }else{
                        controller.partnerAddEMP.value="No";
                        confirmationDialogBox(
                          context,
                          "Please Select Employee Panel",
                          "Check the employee panel first otherwise you cannot use any other functionality.",
                        );
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select add emp';
                      }
                      return null;
                    },
                    value: controller.partnerAddEMP.value,
                    hint: "Add EMP",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerUpdateEMP.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if(controller.partnerPanelManageEmployee.value.toLowerCase()=="yes"){
                        controller.partnerUpdateEMP.value=newValue??"No";
                      }else{
                        controller.partnerUpdateEMP.value="No";
                        confirmationDialogBox(
                          context,
                          "Please Select Employee Panel",
                          "Check the employee panel first otherwise you cannot use any other functionality.",
                        );
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select update emp';
                      }
                      return null;
                    },
                    value: controller.partnerUpdateEMP.value,
                    hint: "Update EMP",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerEmpPushBack.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if(controller.partnerPanelManageEmployee.value.toLowerCase()=="yes"){
                        controller.partnerEmpPushBack.value=newValue??"No";
                      }else{
                        controller.partnerEmpPushBack.value="No";
                        confirmationDialogBox(
                          context,
                          "Please Select Employee Panel",
                          "Check the employee panel first otherwise you cannot use any other functionality.",
                        );
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select emp push back';
                      }
                      return null;
                    },
                    value: controller.partnerEmpPushBack.value,
                    hint: "EMP Push Back",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerEmpApprove.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if(controller.partnerPanelManageEmployee.value.toLowerCase()=="yes"){
                        controller.partnerEmpApprove.value=newValue??"No";
                      }else{
                        controller.partnerEmpApprove.value="No";
                        confirmationDialogBox(
                          context,
                          "Please Select Employee Panel",
                          "Check the employee panel first otherwise you cannot use any other functionality.",
                        );
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select emp approve';
                      }
                      return null;
                    },
                    value: controller.partnerEmpApprove.value,
                    hint: "EMP Approve",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerEmpPendingApprove.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if(controller.partnerPanelManageEmployee.value.toLowerCase()=="yes"){
                        controller.partnerEmpPendingApprove.value=newValue??"No";
                      }else{
                        controller.partnerEmpPendingApprove.value="No";
                        confirmationDialogBox(
                          context,
                          "Please Select Employee Panel",
                          "Check the employee panel first otherwise you cannot use any other functionality.",
                        );
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select emp pending approve';
                      }
                      return null;
                    },
                    value: controller.partnerEmpPendingApprove.value,
                    hint: "EMP Pending Approve",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerPartnerViewAll.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                      if(controller.partnerPanelManagePartner.value.toLowerCase()=="yes"){
                        controller.partnerPartnerViewAll.value=newValue??"No";
                      }else{
                        controller.partnerPartnerViewAll.value="No";
                        confirmationDialogBox(
                          context,
                          "Please Select Partner Panel",
                          "Check the partner panel first otherwise you cannot use any other functionality.",
                        );
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select partner view all';
                      }
                      return null;
                    },
                    value: controller.partnerPartnerViewAll.value,
                    hint: "Partner View All",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerPartnerAdd.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                      if(controller.partnerPanelManagePartner.value.toLowerCase()=="yes"){
                        controller.partnerPartnerAdd.value=newValue??"No";
                      }else{
                        controller.partnerPartnerAdd.value="No";
                        confirmationDialogBox(
                          context,
                          "Please Select Partner Panel",
                          "Check the partner panel first otherwise you cannot use any other functionality.",
                        );
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select partner add';
                      }
                      return null;
                    },
                    value: controller.partnerPartnerAdd.value,
                    hint: "Partner Add",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerPartnerUpdate.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                      if(controller.partnerPanelManagePartner.value.toLowerCase()=="yes"){
                        controller.partnerPartnerUpdate.value=newValue??"No";
                      }else{
                        controller.partnerPartnerUpdate.value="No";
                        confirmationDialogBox(
                          context,
                          "Please Select Partner Panel",
                          "Check the partner panel first otherwise you cannot use any other functionality.",
                        );
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select partner update';
                      }
                      return null;
                    },
                    value: controller.partnerPartnerUpdate.value,
                    hint: "Partner Update",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerPartnerPushBack.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                      if(controller.partnerPanelManagePartner.value.toLowerCase()=="yes"){
                        controller.partnerPartnerPushBack.value=newValue??"No";
                      }else{
                        controller.partnerPartnerPushBack.value="No";
                        confirmationDialogBox(
                          context,
                          "Please Select Partner Panel",
                          "Check the partner panel first otherwise you cannot use any other functionality.",
                        );
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select partner push back';
                      }
                      return null;
                    },
                    value: controller.partnerPartnerPushBack.value,
                    hint: "Partner Push Back",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.unassignedLeads.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select unassigned leads';
                      }
                      return null;
                    },
                    value: controller.unassignedLeads.value,
                    hint: "Unassigned Leads",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerAssignAllLead.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select assign all lead';
                      }
                      return null;
                    },
                    value: controller.partnerAssignAllLead.value,
                    hint: "Assign All Lead",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerAssignMyLead.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select assign my lead';
                      }
                      return null;
                    },
                    value: controller.partnerAssignMyLead.value,
                    hint: "Assign My Lead",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerAssignMyTeamLead.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select assign my team lead';
                      }
                      return null;
                    },
                    value: controller.partnerAssignMyTeamLead.value,
                    hint: "Assign My Team Lead",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerAssignMyPartnerLead.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select assign my partner lead';
                      }
                      return null;
                    },
                    value: controller.partnerAssignMyPartnerLead.value,
                    hint: "Assign My Partner Lead",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerAddLead.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select add lead';
                      }
                      return null;
                    },
                    value: controller.partnerAddLead.value,
                    hint: "Add Lead",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerMyLead.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select my lead';
                      }
                      return null;
                    },
                    value: controller.partnerMyLead.value,
                    hint: "My Lead",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerMyTeamLead.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select my team lead';
                      }
                      return null;
                    },
                    value: controller.partnerMyTeamLead.value,
                    hint: "My Team Lead",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerMyPartnerLead.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select my partner lead';
                      }
                      return null;
                    },
                    value: controller.partnerMyPartnerLead.value,
                    hint: "My Partner Lead",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerAllCust.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select all cust';
                      }
                      return null;
                    },
                    value: controller.partnerAllCust.value,
                    hint: "All Cust",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerMyCust.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select my cust';
                      }
                      return null;
                    },
                    value: controller.partnerMyCust.value,
                    hint: "My Cust",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerMyTeamCust.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select my team cust';
                      }
                      return null;
                    },
                    value: controller.partnerMyTeamCust.value,
                    hint: "My Team Cust",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerMyPartnerCust.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select my partner cust';
                      }
                      return null;
                    },
                    value: controller.partnerMyPartnerCust.value,
                    hint: "My Partner Cust",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerMySales.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select my sales';
                      }
                      return null;
                    },
                    value: controller.partnerMySales.value,
                    hint: "My Sales",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerIncentiveMGMTView.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select incentive MGMT view';
                      }
                      return null;
                    },
                    value: controller.partnerIncentiveMGMTView.value,
                    hint: "Incentive MGMT View",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerIncentiveMGMTEdit.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select incentive MGMT edit';
                      }
                      return null;
                    },
                    value: controller.partnerIncentiveMGMTEdit.value,
                    hint: "Incentive MGMT Edit",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerPanelManagePartner.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select panel manage partner';
                      }
                      return null;
                    },
                    value: controller.partnerPanelManagePartner.value,
                    hint: "Panel Manage Partner",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerPanelManageEmployee.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select panel manage employee';
                      }
                      return null;
                    },
                    value: controller.partnerPanelManageEmployee.value,
                    hint: "Panel Manage Employee",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerPanelManageCustomer.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select panel manage customer';
                      }
                      return null;
                    },
                    value: controller.partnerPanelManageCustomer.value,
                    hint: "Panel Manage Customer",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerNewLeadTab.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select new lead tab';
                      }
                      return null;
                    },
                    value: controller.partnerNewLeadTab.value,
                    hint: "New Lead Tab",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerVerificationTab.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select verification lead tab';
                      }
                      return null;
                    },
                    value: controller.partnerVerificationTab.value,
                    hint: "Verification Lead Tab",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerDisbursedTab.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select disbursed lead tab';
                      }
                      return null;
                    },
                    value: controller.partnerDisbursedTab.value,
                    hint: "Disbursed Lead Tab",
                  ),
                  SizedBox(height: 8.r),
                  CustomUnderlineDropdownField(
                    items: ["No", "Yes",].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: (){
                          print("value $value");
                          controller.partnerIncentiveTab.value=value;
                        },
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print("jhkh $newValue");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select incentive lead tab';
                      }
                      return null;
                    },
                    value: controller.partnerIncentiveTab.value,
                    hint: "Incentive Lead Tab",
                  ),
                  SizedBox(height: 8.r),
                  CustomerCountView(
                    title: "Access changes Count".tr,
                    count: "${controller.add_partner_access_model.value.data.accessChangeCount??"NA"}",
                  ),
                  SizedBox(height: 10.r),
                  CustomerCountView(
                    title: "Access changes By".tr,
                    count: GetStorage().read(AppConstant.name).toString(),
                    changes: " (${GetStorage().read(AppConstant.cust_id).toString()})",
                  ),
                  SizedBox(height: 10.r),
                  CustomerCountView(
                    title: "Access changes Date".tr,
                    changes: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  ),
                ],
              );
            }
          ),
          SizedBox(height: 30.r),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                title: "Back".tr,
                width: 140.r,
                bgColor: AllColors.green,
                background: false,
                height: 38.r,
                radius: 0,
                onTap: ()async{
                  addPartnerTab.value = 7;
                },
              ),
              CustomButton(
                title: "Submit".tr,
                width: 140.r,
                background: true,
                height: 38.r,
                radius: 0,
                onTap: ()async{
                  bool status = await  controller.partnerAddAccessNetworkApi();
                  if (status == true) {
                    controller.check_assign_approval_exist_model.value.data.clear();
                    controller.employeeId.clear();
                    _showDisbursedEditTeleBottomSheet(context);
                  }
                },
              )
            ],
          ),
          SizedBox(height: 20.r),
        ],
      ),
    );
  }

  confirmationDialogBox(BuildContext context,title, subtitle) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Dialog(
      child: Container(
        height: 260.r,
        width: double.infinity,
        padding: EdgeInsets.all(10.r),
        child: Column(
          children: [
            SizedBox(height: 10.r),
            Text("Alert !!",style: fontBold.copyWith(fontSize: 19.r)),
            SizedBox(height: 40.r),
            Text(title.toString(),style: fontBold.copyWith(fontSize: 16.r)),
            SizedBox(height: 20.r),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 15.0.r),
              child: Text(subtitle.toString(),
                style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.5)),
              ),
            ),
            SizedBox(height: 30.r),
            InkWell(
              onTap: ()async{
                Navigator.pop(context);
              },
              child: CustomButton(
                background: true,
                width: 60.r,
                height: 30.r,
                radius: 3.r,
                title: "Ok".tr,
              ),
            ),
          ],
        ),
      ),
    ),
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
                      Text("Assignment change Approval",style: fontBold.copyWith(fontSize: 14.sp),textAlign: TextAlign.center,),
                      InkWell(onTap: ()=> Get.back(),
                        child: Icon(Icons.clear,size: 25.sp,color: AllColors.red),),
                    ],
                  ),
                  SizedBox(height: 20.r),
                  Form(
                    key: formKeyAssignChangeApprovalFormKey1,
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
                            if (formKeyAssignChangeApprovalFormKey1.currentState != null && formKeyAssignChangeApprovalFormKey1.currentState!.validate()) {
                              controller.checkAssignmentApprovalExistNetworkApi(controller.employeeId.text);
                            }
                          },
                          child: Text("Check", style: fontBold.copyWith(color: AllColors.themeColor),),
                        ),
                      ),
                    ),
                  ),
                  Obx((){
                    return controller.check_assign_approval_exist_model.value.data.isNotEmpty?
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
                      const SizedBox();
                  }),
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
                        bool status = await controller.partnerApprovalRequestNetworkApi(
                          GetStorage().read(AppConstant.pid).toString(),
                          "request",
                          controller.check_assign_approval_exist_model.value.data[0].eid.toString(),
                          controller.approvalReason.text,
                          GetStorage().read(AppConstant.cust_id).toString(),
                        );
                        if(status==true) {
                          Navigator.of(context).pop();
                          Get.off(() => const DashboardScreen());
                          loginController.index.value=0;
                          indexValue.value = 1;
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
        );
      },
    );
  }
}

class CustomerCountView extends StatelessWidget {
  final String title;
  final String? count;
  final String? changes;
  const CustomerCountView({super.key, required this.title, this.count="", this.changes=""});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 10.r),
      color: AllColors.grey.withOpacity(0.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("$title : ",style: fontRegular.copyWith(fontSize: 12.r),),
          Text(count.toString(),style: fontBold.copyWith(fontSize: 12.r),),
          Text(changes.toString(),style: fontMedium.copyWith(fontSize: 12.r),),
        ],
      ),
    );
  }
}

