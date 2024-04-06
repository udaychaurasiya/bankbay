// To parse this JSON data, do
//
//     final addEmployeePermissionAccessModel = addEmployeePermissionAccessModelFromJson(jsonString);

import 'dart:convert';

AddEmployeePermissionAccessModel addEmployeePermissionAccessModelFromJson(String str) => AddEmployeePermissionAccessModel.fromJson(json.decode(str));

String addEmployeePermissionAccessModelToJson(AddEmployeePermissionAccessModel data) => json.encode(data.toJson());

class AddEmployeePermissionAccessModel {
  String? message;
  String? status;
  PermissionAccessData data;

  AddEmployeePermissionAccessModel({
    this.message,
    this.status,
    required this.data,
  });

  factory AddEmployeePermissionAccessModel.fromJson(Map<String, dynamic> json) => AddEmployeePermissionAccessModel(
    message: json["message"],
    status: json["status"],
    data: PermissionAccessData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data.toJson(),
  };
}

class PermissionAccessData {
  String? empViewAll;
  String? addEmp;
  String? updateEmp;
  String? empPushBack;
  String? empApprove;
  String? empPendingApproval;
  String? partnerViewAll;
  String? partnerAdd;
  String? partnerUpdate;
  String? partnerPushBack;
  String? partnerPendingApproval;
  String? unassignedLeads;
  String? assignAllLead;
  String? assignMyLead;
  String? assignMyteamLead;
  String? assignMypartnerLead;
  String? addLead;
  String? myLead;
  String? myteamLead;
  String? mypartnerLead;
  String? allCust;
  String? myCust;
  String? myteamCust;
  String? mypartnerCust;
  String? mySales;
  String? incentiveMgmtView;
  String? incentiveMgmtEdit;
  String? applySelfLoan;
  String? panelManageEmployee;
  String? panelManagePartner;
  String? panelManageCustomer;
  String? newLeadTab;
  String? verificationLeadTab;
  String? disbursedLeadTab;
  String? incentiveLeadTab;
  String? assignementChangeApproval;
  dynamic accessChangeCount;
  String? accessChangeBy;
  String? accessChangeDateTime;

  PermissionAccessData({
    this.empViewAll,
    this.addEmp,
    this.updateEmp,
    this.empPushBack,
    this.empApprove,
    this.empPendingApproval,
    this.partnerViewAll,
    this.partnerAdd,
    this.partnerUpdate,
    this.partnerPushBack,
    this.partnerPendingApproval,
    this.unassignedLeads,
    this.assignAllLead,
    this.assignMyLead,
    this.assignMyteamLead,
    this.assignMypartnerLead,
    this.addLead,
    this.myLead,
    this.myteamLead,
    this.mypartnerLead,
    this.allCust,
    this.myCust,
    this.myteamCust,
    this.mypartnerCust,
    this.mySales,
    this.incentiveMgmtView,
    this.incentiveMgmtEdit,
    this.applySelfLoan,
    this.panelManageEmployee,
    this.panelManagePartner,
    this.panelManageCustomer,
    this.newLeadTab,
    this.verificationLeadTab,
    this.disbursedLeadTab,
    this.incentiveLeadTab,
    this.assignementChangeApproval,
    this.accessChangeCount,
    this.accessChangeBy,
    this.accessChangeDateTime,
  });

  factory PermissionAccessData.fromJson(Map<String, dynamic> json) => PermissionAccessData(
    empViewAll: json["emp_view_all"],
    addEmp: json["add_emp"],
    updateEmp: json["update_emp"],
    empPushBack: json["emp_push_back"],
    empApprove: json["emp_approve"],
    empPendingApproval: json["emp_pending_approval"],
    partnerViewAll: json["partner_view_all"],
    partnerAdd: json["partner_add"],
    partnerUpdate: json["partner_update"],
    partnerPushBack: json["partner_push_back"],
    partnerPendingApproval: json["partner_pending_approval"],
    unassignedLeads: json["unassigned_leads"],
    assignAllLead: json["assign_all_lead"],
    assignMyLead: json["assign_my_lead"],
    assignMyteamLead: json["assign_myteam_lead"],
    assignMypartnerLead: json["assign_mypartner_lead"],
    addLead: json["add_lead"],
    myLead: json["my_lead"],
    myteamLead: json["myteam_lead"],
    mypartnerLead: json["mypartner_lead"],
    allCust: json["all_cust"],
    myCust: json["my_cust"],
    myteamCust: json["myteam_cust"],
    mypartnerCust: json["mypartner_cust"],
    mySales: json["my_sales"],
    incentiveMgmtView: json["incentive_mgmt_view"],
    incentiveMgmtEdit: json["incentive_mgmt_edit"],
    applySelfLoan: json["apply_self_loan"],
    panelManageEmployee: json["panel_manage_employee"],
    panelManagePartner: json["panel_manage_partner"],
    panelManageCustomer: json["panel_manage_customer"],
    newLeadTab: json["new_lead_tab"],
    verificationLeadTab: json["verification_lead_tab"],
    disbursedLeadTab: json["disbursed_lead_tab"],
    incentiveLeadTab: json["incentive_lead_tab"],
    assignementChangeApproval: json["assignement_change_approval"],
    accessChangeCount: json["access_change_count"],
    accessChangeBy: json["access_change_by"],
    accessChangeDateTime: json["access_change_date_time"],
  );

  Map<String, dynamic> toJson() => {
    "emp_view_all": empViewAll,
    "add_emp": addEmp,
    "update_emp": updateEmp,
    "emp_push_back": empPushBack,
    "emp_approve": empApprove,
    "emp_pending_approval": empPendingApproval,
    "partner_view_all": partnerViewAll,
    "partner_add": partnerAdd,
    "partner_update": partnerUpdate,
    "partner_push_back": partnerPushBack,
    "partner_pending_approval": partnerPendingApproval,
    "unassigned_leads": unassignedLeads,
    "assign_all_lead": assignAllLead,
    "assign_my_lead": assignMyLead,
    "assign_myteam_lead": assignMyteamLead,
    "assign_mypartner_lead": assignMypartnerLead,
    "add_lead": addLead,
    "my_lead": myLead,
    "myteam_lead": myteamLead,
    "mypartner_lead": mypartnerLead,
    "all_cust": allCust,
    "my_cust": myCust,
    "myteam_cust": myteamCust,
    "mypartner_cust": mypartnerCust,
    "my_sales": mySales,
    "incentive_mgmt_view": incentiveMgmtView,
    "incentive_mgmt_edit": incentiveMgmtEdit,
    "apply_self_loan": applySelfLoan,
    "panel_manage_employee": panelManageEmployee,
    "panel_manage_partner": panelManagePartner,
    "panel_manage_customer": panelManageCustomer,
    "new_lead_tab": newLeadTab,
    "verification_lead_tab": verificationLeadTab,
    "disbursed_lead_tab": disbursedLeadTab,
    "incentive_lead_tab": incentiveLeadTab,
    "assignement_change_approval": assignementChangeApproval,
    "access_change_count": accessChangeCount,
    "access_change_by": accessChangeBy,
    "access_change_date_time": accessChangeDateTime,
  };
}