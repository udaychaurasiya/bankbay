import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/models/employee_details_model.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmployeePushBackAccessViewScreen extends StatelessWidget {
  final EmployeeDetailsData empData;
  const EmployeePushBackAccessViewScreen({super.key, required this.empData});

  @override
  Widget build(BuildContext context) {
    TextEditingController empViewAll = TextEditingController();
    TextEditingController addEmp = TextEditingController();
    TextEditingController updateEmp = TextEditingController();
    TextEditingController empPushBack = TextEditingController();
    TextEditingController empApprove = TextEditingController();
    TextEditingController empPendingApprove = TextEditingController();
    TextEditingController partnerViewAll = TextEditingController();
    TextEditingController partnerAdd = TextEditingController();
    TextEditingController partnerUpdate = TextEditingController();
    TextEditingController partnerPushBack = TextEditingController();
    TextEditingController unassignedLeads = TextEditingController();
    TextEditingController assignAllLead = TextEditingController();
    TextEditingController assignMyLead = TextEditingController();
    TextEditingController assignMyTeamLead = TextEditingController();
    TextEditingController assignMyPartnerLead = TextEditingController();
    TextEditingController addLead = TextEditingController();
    TextEditingController myLead = TextEditingController();
    TextEditingController myTeamLead = TextEditingController();
    TextEditingController myPartnerLead = TextEditingController();
    TextEditingController allCust = TextEditingController();
    TextEditingController myCust = TextEditingController();
    TextEditingController myTeamCust = TextEditingController();
    TextEditingController myPartnerCust = TextEditingController();
    TextEditingController mySales = TextEditingController();
    TextEditingController incentiveMgmtView = TextEditingController();
    TextEditingController incentiveMgmtEdit = TextEditingController();
    TextEditingController panelManagerPartner = TextEditingController();
    TextEditingController panelManagerCustomer = TextEditingController();
    TextEditingController newLeadTab = TextEditingController();
    TextEditingController verificationTab = TextEditingController();
    TextEditingController disbursedTab = TextEditingController();
    TextEditingController incentiveTab = TextEditingController();

    return GetBuilder<LoginController>(
      builder: (controller){
        empViewAll.text = (empData.accessDefault.empViewAll!=null&&empData.accessDefault.empViewAll!=""?empData.accessDefault.empViewAll.toString().capitalize:"No").toString();
        addEmp.text = (empData.accessDefault.addEmp!=null&&empData.accessDefault.addEmp!=""?empData.accessDefault.addEmp.toString().capitalize:"No").toString();
        updateEmp.text = (empData.accessDefault.updateEmp!=null&&empData.accessDefault.updateEmp!=""?empData.accessDefault.updateEmp.toString().capitalize:"No").toString();
        empPushBack.text = (empData.accessDefault.empPushBack!=null&&empData.accessDefault.empPushBack!=""?empData.accessDefault.empPushBack.toString().capitalize:"No").toString();
        empApprove.text = (empData.accessDefault.empApprove!=null&&empData.accessDefault.empApprove!=""?empData.accessDefault.empApprove.toString().capitalize:"No").toString();
        empPendingApprove.text = (empData.accessDefault.empPendingApproval!=null&&empData.accessDefault.empPendingApproval!=""?empData.accessDefault.empPendingApproval.toString().capitalize:"No").toString();
        partnerViewAll.text = (empData.accessDefault.partnerViewAll!=null&&empData.accessDefault.partnerViewAll!=""?empData.accessDefault.partnerViewAll.toString().capitalize:"No").toString();
        partnerAdd.text = (empData.accessDefault.partnerAdd!=null&&empData.accessDefault.partnerAdd!=""?empData.accessDefault.partnerAdd.toString().capitalize:"No").toString();
        partnerUpdate.text = (empData.accessDefault.partnerUpdate!=null&&empData.accessDefault.partnerUpdate!=""?empData.accessDefault.partnerUpdate.toString().capitalize:"No").toString();
        partnerPushBack.text = (empData.accessDefault.partnerPushBack!=null&&empData.accessDefault.partnerPushBack!=""?empData.accessDefault.partnerPushBack.toString().capitalize:"No").toString();
        unassignedLeads.text = (empData.accessDefault.unassignedLeads!=null&&empData.accessDefault.unassignedLeads!=""?empData.accessDefault.unassignedLeads.toString().capitalize:"No").toString();
        assignAllLead.text = (empData.accessDefault.assignAllLead!=null&&empData.accessDefault.assignAllLead!=""?empData.accessDefault.assignAllLead.toString().capitalize:"No").toString();
        assignMyLead.text = (empData.accessDefault.assignMyLead!=null&&empData.accessDefault.assignMyLead!=""?empData.accessDefault.assignMyLead.toString().capitalize:"No").toString();
        assignMyTeamLead.text = (empData.accessDefault.assignMyteamLead!=null&&empData.accessDefault.assignMyteamLead!=""?empData.accessDefault.assignMyteamLead.toString().capitalize:"No").toString();
        assignMyPartnerLead.text = (empData.accessDefault.assignMypartnerLead!=null&&empData.accessDefault.assignMypartnerLead!=""?empData.accessDefault.assignMypartnerLead.toString().capitalize:"No").toString();
        addLead.text = (empData.accessDefault.addLead!=null&&empData.accessDefault.addLead!=""?empData.accessDefault.addLead.toString().capitalize:"No").toString();
        myLead.text = (empData.accessDefault.myLead!=null&&empData.accessDefault.myLead!=""?empData.accessDefault.myLead.toString().capitalize:"No").toString();
        myTeamLead.text = (empData.accessDefault.myteamLead!=null&&empData.accessDefault.myteamLead!=""?empData.accessDefault.myteamLead.toString().capitalize:"No").toString();
        myPartnerLead.text = (empData.accessDefault.mypartnerLead!=null&&empData.accessDefault.mypartnerLead!=""?empData.accessDefault.mypartnerLead.toString().capitalize:"No").toString();
        allCust.text = (empData.accessDefault.allCust!=null&&empData.accessDefault.allCust!=""?empData.accessDefault.allCust.toString().capitalize:"No").toString();
        myCust.text = (empData.accessDefault.myCust!=null&&empData.accessDefault.myCust!=""?empData.accessDefault.myCust.toString().capitalize:"No").toString();
        myTeamCust.text = (empData.accessDefault.myteamCust!=null&&empData.accessDefault.myteamCust!=""?empData.accessDefault.myteamCust.toString().capitalize:"No").toString();
        myPartnerCust.text = (empData.accessDefault.mypartnerCust!=null&&empData.accessDefault.mypartnerCust!=""?empData.accessDefault.mypartnerCust.toString().capitalize:"No").toString();
        mySales.text = (empData.accessDefault.mySales!=null&&empData.accessDefault.mySales!=""?empData.accessDefault.mySales.toString().capitalize:"No").toString();
        incentiveMgmtView.text = (empData.accessDefault.incentiveMgmtView!=null&&empData.accessDefault.incentiveMgmtView!=""?empData.accessDefault.incentiveMgmtView.toString().capitalize:"No").toString();
        incentiveMgmtEdit.text = (empData.accessDefault.incentiveMgmtEdit!=null&&empData.accessDefault.incentiveMgmtEdit!=""?empData.accessDefault.incentiveMgmtEdit.toString().capitalize:"No").toString();
        panelManagerPartner.text = (empData.accessDefault.panelManagePartner!=null&&empData.accessDefault.panelManagePartner!=""?empData.accessDefault.panelManagePartner.toString().capitalize:"No").toString();
        panelManagerCustomer.text = (empData.accessDefault.panelManageCustomer!=null&&empData.accessDefault.panelManageCustomer!=""?empData.accessDefault.panelManageCustomer.toString().capitalize:"No").toString();
        newLeadTab.text = (controller.add_employee_access_model.value.data.newLeadTab!=null&&controller.add_employee_access_model.value.data.newLeadTab!=""?controller.add_employee_access_model.value.data.newLeadTab.toString().capitalize:"No").toString();
        verificationTab.text = (controller.add_employee_access_model.value.data.verificationLeadTab!=null&&controller.add_employee_access_model.value.data.verificationLeadTab!=""?controller.add_employee_access_model.value.data.verificationLeadTab.toString().capitalize:"No").toString();
        disbursedTab.text = (controller.add_employee_access_model.value.data.disbursedLeadTab!=null&&controller.add_employee_access_model.value.data.disbursedLeadTab!=""?controller.add_employee_access_model.value.data.disbursedLeadTab.toString().capitalize:"No").toString();
        incentiveTab.text = (controller.add_employee_access_model.value.data.incentiveLeadTab!=null&&controller.add_employee_access_model.value.data.incentiveLeadTab!=""?controller.add_employee_access_model.value.data.incentiveLeadTab.toString().capitalize:"No").toString();

        return Column(
          children: [
            SizedBox(height: 10.r),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0.r),
              child: Column(
                children: [
                  UnderLineTextField(
                    labelText: "EMP View All".tr,
                    hint: "EMP View All".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: empViewAll,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "Add EMP".tr,
                    hint: "Add EMP".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: addEmp,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "Update EMP".tr,
                    hint: "Update EMP".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: updateEmp,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "EMP Push Back".tr,
                    hint: "EMP Push Back".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: empPushBack,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "EMP Approve".tr,
                    hint: "EMP Approve".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: empApprove,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText:  "EMP Pending Approve".tr,
                    hint:  "EMP Pending Approve".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: empPendingApprove,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText:  "Partner View All".tr,
                    hint:  "Partner View All".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: partnerViewAll,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText:  "Partner Add".tr,
                    hint:  "Partner Add".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: partnerAdd,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText:  "Partner Update".tr,
                    hint:  "Partner Update".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: partnerUpdate,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText:  "Partner Push Back".tr,
                    hint:  "Partner Push Back".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: partnerPushBack,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText:  "Unassigned Leads".tr,
                    hint:  "Unassigned Leads".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: unassignedLeads,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "Assign All Lead".tr,
                    hint: "Assign All Lead".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: assignAllLead,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "Assign My Lead".tr,
                    hint: "Assign My Lead".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: assignMyLead,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "Assign My Team Lead".tr,
                    hint: "Assign My Team Lead".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: assignMyTeamLead,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "Assign My Partner Lead".tr,
                    hint: "Assign My Partner Lead".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: assignMyPartnerLead,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "Add Lead".tr,
                    hint: "Add Lead".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: addLead,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "My Lead".tr,
                    hint: "My Lead".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: myLead,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "My Team Lead".tr,
                    hint: "My Team Lead".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: myTeamLead,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "My Partner Lead".tr,
                    hint: "My Partner Lead".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: myPartnerLead,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "All Cust".tr,
                    hint: "All Cust".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: allCust,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "My Cust".tr,
                    hint: "My Cust".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: myCust,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "My Team Cust".tr,
                    hint: "My Team Cust".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: myTeamCust,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "My Partner Cust".tr,
                    hint: "My Partner Cust".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: myPartnerCust,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "My Sales".tr,
                    hint: "My Sales".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: mySales,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "Incentive MGMT View".tr,
                    hint: "Incentive MGMT View".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: incentiveMgmtView,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "Incentive MGMT Edit".tr,
                    hint: "Incentive MGMT Edit".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: incentiveMgmtEdit,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "Panel Manage Partner".tr,
                    hint: "Panel Manage Partner".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: panelManagerPartner,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "Panel Manage Customer".tr,
                    hint: "Panel Manage Customer".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: panelManagerCustomer,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "New Lead Tab".tr,
                    hint: "New Lead Tab".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: newLeadTab,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "Verification Lead Tab".tr,
                    hint: "Verification Lead Tab".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: verificationTab,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "Disbursed Lead Tab".tr,
                    hint: "Disbursed Lead Tab".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: disbursedTab,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),
                  UnderLineTextField(
                    labelText: "Incentive Lead Tab".tr,
                    hint: "Incentive Lead Tab".tr,
                    label: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    isRead: true,
                    controller: incentiveTab,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 10.r),

                  CustomerCountView(
                    title: "Access changes Count".tr,
                    count:  "${empData.accessSpecial.accessChangeCount??"00"}",
                  ),
                  SizedBox(height: 10.r),
                  CustomerCountView(
                    title: "Access changes By".tr,
                    count:  empData.accessSpecial.userId??"NA",
                    changes:  "(${empData.accessSpecial.accessChangeCount??"00"})",
                  ),
                  SizedBox(height: 10.r),
                  CustomerCountView(
                    title: "Access changes By".tr,
                    changes: "${empData.accessSpecial.accessChangeDateTime??"NA"}",
                  ),
                ],
              ),
            ),
            // SizedBox(height: 15.r),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal:15.0.r),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       CustomButton(
            //         title: "Approve".tr,
            //         width: 120.r,
            //         bgColor: AllColors.green,
            //         background: false,
            //         height: 35.r,
            //         radius: 0,
            //         onTap: (){
            //           print("add emp type 1");
            //           controller.addEmployeeAboutNetworkApi("1");
            //         },
            //       ),
            //       CustomButton(
            //         title: "Push back".tr,
            //         width: 120.r,
            //         // bgColor: AllColors.green,
            //         background: true,
            //         height: 35.r,
            //         radius: 0,
            //         onTap: ()async{
            //           print("add emp type 2");
            //           // if (formKeyEducation.currentState != null && formKeyEducation.currentState!.validate()) {
            //           //   bool status = await controller.addEmployeeAboutNetworkApi("2");
            //           //   if (status == true) {
            //           //     // Get.offAll(() => const DashboardScreen());
            //           //   }
            //           // }
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 20.r),
          ],
        );
      },
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

