// ignore_for_file: avoid_print

import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_dropdown.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/Partner/partner_home.dart';
import 'package:bank_bay/widgets/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PartnerPushbackAccessScreen extends StatefulWidget {
  final String partnerId;
  final String pageName;
  const PartnerPushbackAccessScreen({super.key, required this.partnerId, required this.pageName});

  @override
  State<PartnerPushbackAccessScreen> createState() => _PartnerPushbackAccessScreenState();
}
final PartnerController controller = Get.find<PartnerController>();

class _PartnerPushbackAccessScreenState extends State<PartnerPushbackAccessScreen> {
  var formKeyPushbackAssignChangeApprovalFormKey1 = GlobalKey<FormState>(debugLabel: "_formKeyPushbackAssignChangeApprovalFormKey1");

  @override
  void initState() {
    controller.getCustomerDetailsNetworkApi(widget.partnerId.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("pag name ${controller.customerDetails.value.data.partnerdetails.pid}");
    print("kahsj ${widget.partnerId}");
    return Obx((){
        controller.partnerEmpViewAll.value = (controller.customerDetails.value.data.access.empViewAll!=null&&controller.customerDetails.value.data.access.empViewAll!=""?controller.customerDetails.value.data.access.empViewAll.toString().capitalize:"No").toString();
        controller.partnerAddEMP.value = (controller.customerDetails.value.data.access.addEmp!=null&&controller.customerDetails.value.data.access.addEmp!=""?controller.customerDetails.value.data.access.addEmp.toString().capitalize:"No").toString();
        controller.partnerUpdateEMP.value = (controller.customerDetails.value.data.access.updateEmp!=null&&controller.customerDetails.value.data.access.updateEmp!=""?controller.customerDetails.value.data.access.updateEmp.toString().capitalize:"No").toString();
        controller.partnerEmpPushBack.value = (controller.customerDetails.value.data.access.empPushBack!=null&&controller.customerDetails.value.data.access.empPushBack!=""?controller.customerDetails.value.data.access.empPushBack.toString().capitalize:"No").toString();
        controller.partnerEmpApprove.value = (controller.customerDetails.value.data.access.empApprove!=null&&controller.customerDetails.value.data.access.empApprove!=""?controller.customerDetails.value.data.access.empApprove.toString().capitalize:"No").toString();
        controller.partnerEmpPendingApprove.value = (controller.customerDetails.value.data.access.empPendingApproval!=null&&controller.customerDetails.value.data.access.empPendingApproval!=""?controller.customerDetails.value.data.access.empPendingApproval.toString().capitalize:"No").toString();
        controller.partnerPartnerViewAll.value = (controller.customerDetails.value.data.access.partnerViewAll!=null&&controller.customerDetails.value.data.access.partnerViewAll!=""?controller.customerDetails.value.data.access.partnerViewAll.toString().capitalize:"No").toString();
        controller.partnerPartnerAdd.value = (controller.customerDetails.value.data.access.partnerAdd!=null&&controller.customerDetails.value.data.access.partnerAdd!=""?controller.customerDetails.value.data.access.partnerAdd.toString().capitalize:"No").toString();
        controller.partnerPartnerUpdate.value = (controller.customerDetails.value.data.access.partnerUpdate!=null&&controller.customerDetails.value.data.access.partnerUpdate!=""?controller.customerDetails.value.data.access.partnerUpdate.toString().capitalize:"No").toString();
        controller.partnerPartnerPushBack.value = (controller.customerDetails.value.data.access.partnerPushBack!=null&&controller.customerDetails.value.data.access.partnerPushBack!=""?controller.customerDetails.value.data.access.partnerPushBack.toString().capitalize:"No").toString();
        controller.unassignedLeads.value = (controller.customerDetails.value.data.access.unassignedLeads!=null&&controller.customerDetails.value.data.access.unassignedLeads!=""?controller.customerDetails.value.data.access.unassignedLeads.toString().capitalize:"No").toString();
        controller.partnerAssignAllLead.value = (controller.customerDetails.value.data.access.assignAllLead!=null&&controller.customerDetails.value.data.access.assignAllLead!=""?controller.customerDetails.value.data.access.assignAllLead.toString().capitalize:"No").toString();
        controller.partnerAssignMyLead.value = (controller.customerDetails.value.data.access.assignMyLead!=null&&controller.customerDetails.value.data.access.assignMyLead!=""?controller.customerDetails.value.data.access.assignMyLead.toString().capitalize:"No").toString();
        controller.partnerAssignMyTeamLead.value = (controller.customerDetails.value.data.access.assignMyteamLead!=null&&controller.customerDetails.value.data.access.assignMyteamLead!=""?controller.customerDetails.value.data.access.assignMyteamLead.toString().capitalize:"No").toString();
        controller.partnerAssignMyPartnerLead.value = (controller.customerDetails.value.data.access.assignMypartnerLead!=null&&controller.customerDetails.value.data.access.assignMypartnerLead!=""?controller.customerDetails.value.data.access.assignMypartnerLead.toString().capitalize:"No").toString();
        controller.partnerAddLead.value = (controller.customerDetails.value.data.access.addLead!=null&&controller.customerDetails.value.data.access.addLead!=""?controller.customerDetails.value.data.access.addLead.toString().capitalize:"No").toString();
        controller.partnerMyLead.value = (controller.customerDetails.value.data.access.myLead!=null&&controller.customerDetails.value.data.access.myLead!=""?controller.customerDetails.value.data.access.myLead.toString().capitalize:"No").toString();
        controller.partnerMyTeamLead.value = (controller.customerDetails.value.data.access.myteamLead!=null&&controller.customerDetails.value.data.access.myteamLead!=""?controller.customerDetails.value.data.access.myteamLead.toString().capitalize:"No").toString();
        controller.partnerMyPartnerLead.value = (controller.customerDetails.value.data.access.mypartnerLead!=null&&controller.customerDetails.value.data.access.mypartnerLead!=""?controller.customerDetails.value.data.access.mypartnerLead.toString().capitalize:"No").toString();
        controller.partnerAllCust.value = (controller.customerDetails.value.data.access.allCust!=null&&controller.customerDetails.value.data.access.allCust!=""?controller.customerDetails.value.data.access.allCust.toString().capitalize:"No").toString();
        controller.partnerMyCust.value = (controller.customerDetails.value.data.access.myCust!=null&&controller.customerDetails.value.data.access.myCust!=""?controller.customerDetails.value.data.access.myCust.toString().capitalize:"No").toString();
        controller.partnerMyTeamCust.value = (controller.customerDetails.value.data.access.myteamCust!=null&&controller.customerDetails.value.data.access.myteamCust!=""?controller.customerDetails.value.data.access.myteamCust.toString().capitalize:"No").toString();
        controller.partnerMyPartnerCust.value = (controller.customerDetails.value.data.access.mypartnerCust!=null&&controller.customerDetails.value.data.access.mypartnerCust!=""?controller.customerDetails.value.data.access.mypartnerCust.toString().capitalize:"No").toString();
        controller.partnerMySales.value = (controller.customerDetails.value.data.access.mySales!=null&&controller.customerDetails.value.data.access.mySales!=""?controller.customerDetails.value.data.access.mySales.toString().capitalize:"No").toString();
        controller.partnerIncentiveMGMTView.value = (controller.customerDetails.value.data.access.incentiveMgmtView!=null&&controller.customerDetails.value.data.access.incentiveMgmtView!=""?controller.customerDetails.value.data.access.incentiveMgmtView.toString().capitalize:"No").toString();
        controller.partnerIncentiveMGMTEdit.value = (controller.customerDetails.value.data.access.incentiveMgmtEdit!=null&&controller.customerDetails.value.data.access.incentiveMgmtEdit!=""?controller.customerDetails.value.data.access.incentiveMgmtEdit.toString().capitalize:"No").toString();
        controller.partnerPanelManagePartner.value = (controller.customerDetails.value.data.access.panelManagePartner!=null&&controller.customerDetails.value.data.access.panelManagePartner!=""?controller.customerDetails.value.data.access.panelManagePartner.toString().capitalize:"No").toString();
        controller.partnerPanelManageEmployee.value = (controller.customerDetails.value.data.access.panelManageEmployee!=null&&controller.customerDetails.value.data.access.panelManageEmployee!=""?controller.customerDetails.value.data.access.panelManageEmployee.toString().capitalize:"No").toString();
        controller.partnerPanelManageCustomer.value = (controller.customerDetails.value.data.access.panelManageCustomer!=null&&controller.customerDetails.value.data.access.panelManageCustomer!=""?controller.customerDetails.value.data.access.panelManageCustomer.toString().capitalize:"No").toString();
        controller.partnerNewLeadTab.value = (controller.add_partner_access_model.value.data.newLeadTab!=null&&controller.add_partner_access_model.value.data.newLeadTab!=""?controller.add_partner_access_model.value.data.newLeadTab.toString().capitalize:"No").toString();
        controller.partnerVerificationTab.value = (controller.add_partner_access_model.value.data.verificationLeadTab!=null&&controller.add_partner_access_model.value.data.verificationLeadTab!=""?controller.add_partner_access_model.value.data.verificationLeadTab.toString().capitalize:"No").toString();
        controller.partnerDisbursedTab.value = (controller.add_partner_access_model.value.data.disbursedLeadTab!=null&&controller.add_partner_access_model.value.data.disbursedLeadTab!=""?controller.add_partner_access_model.value.data.disbursedLeadTab.toString().capitalize:"No").toString();
        controller.partnerIncentiveTab.value = (controller.add_partner_access_model.value.data.incentiveLeadTab!=null&&controller.add_partner_access_model.value.data.incentiveLeadTab!=""?controller.add_partner_access_model.value.data.incentiveLeadTab.toString().capitalize:"No").toString();

        return Padding(
          padding: EdgeInsets.all(10.0.r),
          child: Column(
            children: [
              CustomUnderlineDropdownField(
                items: ["No", "Yes",].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                    onTap: (){
                      if(controller.partnerPanelManageEmployee.value.toLowerCase()=="yes"){
                        controller.partnerEmpViewAll.value=value;
                      }else{
                        controller.partnerEmpViewAll.value="No";
                      }
                    },
                  );
                }).toList(),
                onChanged: (String? newValue) {
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
                      if(controller.partnerPanelManageEmployee.value.toLowerCase()=="yes"){
                        controller.partnerAddEMP.value=value;
                      }else{
                        controller.partnerAddEMP.value="No";
                      }
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
                      if(controller.partnerPanelManageEmployee.value.toLowerCase()=="yes"){
                        controller.partnerUpdateEMP.value=value;
                      }else{
                        controller.partnerUpdateEMP.value="No";
                      }
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
                      if(controller.partnerPanelManageEmployee.value.toLowerCase()=="yes"){
                        controller.partnerEmpPushBack.value=value;
                      }else{
                        controller.partnerEmpPushBack.value="No";
                      }
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
                      if(controller.partnerPanelManageEmployee.value.toLowerCase()=="yes"){
                        controller.partnerEmpApprove.value=value;
                      }else{
                        controller.partnerEmpApprove.value="No";
                      }
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
                      if(controller.partnerPanelManageEmployee.value.toLowerCase()=="yes"){
                        controller.partnerEmpPendingApprove.value=value;
                      }else{
                        controller.partnerEmpPendingApprove.value="No";
                      }
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
                      if(controller.partnerPanelManagePartner.value.toLowerCase()=="yes"){
                        controller.partnerPartnerViewAll.value=value;
                      }else{
                        controller.partnerPartnerViewAll.value="No";
                      }
                    },
                  );
                }).toList(),
                onChanged: (String? newValue) {
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
                      if(controller.partnerPanelManagePartner.value.toLowerCase()=="yes"){
                        controller.partnerPartnerAdd.value=value;
                      }else{
                        controller.partnerPartnerAdd.value="No";
                      }
                    },
                  );
                }).toList(),
                onChanged: (String? newValue) {
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
                      if(controller.partnerPanelManagePartner.value.toLowerCase()=="yes"){
                        controller.partnerPartnerUpdate.value=value;
                      }else{
                        controller.partnerPartnerUpdate.value="No";
                      }
                    },
                  );
                }).toList(),
                onChanged: (String? newValue) {
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
                      if(controller.partnerPanelManagePartner.value.toLowerCase()=="yes"){
                        controller.partnerPartnerPushBack.value=value;
                      }else{
                        controller.partnerPartnerPushBack.value="No";
                      }
                    },
                  );
                }).toList(),
                onChanged: (String? newValue) {
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
              SizedBox(height: 15.r),
              CustomerCountView(
                title: "Access changes Count".tr,
                count: "${controller.customerDetails.value.data.access.accessChangeCount??"NA"}",
              ),
              SizedBox(height: 15.r),
              CustomerCountView(
                title: "Access changes By".tr,
                count: controller.customerDetails.value.data.access.changeByName??"NA",
                changes: " (${controller.customerDetails.value.data.access.accessChangeBy??"NA"})",
              ),
              SizedBox(height: 15.r),
              CustomerCountView(
                title: "Access changes By".tr,
                changes: controller.customerDetails.value.data.access.accessChangeDateTime??"NA",
              ),
              SizedBox(height: 25.r),
              CustomButton(
                title: "Update".tr,
                bgColor: AllColors.green,
                background: false,
                height: 38.r,
                radius: 0.r,
                onTap: ()async{
                  bool status = await  controller.partnerPushbackAccessNetworkApi(
                      controller.customerDetails.value.data.partnerdetails.custId,
                      controller.customerDetails.value.data.access.accessChangeCount);
                  if (status == true) {
                    if(widget.pageName.toString()=="partnerApprove"){
                      Get.off(()=> const DashboardScreen());
                      partnerTab.value=4;
                    }else{
                      controller.employeeId.clear();
                      controller.check_assign_approval_exist_model.value.data.clear();
                      _showDisbursedEditTeleBottomSheet(context);
                    }
                  }
                },
              ),
            ],
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
                    key: formKeyPushbackAssignChangeApprovalFormKey1,
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
                            if (formKeyPushbackAssignChangeApprovalFormKey1.currentState != null && formKeyPushbackAssignChangeApprovalFormKey1.currentState!.validate()) {
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
                            controller.customerDetails.value.data.partnerdetails.pid,
                            "request",
                            controller.check_assign_approval_exist_model.value.data[0].eid.toString(),
                            controller.approvalReason.text,
                            GetStorage().read(AppConstant.cust_id).toString(),
                          );
                          if(status==true) {
                            Get.off(()=> const DashboardScreen());
                            if(widget.pageName.toString()=="allPartner"){
                              Get.off(()=> const DashboardScreen());
                              partnerTab.value=5;
                            }
                            partnerTab.value=3;
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
}

class CustomerCountView extends StatelessWidget {
  final String title;
  final String? count;
  final String? changes;
  const CustomerCountView({Key? key, required this.title, this.count="", this.changes=""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 10.r),
      color: AllColors.grey.withOpacity(0.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("$title : ",style: fontRegular.copyWith(fontSize: 11.r),),
          Text(count.toString(),style: fontBold.copyWith(fontSize: 12.r),),
          Expanded(child: Text(changes.toString(),style: fontMedium.copyWith(fontSize: 11.r),overflow: TextOverflow.ellipsis, maxLines: 1,)),
        ],
      ),
    );
  }
}

