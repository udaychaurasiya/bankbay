// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:bank_bay/models/lock_unlock_model.dart';
import 'package:bank_bay/models/my_earning_model.dart';
import 'package:bank_bay/utils/BaseClient.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';

class PermissionController extends GetxController{
  GetStorage storage = GetStorage();
  /// lock unlock lead api integrate
  var lockUnlockModel = LockUnlockLeadModel(data: LockUnlockData(history: [])).obs;
  Future<bool> lockUnlockLeadNetworkApi(leadId,status) async {
    var bodyRequest = {
      "lead_id": leadId.toString(),
      "locked_by": storage.read(AppConstant.cust_id).toString().trim(),
      "lock_status": status.toString(),
    };
    print("bodyRequest ===============>>>>>>>>>>>>> \n$bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.LOCK_UNLOCK_LEAD, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==================>>>>>>>>>>>>> \n$response");
    if (jsonDecode(response)["status"] == "1") {
      // BaseController().successSnack(jsonDecode(response)["message"]);
      lockUnlockModel.value = lockUnlockLeadModelFromJson(response);
      lockUnlockModel.refresh();
      update();
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"].toString());
    return false;
  }

  /// lock unlock lead api integrate
  Future<bool> userPermissionNetworkApi(String customerId)async{
    var response=await BaseClient().get("${AppConstants.USER_PERMISSION_API}?customer_id=$customerId")
        .catchError(BaseController().handleError);
    print("responsePermissionNetworkApi================>>>>>>>>>>>>> $response");
    if(jsonDecode(response)["status"]=="1")
    {
      storage.write(AppConstant.emp_view_all, jsonDecode(response)["data"]["emp_view_all"].toString());
      storage.write(AppConstant.add_emp, jsonDecode(response)["data"]["add_emp"].toString());
      storage.write(AppConstant.update_emp, jsonDecode(response)["data"]["update_emp"].toString());
      storage.write(AppConstant.emp_push_back, jsonDecode(response)["data"]["emp_push_back"].toString());
      storage.write(AppConstant.emp_approve, jsonDecode(response)["data"]["emp_approve"].toString());
      storage.write(AppConstant.emp_pending_approval, jsonDecode(response)["data"]["emp_pending_approval"].toString());
      storage.write(AppConstant.partner_view_all, jsonDecode(response)["data"]["partner_view_all"].toString());
      storage.write(AppConstant.partner_add, jsonDecode(response)["data"]["partner_add"].toString());
      storage.write(AppConstant.partner_update, jsonDecode(response)["data"]["partner_update"].toString());
      storage.write(AppConstant.partner_push_back, jsonDecode(response)["data"]["partner_push_back"].toString());
      storage.write(AppConstant.partner_pending_approval, jsonDecode(response)["data"]["partner_pending_approval"].toString());
      storage.write(AppConstant.unassigned_leads, jsonDecode(response)["data"]["unassigned_leads"].toString());
      storage.write(AppConstant.assign_all_lead, jsonDecode(response)["data"]["assign_all_lead"].toString());
      storage.write(AppConstant.assign_my_lead, jsonDecode(response)["data"]["assign_my_lead"].toString());
      storage.write(AppConstant.assign_my_team_lead, jsonDecode(response)["data"]["assign_myteam_lead"].toString());
      storage.write(AppConstant.assign_my_partner_lead, jsonDecode(response)["data"]["assign_mypartner_lead"].toString());
      storage.write(AppConstant.add_lead, jsonDecode(response)["data"]["add_lead"].toString());
      storage.write(AppConstant.my_lead, jsonDecode(response)["data"]["my_lead"].toString());
      storage.write(AppConstant.my_team_lead, jsonDecode(response)["data"]["myteam_lead"].toString());
      storage.write(AppConstant.my_partner_lead, jsonDecode(response)["data"]["mypartner_lead"].toString());
      storage.write(AppConstant.all_cust, jsonDecode(response)["data"]["all_cust"].toString());
      storage.write(AppConstant.my_cust, jsonDecode(response)["data"]["my_cust"].toString());
      storage.write(AppConstant.my_team_cust, jsonDecode(response)["data"]["myteam_cust"].toString());
      storage.write(AppConstant.my_partner_cust, jsonDecode(response)["data"]["mypartner_cust"].toString());
      storage.write(AppConstant.my_sales, jsonDecode(response)["data"]["my_sales"].toString());
      storage.write(AppConstant.incentive_mgmt_view, jsonDecode(response)["data"]["incentive_mgmt_view"].toString());
      storage.write(AppConstant.incentive_mgmt_edit, jsonDecode(response)["data"]["incentive_mgmt_edit"].toString());
      storage.write(AppConstant.apply_self_loan, jsonDecode(response)["data"]["apply_self_loan"].toString());
      storage.write(AppConstant.panel_manage_employee, jsonDecode(response)["data"]["panel_manage_employee"].toString());
      storage.write(AppConstant.panel_manage_partner, jsonDecode(response)["data"]["panel_manage_partner"].toString());
      storage.write(AppConstant.panel_manage_customer, jsonDecode(response)["data"]["panel_manage_customer"].toString());
      storage.write(AppConstant.assignment_change_approval, jsonDecode(response)["data"]["assignement_change_approval"].toString());
      storage.write(AppConstant.newLeadTab, jsonDecode(response)["data"]["new_lead_tab"].toString());
      storage.write(AppConstant.verificationTab, jsonDecode(response)["data"]["verification_lead_tab"].toString());
      storage.write(AppConstant.disbursedTab, jsonDecode(response)["data"]["disbursed_lead_tab"].toString());
      storage.write(AppConstant.incentiveTab, jsonDecode(response)["data"]["incentive_lead_tab"].toString());
      // BaseController().successSnack(jsonDecode(response)["message"]);
      return true;
    }
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return  false;
  }

  /// lock unlock lead api integrate
  Future<bool> userPermissionCustomNetworkApi(String customerId)async{
    var response=await BaseClient().get("${AppConstants.USER_PERMISSION_API}?customer_id=$customerId")
        .catchError(BaseController().handleError);
    print("response ================>>>>>>>>>>>>> $response");
    if(jsonDecode(response)["status"]=="1")
    {
      storage.write(AppConstant.emp_view_all, jsonDecode(response)["data"]["emp_view_all"].toString());
      storage.write(AppConstant.add_emp, jsonDecode(response)["data"]["add_emp"].toString());
      storage.write(AppConstant.update_emp, jsonDecode(response)["data"]["update_emp"].toString());
      storage.write(AppConstant.emp_push_back, jsonDecode(response)["data"]["emp_push_back"].toString());
      storage.write(AppConstant.emp_approve, jsonDecode(response)["data"]["emp_approve"].toString());
      storage.write(AppConstant.emp_pending_approval, jsonDecode(response)["data"]["emp_pending_approval"].toString());
      storage.write(AppConstant.partner_view_all, jsonDecode(response)["data"]["partner_view_all"].toString());
      storage.write(AppConstant.partner_add, jsonDecode(response)["data"]["partner_add"].toString());
      storage.write(AppConstant.partner_update, jsonDecode(response)["data"]["partner_update"].toString());
      storage.write(AppConstant.partner_push_back, jsonDecode(response)["data"]["partner_push_back"].toString());
      storage.write(AppConstant.partner_pending_approval, jsonDecode(response)["data"]["partner_pending_approval"].toString());
      storage.write(AppConstant.unassigned_leads, jsonDecode(response)["data"]["unassigned_leads"].toString());
      storage.write(AppConstant.assign_all_lead, jsonDecode(response)["data"]["assign_all_lead"].toString());
      storage.write(AppConstant.assign_my_lead, jsonDecode(response)["data"]["assign_my_lead"].toString());
      storage.write(AppConstant.assign_my_team_lead, jsonDecode(response)["data"]["assign_myteam_lead"].toString());
      storage.write(AppConstant.assign_my_partner_lead, jsonDecode(response)["data"]["assign_mypartner_lead"].toString());
      storage.write(AppConstant.add_lead, jsonDecode(response)["data"]["add_lead"].toString());
      storage.write(AppConstant.my_lead, jsonDecode(response)["data"]["my_lead"].toString());
      storage.write(AppConstant.my_team_lead, jsonDecode(response)["data"]["myteam_lead"].toString());
      storage.write(AppConstant.my_partner_lead, jsonDecode(response)["data"]["mypartner_lead"].toString());
      storage.write(AppConstant.all_cust, jsonDecode(response)["data"]["all_cust"].toString());
      storage.write(AppConstant.my_cust, jsonDecode(response)["data"]["my_cust"].toString());
      storage.write(AppConstant.my_team_cust, jsonDecode(response)["data"]["myteam_cust"].toString());
      storage.write(AppConstant.my_partner_cust, jsonDecode(response)["data"]["mypartner_cust"].toString());
      storage.write(AppConstant.my_sales, jsonDecode(response)["data"]["my_sales"].toString());
      storage.write(AppConstant.incentive_mgmt_view, jsonDecode(response)["data"]["incentive_mgmt_view"].toString());
      storage.write(AppConstant.incentive_mgmt_edit, jsonDecode(response)["data"]["incentive_mgmt_edit"].toString());
      storage.write(AppConstant.apply_self_loan, jsonDecode(response)["data"]["apply_self_loan"].toString());
      storage.write(AppConstant.assignment_change_approval, jsonDecode(response)["data"]["assignement_change_approval"].toString());
      storage.write(AppConstant.newLeadTab, jsonDecode(response)["data"]["new_lead_tab"].toString());
      storage.write(AppConstant.verificationTab, jsonDecode(response)["data"]["verification_lead_tab"].toString());
      storage.write(AppConstant.disbursedTab, jsonDecode(response)["data"]["disbursed_lead_tab"].toString());
      storage.write(AppConstant.incentiveTab, jsonDecode(response)["data"]["incentive_lead_tab"].toString());
      // BaseController().successSnack(jsonDecode(response)["message"]);
      return true;
    }
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return  false;
  }



  /// lock unlock lead api integrate
  var my_earning_model = MyEarningsModel(data: []).obs;
  RxBool my_earning_loader = false.obs;
  Future<bool> getMyEarningsNetworkApi()async{
    my_earning_model.value.data.clear();
    my_earning_loader.value=false;
    var response=await BaseClient().get("${AppConstants.GET_MY_EARNINGS}?cust_id=${GetStorage().read(AppConstant.cust_id.toString())}")
        .catchError(BaseController().handleError);
    my_earning_loader.value=true;
    print("response ================>>>>>>>>>>>>> $response");
    if(jsonDecode(response)["status"]=="1")
    {
      my_earning_model.value = myEarningsModelFromJson(response);
      my_earning_model.refresh();
      update();
      return true;
    }
    my_earning_model.value = myEarningsModelFromJson(response);
    my_earning_model.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return  false;
  }


}