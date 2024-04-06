import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/widgets/Profile/Model/user_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PartnerDetailsAccessScreen extends StatefulWidget {
  final UserDetailsData partnerDetails;
  const PartnerDetailsAccessScreen({super.key, required this.partnerDetails});

  @override
  State<PartnerDetailsAccessScreen> createState() => _PartnerDetailsAccessScreenState();
}

class _PartnerDetailsAccessScreenState extends State<PartnerDetailsAccessScreen> {
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
    TextEditingController partnerNewLeadTab = TextEditingController();
    TextEditingController partnerVerificationTab = TextEditingController();
    TextEditingController partnerDisbursedTab = TextEditingController();
    TextEditingController partnerIncentiveTab = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return GetBuilder<LoginController>(
      builder: (controller){
        empViewAll.text = widget.partnerDetails.access.empViewAll.toString().capitalize??"No";
        addEmp.text = widget.partnerDetails.access.addEmp.toString().capitalize??"No";
        updateEmp.text = widget.partnerDetails.access.updateEmp.toString().capitalize??"No";
        empPushBack.text = widget.partnerDetails.access.empPushBack.toString().capitalize??"No";
        empApprove.text = widget.partnerDetails.access.empApprove.toString().capitalize??"No";
        empPendingApprove.text = widget.partnerDetails.access.empPendingApproval.toString().capitalize??"No";
        partnerViewAll.text = widget.partnerDetails.access.partnerViewAll.toString().capitalize??"No";
        partnerAdd.text = widget.partnerDetails.access.partnerAdd.toString().capitalize??"No";
        partnerUpdate.text = widget.partnerDetails.access.partnerUpdate.toString().capitalize??"No";
        partnerPushBack.text = widget.partnerDetails.access.partnerPushBack.toString().capitalize??"No";
        unassignedLeads.text = widget.partnerDetails.access.unassignedLeads.toString().capitalize??"No";
        assignAllLead.text = widget.partnerDetails.access.assignAllLead.toString().capitalize??"No";
        assignMyLead.text = widget.partnerDetails.access.assignMyLead.toString().capitalize??"No";
        assignMyTeamLead.text = widget.partnerDetails.access.assignMyteamLead.toString().capitalize??"No";
        assignMyPartnerLead.text = widget.partnerDetails.access.assignMypartnerLead.toString().capitalize??"No";
        addLead.text = widget.partnerDetails.access.addLead.toString().capitalize??"No";
        myLead.text = widget.partnerDetails.access.myLead.toString().capitalize??"No";
        myTeamLead.text = widget.partnerDetails.access.myteamLead.toString().capitalize??"No";
        myPartnerLead.text = widget.partnerDetails.access.mypartnerLead.toString().capitalize??"No";
        allCust.text = widget.partnerDetails.access.allCust.toString().capitalize??"No";
        myCust.text = widget.partnerDetails.access.myCust.toString().capitalize??"No";
        myTeamCust.text = widget.partnerDetails.access.myteamCust.toString().capitalize??"No";
        myPartnerCust.text = widget.partnerDetails.access.mypartnerCust.toString().capitalize??"No";
        mySales.text = widget.partnerDetails.access.mySales.toString().capitalize??"No";
        incentiveMgmtView.text = widget.partnerDetails.access.incentiveMgmtView.toString().capitalize??"No";
        incentiveMgmtEdit.text = widget.partnerDetails.access.incentiveMgmtEdit.toString().capitalize??"No";
        panelManagerPartner.text = widget.partnerDetails.access.panelManagePartner.toString().capitalize??"No";
        panelManagerCustomer.text = widget.partnerDetails.access.panelManageCustomer.toString().capitalize??"No";
        partnerNewLeadTab.text = widget.partnerDetails.access.newLeadTab.toString().capitalize??"No";
        partnerVerificationTab.text = widget.partnerDetails.access.verificationLeadTab.toString().capitalize??"No";
        partnerDisbursedTab.text = widget.partnerDetails.access.disbursedLeadTab.toString().capitalize??"No";
        partnerIncentiveTab.text = widget.partnerDetails.access.incentiveLeadTab.toString().capitalize??"No";
        return Column(
          children: [
            SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                  SizedBox(height: 5.r),
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
                    controller: partnerNewLeadTab,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 5.r),
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
                    controller: partnerVerificationTab,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 5.r),
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
                    controller: partnerDisbursedTab,
                    type: TextInputType.text,
                    length: 30,
                  ),
                  SizedBox(height: 5.r),
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
                    controller: partnerIncentiveTab,
                    type: TextInputType.text,
                    length: 30,
                  ),

                  SizedBox(height: 15.r),
                  CustomerCountView(
                    title: "Access changes Count".tr,
                    count:  "${widget.partnerDetails.access.accessChangeCount??"00"}",
                  ),
                  SizedBox(height: 15.r),
                  CustomerCountView(
                    title: "Access changes By".tr,
                    count:  widget.partnerDetails.access.userId??"NA",
                    changes:  "(${widget.partnerDetails.access.accessChangeCount??"00"})",
                  ),
                  SizedBox(height: 15.r),
                  CustomerCountView(
                    title: "Access changes By".tr,
                    changes: widget.partnerDetails.access.accessChangeDateTime??"NA",
                  ),
                ],
              ),
            ),
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

