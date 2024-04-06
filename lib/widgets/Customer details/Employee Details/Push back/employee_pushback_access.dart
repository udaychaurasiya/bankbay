import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_dropdown.dart';
import 'package:bank_bay/widgets/Employee/employee_home.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EmployeePushBackAccessScreen extends StatefulWidget {
  final String empId;
  final String pageName;
  const EmployeePushBackAccessScreen({super.key, required this.empId, required this.pageName});

  @override
  State<EmployeePushBackAccessScreen> createState() => _EmployeePushBackAccessScreenState();
}
var controller = Get.find<LoginController>();
var partnerController = Get.find<PartnerController>();
var formKeyAssignChangeApprovalFormKey = GlobalKey<FormState>(debugLabel: "_formKeyAssignChangeApprovalFormKey");
class _EmployeePushBackAccessScreenState extends State<EmployeePushBackAccessScreen> {
  @override
  void initState() {
    partnerController.getEmployeeDetailsNetworkApi(widget.empId.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    controller.empViewAll.value = (partnerController.employeeDetails.value.data.accessDefault.empViewAll!=null&&partnerController.employeeDetails.value.data.accessDefault.empViewAll!=""?partnerController.employeeDetails.value.data.accessDefault.empViewAll.toString().capitalize:"No").toString();
    controller.addEMP.value = (partnerController.employeeDetails.value.data.accessDefault.addEmp!=null&&partnerController.employeeDetails.value.data.accessDefault.addEmp!=""?partnerController.employeeDetails.value.data.accessDefault.addEmp.toString().capitalize:"No").toString();
    controller.updateEMP.value = (partnerController.employeeDetails.value.data.accessDefault.updateEmp!=null&&partnerController.employeeDetails.value.data.accessDefault.updateEmp!=""?partnerController.employeeDetails.value.data.accessDefault.updateEmp.toString().capitalize:"No").toString();
    controller.empPushBack.value = (partnerController.employeeDetails.value.data.accessDefault.empPushBack!=null&&partnerController.employeeDetails.value.data.accessDefault.empPushBack!=""?partnerController.employeeDetails.value.data.accessDefault.empPushBack.toString().capitalize:"No").toString();
    controller.empApprove.value = (partnerController.employeeDetails.value.data.accessDefault.empApprove!=null&&partnerController.employeeDetails.value.data.accessDefault.empApprove!=""?partnerController.employeeDetails.value.data.accessDefault.empApprove.toString().capitalize:"No").toString();
    controller.empPendingApprove.value = (partnerController.employeeDetails.value.data.accessDefault.empPendingApproval!=null&&partnerController.employeeDetails.value.data.accessDefault.empPendingApproval!=""?partnerController.employeeDetails.value.data.accessDefault.empPendingApproval.toString().capitalize:"No").toString();
    controller.partnerViewAll.value = (partnerController.employeeDetails.value.data.accessDefault.partnerViewAll!=null&&partnerController.employeeDetails.value.data.accessDefault.partnerViewAll!=""?partnerController.employeeDetails.value.data.accessDefault.partnerViewAll.toString().capitalize:"No").toString();
    controller.partnerAdd.value = (partnerController.employeeDetails.value.data.accessDefault.partnerAdd!=null&&partnerController.employeeDetails.value.data.accessDefault.partnerAdd!=""?partnerController.employeeDetails.value.data.accessDefault.partnerAdd.toString().capitalize:"No").toString();
    controller.partnerUpdate.value = (partnerController.employeeDetails.value.data.accessDefault.partnerUpdate!=null&&partnerController.employeeDetails.value.data.accessDefault.partnerUpdate!=""?partnerController.employeeDetails.value.data.accessDefault.partnerUpdate.toString().capitalize:"No").toString();
    controller.partnerPushBack.value = (partnerController.employeeDetails.value.data.accessDefault.partnerPushBack!=null&&partnerController.employeeDetails.value.data.accessDefault.partnerPushBack!=""?partnerController.employeeDetails.value.data.accessDefault.partnerPushBack.toString().capitalize:"No").toString();
    controller.partnerPendingApproval.value = (partnerController.employeeDetails.value.data.accessDefault.partnerPendingApproval!=null&&partnerController.employeeDetails.value.data.accessDefault.partnerPendingApproval!=""?partnerController.employeeDetails.value.data.accessDefault.partnerPendingApproval.toString().capitalize:"No").toString();
    controller.unassignedLeads.value = (partnerController.employeeDetails.value.data.accessDefault.unassignedLeads!=null&&partnerController.employeeDetails.value.data.accessDefault.unassignedLeads!=""?partnerController.employeeDetails.value.data.accessDefault.unassignedLeads.toString().capitalize:"No").toString();
    controller.assignAllLead.value = (partnerController.employeeDetails.value.data.accessDefault.assignAllLead!=null&&partnerController.employeeDetails.value.data.accessDefault.assignAllLead!=""?partnerController.employeeDetails.value.data.accessDefault.assignAllLead.toString().capitalize:"No").toString();
    controller.assignMyLead.value = (partnerController.employeeDetails.value.data.accessDefault.assignMyLead!=null&&partnerController.employeeDetails.value.data.accessDefault.assignMyLead!=""?partnerController.employeeDetails.value.data.accessDefault.assignMyLead.toString().capitalize:"No").toString();
    controller.assignMyTeamLead.value = (partnerController.employeeDetails.value.data.accessDefault.assignMyteamLead!=null&&partnerController.employeeDetails.value.data.accessDefault.assignMyteamLead!=""?partnerController.employeeDetails.value.data.accessDefault.assignMyteamLead.toString().capitalize:"No").toString();
    controller.assignMyPartnerLead.value = (partnerController.employeeDetails.value.data.accessDefault.assignMypartnerLead!=null&&partnerController.employeeDetails.value.data.accessDefault.assignMypartnerLead!=""?partnerController.employeeDetails.value.data.accessDefault.assignMypartnerLead.toString().capitalize:"No").toString();
    controller.addLead.value = (partnerController.employeeDetails.value.data.accessDefault.addLead!=null&&partnerController.employeeDetails.value.data.accessDefault.addLead!=""?partnerController.employeeDetails.value.data.accessDefault.addLead.toString().capitalize:"No").toString();
    controller.myLead.value = (partnerController.employeeDetails.value.data.accessDefault.myLead!=null&&partnerController.employeeDetails.value.data.accessDefault.myLead!=""?partnerController.employeeDetails.value.data.accessDefault.myLead.toString().capitalize:"No").toString();
    controller.myTeamLead.value = (partnerController.employeeDetails.value.data.accessDefault.myteamLead!=null&&partnerController.employeeDetails.value.data.accessDefault.myteamLead!=""?partnerController.employeeDetails.value.data.accessDefault.myteamLead.toString().capitalize:"No").toString();
    controller.myPartnerLead.value = (partnerController.employeeDetails.value.data.accessDefault.mypartnerLead!=null&&partnerController.employeeDetails.value.data.accessDefault.mypartnerLead!=""?partnerController.employeeDetails.value.data.accessDefault.mypartnerLead.toString().capitalize:"No").toString();
    controller.AllCust.value = (partnerController.employeeDetails.value.data.accessDefault.allCust!=null&&partnerController.employeeDetails.value.data.accessDefault.allCust!=""?partnerController.employeeDetails.value.data.accessDefault.allCust.toString().capitalize:"No").toString();
    controller.myCust.value = (partnerController.employeeDetails.value.data.accessDefault.myCust!=null&&partnerController.employeeDetails.value.data.accessDefault.myCust!=""?partnerController.employeeDetails.value.data.accessDefault.myCust.toString().capitalize:"No").toString();
    controller.myTeamCust.value = (partnerController.employeeDetails.value.data.accessDefault.myteamCust!=null&&partnerController.employeeDetails.value.data.accessDefault.myteamCust!=""?partnerController.employeeDetails.value.data.accessDefault.myteamCust.toString().capitalize:"No").toString();
    controller.myPartnerCust.value = (partnerController.employeeDetails.value.data.accessDefault.mypartnerCust!=null&&partnerController.employeeDetails.value.data.accessDefault.mypartnerCust!=""?partnerController.employeeDetails.value.data.accessDefault.mypartnerCust.toString().capitalize:"No").toString();
    controller.mySales.value = (partnerController.employeeDetails.value.data.accessDefault.mySales!=null&&partnerController.employeeDetails.value.data.accessDefault.mySales!=""?partnerController.employeeDetails.value.data.accessDefault.mySales.toString().capitalize:"No").toString();
    controller.incentiveMGMTView.value = (partnerController.employeeDetails.value.data.accessDefault.incentiveMgmtView!=null&&partnerController.employeeDetails.value.data.accessDefault.incentiveMgmtView!=""?partnerController.employeeDetails.value.data.accessDefault.incentiveMgmtView.toString().capitalize:"No").toString();
    controller.incentiveMGMTEdit.value = (partnerController.employeeDetails.value.data.accessDefault.incentiveMgmtEdit!=null&&partnerController.employeeDetails.value.data.accessDefault.incentiveMgmtEdit!=""?partnerController.employeeDetails.value.data.accessDefault.incentiveMgmtEdit.toString().capitalize:"No").toString();
    controller.applySelfLoan.value = (partnerController.employeeDetails.value.data.accessDefault.applySelfLoan!=null&&partnerController.employeeDetails.value.data.accessDefault.applySelfLoan!=""?partnerController.employeeDetails.value.data.accessDefault.applySelfLoan.toString().capitalize:"No").toString();
    controller.assignmentChangeApproval.value = (partnerController.employeeDetails.value.data.accessDefault.assignementChangeApproval!=null&&partnerController.employeeDetails.value.data.accessDefault.assignementChangeApproval!=""?partnerController.employeeDetails.value.data.accessDefault.assignementChangeApproval.toString().capitalize:"No").toString();
    controller.panelManagePartner.value = (partnerController.employeeDetails.value.data.accessDefault.panelManagePartner!=null&&partnerController.employeeDetails.value.data.accessDefault.panelManagePartner!=""?partnerController.employeeDetails.value.data.accessDefault.panelManagePartner.toString().capitalize:"No").toString();
    controller.panelManageEmployee.value = (partnerController.employeeDetails.value.data.accessDefault.panelManageEmployee!=null&&partnerController.employeeDetails.value.data.accessDefault.panelManageEmployee!=""?partnerController.employeeDetails.value.data.accessDefault.panelManageEmployee.toString().capitalize:"No").toString();
    controller.panelManageCustomer.value = (partnerController.employeeDetails.value.data.accessDefault.panelManageCustomer!=null&&partnerController.employeeDetails.value.data.accessDefault.panelManageCustomer!=""?partnerController.employeeDetails.value.data.accessDefault.panelManageCustomer.toString().capitalize:"No").toString();
    controller.NewLeadTab.value = (partnerController.employeeDetails.value.data.accessDefault.newLeadTab!=null&&partnerController.employeeDetails.value.data.accessDefault.newLeadTab!=""?partnerController.employeeDetails.value.data.accessDefault.newLeadTab.toString().capitalize:"No").toString();
    controller.VerificationTab.value = (partnerController.employeeDetails.value.data.accessDefault.verificationLeadTab!=null&&partnerController.employeeDetails.value.data.accessDefault.verificationLeadTab!=""?partnerController.employeeDetails.value.data.accessDefault.verificationLeadTab.toString().capitalize:"No").toString();
    controller.DisbursedTab.value = (partnerController.employeeDetails.value.data.accessDefault.disbursedLeadTab!=null&&partnerController.employeeDetails.value.data.accessDefault.disbursedLeadTab!=""?partnerController.employeeDetails.value.data.accessDefault.disbursedLeadTab.toString().capitalize:"No").toString();
    controller.IncentiveTab.value = (partnerController.employeeDetails.value.data.accessDefault.incentiveLeadTab!=null&&partnerController.employeeDetails.value.data.accessDefault.incentiveLeadTab!=""?partnerController.employeeDetails.value.data.accessDefault.incentiveLeadTab.toString().capitalize:"No").toString();

    return GetBuilder<PartnerController>(
      builder: (partnerController){
        return Column(
          children: [
            SizedBox(height: 10.r),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0.r),
              child: GetBuilder<LoginController>(
                  builder: (controller) {
                    return Column(
                      children: [
                        CustomUnderlineDropdownField(
                          items: ["No", "Yes",].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                              onTap: (){
                                if(controller.panelManageEmployee.value.toLowerCase()=="yes"){
                                  controller.empViewAll.value=value;
                                }else{
                                  controller.empViewAll.value="No";
                                }
                              },
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if(controller.panelManageEmployee.value.toLowerCase()=="yes"){
                              controller.empViewAll.value=newValue??"No";
                            }else{
                              controller.empViewAll.value="No";
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
                          value: controller.empViewAll.value,
                          hint: "EMP View All",
                        ),
                        SizedBox(height: 8.r),
                        CustomUnderlineDropdownField(
                          items: ["No", "Yes",].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                              onTap: (){
                                if(controller.panelManageEmployee.value.toLowerCase()=="yes"){
                                  controller.addEMP.value=value;
                                }else{
                                  controller.addEMP.value="No";
                                }
                              },
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if(controller.panelManageEmployee.value.toLowerCase()=="yes"){
                              controller.addEMP.value=newValue??"No";
                            }else{
                              controller.addEMP.value="No";
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
                          value: controller.addEMP.value,
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
                                if(controller.panelManageEmployee.value.toLowerCase()=="yes"){
                                  controller.updateEMP.value=value;
                                }else{
                                  controller.updateEMP.value="No";
                                }
                              },
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if(controller.panelManageEmployee.value.toLowerCase()=="yes"){
                              controller.updateEMP.value=newValue??"No";
                            }else{
                              controller.updateEMP.value="No";
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
                          value: controller.updateEMP.value,
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
                                if(controller.panelManageEmployee.value.toLowerCase()=="yes"){
                                  controller.empPushBack.value=value;
                                }else{
                                  controller.empPushBack.value="No";
                                }
                              },
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if(controller.panelManageEmployee.value.toLowerCase()=="yes"){
                              controller.empPushBack.value=newValue??"No";
                            }else{
                              controller.empPushBack.value="No";
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
                          value: controller.empPushBack.value,
                          hint: "EMP Push Back",
                        ),
                        SizedBox(height: 8.r),
                        CustomUnderlineDropdownField(
                          items: ["No", "Yes",].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                              onTap: (){
                                if(controller.panelManageEmployee.value.toLowerCase()=="yes"){
                                  controller.empApprove.value=value;
                                }else{
                                  controller.empApprove.value="No";
                                }
                              },
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if(controller.panelManageEmployee.value.toLowerCase()=="yes"){
                              controller.empApprove.value=newValue??"No";
                            }else{
                              controller.empApprove.value="No";
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
                          value: controller.empApprove.value,
                          hint: "EMP Approve",
                        ),
                        SizedBox(height: 8.r),
                        CustomUnderlineDropdownField(
                          items: ["No", "Yes",].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                              onTap: (){
                                if(controller.panelManageEmployee.value.toLowerCase()=="yes"){
                                  controller.empPendingApprove.value=value;
                                }else{
                                  controller.empPendingApprove.value="No";
                                }
                              },
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if(controller.panelManageEmployee.value.toLowerCase()=="yes"){
                              controller.empPendingApprove.value=newValue??"No";
                            }else{
                              controller.empPendingApprove.value="No";
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
                          value: controller.empPendingApprove.value,
                          hint: "EMP Pending Approve",
                        ),
                        SizedBox(height: 8.r),
                        CustomUnderlineDropdownField(
                          items: ["No", "Yes",].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                              onTap: (){
                                if(controller.panelManagePartner.value.toLowerCase()=="yes"){
                                  controller.partnerViewAll.value=value;
                                }else{
                                  controller.partnerViewAll.value="No";
                                }
                              },
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if(controller.panelManagePartner.value.toLowerCase()=="yes"){
                              controller.partnerViewAll.value=newValue??"No";
                            }else{
                              controller.partnerViewAll.value="No";
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
                          value: controller.partnerViewAll.value,
                          hint: "Partner View All",
                        ),
                        SizedBox(height: 8.r),
                        CustomUnderlineDropdownField(
                          items: ["No", "Yes",].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                              onTap: (){
                                if(controller.panelManagePartner.value.toLowerCase()=="yes"){
                                  controller.partnerAdd.value=value;
                                }else{
                                  controller.partnerAdd.value="No";
                                }
                              },
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if(controller.panelManagePartner.value.toLowerCase()=="yes"){
                              controller.partnerAdd.value=newValue??"No";
                            }else{
                              controller.partnerAdd.value="No";
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
                          value: controller.partnerAdd.value,
                          hint: "Partner Add",
                        ),
                        SizedBox(height: 8.r),
                        CustomUnderlineDropdownField(
                          items: ["No", "Yes",].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                              onTap: (){
                                if(controller.panelManagePartner.value.toLowerCase()=="yes"){
                                  controller.partnerUpdate.value=value;
                                }else{
                                  controller.partnerUpdate.value="No";
                                }
                              },
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if(controller.panelManagePartner.value.toLowerCase()=="yes"){
                              controller.partnerUpdate.value=newValue??"No";
                            }else{
                              controller.partnerUpdate.value="No";
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
                          value: controller.partnerUpdate.value,
                          hint: "Partner Update",
                        ),
                        SizedBox(height: 8.r),
                        CustomUnderlineDropdownField(
                          items: ["No", "Yes",].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                              onTap: (){
                                if(controller.panelManagePartner.value.toLowerCase()=="yes"){
                                  controller.partnerPushBack.value=value;
                                }else{
                                  controller.partnerPushBack.value="No";
                                }
                              },
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if(controller.panelManagePartner.value.toLowerCase()=="yes"){
                              controller.partnerPushBack.value=newValue??"No";
                            }else{
                              controller.partnerPushBack.value="No";
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
                          value: controller.partnerPushBack.value,
                          hint: "Partner Push Back",
                        ),
                        SizedBox(height: 8.r),
                        CustomUnderlineDropdownField(
                          items: ["No", "Yes",].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                              onTap: (){
                                if(controller.panelManagePartner.value.toLowerCase()=="yes"){
                                  controller.partnerPendingApproval.value=value;
                                }else{
                                  controller.partnerPendingApproval.value="No";
                                }
                              },
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if(controller.panelManagePartner.value.toLowerCase()=="yes"){
                              controller.partnerPendingApproval.value=newValue??"No";
                            }else{
                              controller.partnerPendingApproval.value="No";
                              confirmationDialogBox(
                                context,
                                "Please Select Partner Panel",
                                "Check the partner panel first otherwise you cannot use any other functionality.",
                              );
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select partner pending approval';
                            }
                            return null;
                          },
                          value: controller.partnerPendingApproval.value,
                          hint: "Partner Pending Approval",
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
                                controller.assignAllLead.value=value;
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
                          value: controller.assignAllLead.value,
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
                                controller.assignMyLead.value=value;
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
                          value: controller.assignMyLead.value,
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
                                controller.assignMyTeamLead.value=value;
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
                          value: controller.assignMyTeamLead.value,
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
                                controller.assignMyPartnerLead.value=value;
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
                          value: controller.assignMyPartnerLead.value,
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
                                controller.addLead.value=value;
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
                          value: controller.addLead.value,
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
                                controller.myLead.value=value;
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
                          value: controller.myLead.value,
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
                                controller.myTeamLead.value=value;
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
                          value: controller.myTeamLead.value,
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
                                controller.myPartnerLead.value=value;
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
                          value: controller.myPartnerLead.value,
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
                                controller.AllCust.value=value;
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
                          value: controller.AllCust.value,
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
                                controller.myCust.value=value;
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
                          value: controller.myCust.value,
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
                                controller.myTeamCust.value=value;
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
                          value: controller.myTeamCust.value,
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
                                controller.myPartnerCust.value=value;
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
                          value: controller.myPartnerCust.value,
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
                                controller.mySales.value=value;
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
                          value: controller.mySales.value,
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
                                controller.incentiveMGMTView.value=value;
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
                          value: controller.incentiveMGMTView.value,
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
                                controller.incentiveMGMTEdit.value=value;
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
                          value: controller.incentiveMGMTEdit.value,
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
                                controller.applySelfLoan.value=value;
                              },
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            print("jhkh $newValue");
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select apply self loan';
                            }
                            return null;
                          },
                          value: controller.applySelfLoan.value,
                          hint: "Apply Self Loan",
                        ),
                        SizedBox(height: 8.r),
                        CustomUnderlineDropdownField(
                          items: ["No", "Yes",].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                              onTap: (){
                                print("value $value");
                                controller.assignmentChangeApproval.value=value;
                              },
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            print("jhkh $newValue");
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select assignment change approval';
                            }
                            return null;
                          },
                          value: controller.assignmentChangeApproval.value,
                          hint: "Assignment Change Approval",
                        ),
                        SizedBox(height: 8.r),
                        CustomUnderlineDropdownField(
                          items: ["No", "Yes",].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                              onTap: (){
                                print("value $value");
                                controller.panelManagePartner.value=value;
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
                          value: controller.panelManagePartner.value,
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
                                controller.panelManageEmployee.value=value;
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
                          value: controller.panelManageEmployee.value,
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
                                controller.panelManageCustomer.value=value;
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
                          value: controller.panelManageCustomer.value,
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
                                controller.NewLeadTab.value=value;
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
                          value: controller.NewLeadTab.value,
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
                                controller.VerificationTab.value=value;
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
                          value: controller.VerificationTab.value,
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
                                controller.DisbursedTab.value=value;
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
                          value: controller.DisbursedTab.value,
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
                                controller.IncentiveTab.value=value;
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
                          value: controller.IncentiveTab.value,
                          hint: "Incentive Lead Tab",
                        ),
                        SizedBox(height: 15.r),
                        CustomerCountView(
                          title: "Access changes Count".tr,
                          count: "${partnerController.employeeDetails.value.data.accessDefault.accessChangeCount??"NA"}",
                        ),
                        SizedBox(height: 15.r),
                        CustomerCountView(
                          title: "Access changes By".tr,
                          count: partnerController.employeeDetails.value.data.accessDefault.changeByName??"NA",
                          changes: partnerController.employeeDetails.value.data.accessDefault.accessChangeBy!=null&&
                              partnerController.employeeDetails.value.data.accessDefault.accessChangeBy!=""?
                          " (${partnerController.employeeDetails.value.data.accessDefault.accessChangeBy??"NA"})" :"",
                        ),
                        SizedBox(height: 15.r),
                        CustomerCountView(
                          title: "Access changes By".tr,
                          changes: partnerController.employeeDetails.value.data.accessDefault.accessChangeDateTime??"NA",
                        ),
                      ],
                    );
                  }
              ),
            ),
            SizedBox(height: 20.r),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.r),
              child: CustomButton(
                title: "Update".tr,
                background: true,
                height: 38.r,
                radius: 0,
                onTap: ()async{
                  bool status = await  controller.employeePushBackAccessUpdateNetworkApi(widget.empId);
                  if (status == true) {
                    partnerController.approvalReason.clear();
                    partnerController.employeeId.clear();
                    partnerController.check_assign_approval_exist_model.value.data.clear();
                    _showDisbursedEditTeleBottomSheet(context);
                  }
                },
              ),
            ),
            SizedBox(height: 20.r),
          ],
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
                    key: formKeyAssignChangeApprovalFormKey,
                    child: TextFormField(
                      controller: partnerController.employeeId,
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
                            if (formKeyAssignChangeApprovalFormKey.currentState != null && formKeyAssignChangeApprovalFormKey.currentState!.validate()) {
                              partnerController.checkAssignmentApprovalExistNetworkApi(partnerController.employeeId.text);
                            }
                          },
                          child: Text("Check", style: fontBold.copyWith(color: AllColors.themeColor),),
                        ),
                      ),
                    ),
                  ),
                  GetBuilder<PartnerController>(builder: (controller){
                    return Obx(() => controller.check_assign_approval_exist_model.value.data.isNotEmpty?
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
                    );
                  }),
                  SizedBox(height: 20.r),
                  TextField(
                    controller: partnerController.approvalReason,
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Mention reason for assignment change",
                      isDense: true,
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
                        if(partnerController.check_assign_approval_exist_model.value.data.isNotEmpty){
                          bool status = await partnerController.employeeApprovalRequestNetworkApi(
                            partnerController.employeeDetails.value.data.basicDetails.eid,
                            "request",
                            partnerController.check_assign_approval_exist_model.value.data[0].eid.toString(),
                            partnerController.approvalReason.text,
                            GetStorage().read(AppConstant.cust_id).toString(),
                          );
                          if(status==true) {
                            if(widget.pageName.toString()=="allEmployee"){
                              Get.off(()=> const DashboardScreen());
                              employeeHomeTab.value=4;
                            }else if(widget.pageName.toString()=="employeeApprove"){
                              Get.off(()=> const DashboardScreen());
                              employeeHomeTab.value=3;
                            }else if(widget.pageName.toString()=="employeeRequest"){
                              Get.off(()=> const DashboardScreen());
                              employeeHomeTab.value=2;
                            }else{
                              Get.off(()=> const DashboardScreen());
                              employeeHomeTab.value=3;
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
          Text("$title : ",style: fontRegular.copyWith(fontSize: 11.r),),
          Text(count.toString(),style: fontBold.copyWith(fontSize: 12.r),),
          Expanded(child: Text(changes.toString(),style: fontMedium.copyWith(fontSize: 11.r),overflow: TextOverflow.ellipsis, maxLines: 1,)),
        ],
      ),
    );
  }
}

