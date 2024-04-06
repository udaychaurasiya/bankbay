// ignore_for_file: deprecated_member_use

import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/widgets/LeadManager/approve_assign_lead.dart';
import 'package:bank_bay/widgets/LeadManager/disbursed.dart';
import 'package:bank_bay/widgets/LeadManager/incentive.dart';
import 'package:bank_bay/widgets/LeadManager/login_leads.dart';
import 'package:bank_bay/widgets/LeadManager/my_cust.dart';
import 'package:bank_bay/widgets/LeadManager/my_team.dart';
import 'package:bank_bay/widgets/LeadManager/my_leads.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'sanction.dart';
import 'team_leads.dart';
import 'new_lead.dart';
import 'verification.dart';

class LeadManagerScreen extends StatefulWidget {
  const LeadManagerScreen({super.key});

  @override
  State<LeadManagerScreen> createState() => _LeadManagerScreenState();
}
  RxInt leadManagerTab = 1.obs;
  final _controller = Get.find<PartnerController>();
class _LeadManagerScreenState extends State<LeadManagerScreen> {
  var loginController = Get.find<LoginController>();

  @override
  void initState() {
    if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10")) {
      _controller.getEmployeeDetailsNetworkApi(GetStorage().read(AppConstant.cust_id).toString());
    }else if(GetStorage().read(AppConstant.cust_id).toString().startsWith("C10")||GetStorage().read(AppConstant.cust_id).toString().startsWith("P10")){
      _controller.getCustomerDetailsNetworkApi(GetStorage().read(AppConstant.cust_id).toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.withOpacity(0.1),
      body: Obx(()=> Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40.r,
            color: AllColors.blue,
            padding: EdgeInsets.symmetric(horizontal: 5.r),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                InkWell(
                  onTap: (){
                    loginController.selectStageType.value = "All Stage";
                    loginController.selectLoanType.value = "All Loan";
                    loginController.leadsPageName.value="All";
                    loginController.filterTypeSelected.value ="All Source";
                    leadManagerTab.value=1;
                  },
                  child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 3.r, color: leadManagerTab.value==1?AllColors.yellow:AllColors.none))
                    ),
                    child: Text("My Leads".tr,
                      style:  fontSmall.copyWith(wordSpacing: 0,letterSpacing: 0.4,color: leadManagerTab.value==1?AllColors.white:AllColors.white.withOpacity(0.6)),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    loginController.selectLoanType.value = "All Loan";
                    loginController.selectStageType.value = "All Stage";
                    loginController.leadsPageName.value="All";
                    loginController.filterTypeSelected.value ="All Source";
                    leadManagerTab.value=2;
                  },
                  child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 3.r, color: leadManagerTab.value==2?AllColors.yellow:AllColors.none))
                    ),
                    child: Text("Team Leads".tr,
                      style:  fontSmall.copyWith(wordSpacing: 0,letterSpacing: 0.4,color: leadManagerTab.value==2?AllColors.white:AllColors.white.withOpacity(0.6)),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    loginController.selectLoanType.value = "All Loan";
                    loginController.leadsPageName.value="All";
                    loginController.filterTypeSelected.value ="All Source";
                    leadManagerTab.value=3;
                  },
                  child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 3.r,
                          color: leadManagerTab.value==3?AllColors.yellow:AllColors.none,
                        ),
                      ),
                    ),
                    child: Text("My Team".tr,
                      style:  fontSmall.copyWith(wordSpacing: 0,letterSpacing: 0.4,color: leadManagerTab.value==3?AllColors.white:AllColors.white.withOpacity(0.6)),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    loginController.selectLoanType.value = "All Loan";
                    loginController.leadsPageName.value="All";
                    loginController.filterTypeSelected.value ="All Source";
                    // loginController.my_cust_loader = 10;
                    leadManagerTab.value=4;
                  },
                  child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 3.r, color: leadManagerTab.value==4?AllColors.yellow:AllColors.none))
                    ),
                    child: Text("My Cust".tr,
                      style:  fontSmall.copyWith(wordSpacing: 0,letterSpacing: 0.4,color: leadManagerTab.value==4?AllColors.white:AllColors.white.withOpacity(0.6)),
                    ),
                  ),
                ),
                if(GetStorage().read(AppConstant.newLeadTab).toString().toLowerCase() == "yes")
                  InkWell(
                    onTap: (){
                      loginController.selectLoanType.value = "All Loan";
                      loginController.leadsPageName.value="All";
                      loginController.filterTypeSelected.value ="All Source";
                      loginController.allLeadsDataNext = 10;
                      leadManagerTab.value=5;
                    },
                    child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 3.r, color: leadManagerTab.value==5?AllColors.yellow:AllColors.none))
                    ),
                    child: Text("New Lead".tr,
                      style:  fontSmall.copyWith(wordSpacing: 0,letterSpacing: 0.4,color: leadManagerTab.value==5?AllColors.white:AllColors.white.withOpacity(0.6)),
                    ),
                  ),
                ),
                if(GetStorage().read(AppConstant.verificationTab).toString().toLowerCase() == "yes")
                  InkWell(
                    onTap: (){
                      loginController.selectLoanType.value = "All Loan";
                      loginController.leadsPageName.value="All";
                      loginController.filterTypeSelected.value ="All Source";
                      loginController.verificationDataNext = 10;
                      leadManagerTab.value=6;
                    },
                    child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 3.r, color: leadManagerTab.value==6?AllColors.yellow:AllColors.none))
                    ),
                    child: Text("Verification".tr,
                      style:  fontSmall.copyWith(wordSpacing: 0,letterSpacing: 0.4,color: leadManagerTab.value==6?AllColors.white:AllColors.white.withOpacity(0.6)),
                    ),
                  ),
                ),
                if(GetStorage().read(AppConstant.assignment_change_approval).toString().toLowerCase() == "yes")
                  InkWell(
                    onTap: (){
                      loginController.selectLoanType.value = "All Loan";
                      loginController.leadsPageName.value="All";
                      loginController.filterTypeSelected.value ="All Source";
                      loginController.loginLeadNext = 10;
                      leadManagerTab.value=7;
                    },
                    child: AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: leadManagerTab.value==7?AllColors.yellow:AllColors.none))
                      ),
                      child: Text("Login".tr,
                        style:  fontSmall.copyWith(wordSpacing: 0,letterSpacing: 0.4,color: leadManagerTab.value==7?AllColors.white:AllColors.white.withOpacity(0.6)),
                      ),
                    ),
                  ),
                if(GetStorage().read(AppConstant.assignment_change_approval).toString().toLowerCase() == "yes")
                  InkWell(
                    onTap: (){
                      loginController.selectLoanType.value = "All Loan";
                      loginController.leadsPageName.value="All";
                      loginController.filterTypeSelected.value ="All Source";
                      loginController.sanctionedLeadNext = 10;
                      leadManagerTab.value=8;
                    },
                    child: AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: leadManagerTab.value==8?AllColors.yellow:AllColors.none))
                      ),
                      child: Text("Sanction".tr,
                        style:  fontSmall.copyWith(wordSpacing: 0,letterSpacing: 0.4,color: leadManagerTab.value==8?AllColors.white:AllColors.white.withOpacity(0.6)),
                      ),
                    ),
                  ),
                if(GetStorage().read(AppConstant.disbursedTab).toString().toLowerCase() == "yes")
                  InkWell(
                    onTap: (){
                      loginController.selectLoanType.value = "All Loan";
                      loginController.leadsPageName.value="All";
                      loginController.filterTypeSelected.value ="All Source";
                      loginController.disbursedDataNext = 10;
                      leadManagerTab.value=9;
                    },
                    child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 3.r, color: leadManagerTab.value==9?AllColors.yellow:AllColors.none))
                    ),
                    child: Text("Disbursed".tr,
                      style:  fontSmall.copyWith(wordSpacing: 0,letterSpacing: 0.4,color: leadManagerTab.value==9?AllColors.white:AllColors.white.withOpacity(0.6)),
                    ),
                  ),
                ),
                if(GetStorage().read(AppConstant.incentiveTab).toString().toLowerCase() == "yes")
                  InkWell(
                    onTap: (){
                      loginController.selectLoanType.value = "All Loan";
                      loginController.leadsPageName.value="All";
                      loginController.filterTypeSelected.value ="All Source";
                      loginController.incentiveDataNext = 10;
                      leadManagerTab.value=10;
                    },
                    child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 3.r, color: leadManagerTab.value==10?AllColors.yellow:AllColors.none))
                    ),
                    child: Text("Incentive".tr,
                      style:  fontSmall.copyWith(wordSpacing: 0,letterSpacing: 0.4,color: leadManagerTab.value==10?AllColors.white:AllColors.white.withOpacity(0.6)),
                    ),
                  ),
                ),
                if(GetStorage().read(AppConstant.assignment_change_approval).toString().toLowerCase() == "yes")
                  InkWell(
                    onTap: (){
                      loginController.selectLoanType.value = "All Loan";
                      loginController.leadsPageName.value="All";
                      loginController.filterTypeSelected.value ="All Source";
                      leadManagerTab.value=16;
                    },
                    child: AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: leadManagerTab.value==16?AllColors.yellow:AllColors.none))
                      ),
                      child: Text("Approval".tr,
                        style:  fontSmall.copyWith(wordSpacing: 0,letterSpacing: 0.4,color: leadManagerTab.value==16?AllColors.white:AllColors.white.withOpacity(0.6)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: leadManagerTab.value==1? const MyLeadsScreen() :
            leadManagerTab.value==2? const TeamLeadsScreen():
            leadManagerTab.value==3? const MyTeamScreen() :
            leadManagerTab.value==4? const MyCustScreen() :
            leadManagerTab.value==5? const NewLeadScreen():
            leadManagerTab.value==6? const VerificationScreen():
            leadManagerTab.value==7? const LoginLeads():
            leadManagerTab.value==8? const SanctionScreen():
            leadManagerTab.value==9? const DisbursedScreen():
            leadManagerTab.value==10? const IncentiveScreen():
            leadManagerTab.value==16? const ApproveAssignLeadsScreen(): const MyLeadsScreen(),
          ),
        ],
      )),
    );
  }
}
