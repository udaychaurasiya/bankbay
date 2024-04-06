import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/Profile/Model/user_details_model.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

RxString selectedLeadStatus = "".obs;
var controller = Get.find<PartnerController>();
class LoanListDetailsStatus extends StatefulWidget {
  final AllLeade allLeade;
  const LoanListDetailsStatus({super.key, required this.allLeade});

  @override
  State<LoanListDetailsStatus> createState() => _LoanListDetailsStatusState();
}

class _LoanListDetailsStatusState extends State<LoanListDetailsStatus> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nextDate = TextEditingController();
    TextEditingController nextTime = TextEditingController();
    TextEditingController remarks = TextEditingController();
    controller.holdStatusList.clear();
    controller.rejectedStatusList.clear();
    controller.cust_interested_loan.value = "No";
    controller.cust_wants_loan.value = "No";
    controller.cust_applied_last_month.value = "No";
    controller.cust_processing_loan.value = "No";
    controller.cust_bankbay_application.value = "No";
    controller.loginBankName.value = "select bank";
    controller.sanctionAmount.clear();
    controller.sanctionRoi.clear();
    controller.sanctionTenure.clear();
    controller.sanctionDate.clear();
    controller.disbursedAmount.clear();
    controller.disbursedTenure.clear();
    controller.disbursedRoi.clear();
    controller.disbursedBankName.clear();
    controller.disbursedBankAccountName.clear();
    controller.disbursedBankAccountNumber.clear();
    controller.disbursedBankIFSCCode.clear();
    controller.disbursedMethod.clear();
    controller.disbursedDate.clear();
    controller.loginDate.clear();
    controller.loginAppId.clear();
    controller.loginAmount.clear();
    controller.loginTenure.clear();
    nextDate.clear();
    nextTime.clear();
    remarks.clear();
    return Container(
      padding: EdgeInsets.all(10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatusViewData(
            title: "Created on".tr,
            value: "${widget.allLeade.leadDateTime??"NA"}",
          ),
          StatusViewData(
            title: "Created by".tr,
            value: widget.allLeade.createdByName??"NA",
          ),
          StatusViewData(
            title: "Last connect".tr,
            value: widget.allLeade.lastCallDateTime??"NA",
          ),
          StatusViewData(
            title: "Next Follow-up".tr,
            value: widget.allLeade.nextFollowupDate??"NA",
          ),
          // SizedBox(height: 10.r),
          // Text("Set next follow-up", style: fontSmall.copyWith(fontWeight: FontWeight.w600,color: AllColors.black.withOpacity(0.8))),
          // SizedBox(height: 10.r),
          // Row(
          //   children: [
          //     Expanded(
          //       child: OutlineTextField(
          //         hint: "Select Date",
          //         controller: nextDate,
          //         icon: true,
          //         isRead: true,
          //         validator: (value) {
          //           if (value == null || value.isEmpty) {
          //             return 'Please enter name';
          //           }
          //           return null;
          //         },
          //         onTap: () async {
          //           var datePicked = await DatePicker.showSimpleDatePicker(
          //             context,
          //             initialDate: DateTime.now(),
          //             firstDate: DateTime(1900),
          //             lastDate: DateTime.now(),
          //             dateFormat: "yyyy-MM-dd",
          //             locale: DateTimePickerLocale.en_us,
          //             looping: true,
          //           );
          //           nextDate.text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString()));
          //         },
          //       ),
          //     ),
          //     SizedBox(width: 10.r),
          //     Expanded(
          //       child: OutlineTextField(
          //         hint: "Select Time",
          //         controller: nextTime,
          //         icon: true,
          //         isRead: true,
          //         validator: (value) {
          //           if (value == null || value.isEmpty) {
          //             return 'Please select time';
          //           }
          //           return null;
          //         },
          //         onTap: () async {
          //           TimeOfDay? selected = await showTimePicker(
          //             context: context,
          //             initialTime: TimeOfDay.now(),
          //           );
          //           if (selected != null) {
          //             nextTime.text = DateFormat("Hms").format(DateTime(2023, 1, 1, selected.hour, selected.minute));
          //           }
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(height: 10.r),
          // RichText(
          //   text: TextSpan(
          //     text: "Lead Status",
          //     style: fontSmall.copyWith(fontWeight: FontWeight.w600,color: AllColors.black.withOpacity(0.8)),
          //     children: [
          //       TextSpan(text: " *", style: fontSmall.copyWith(color: AllColors.red)),
          //     ],
          //   ),
          // ),
          // SizedBox(height: 10.r),
          // Obx(() => DropdownButtonFormField(
          //   decoration: InputDecoration(
          //     enabledBorder: OutlineInputBorder(
          //       borderSide: BorderSide(color: AllColors.grey.withOpacity(0.3), width: 1.r),
          //       borderRadius: BorderRadius.circular(3.r),
          //     ),
          //     border: OutlineInputBorder(
          //       borderSide: BorderSide(color: AllColors.grey, width: 0.5.r),
          //       borderRadius: BorderRadius.circular(3.r),
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //       borderSide: BorderSide(color: AllColors.blue.withOpacity(0.8), width: 2.r),
          //       borderRadius: BorderRadius.circular(3.r),
          //     ),
          //     isDense: true,
          //     contentPadding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.r),
          //     hintText: "select lead status",
          //     hintStyle: fontSmall.copyWith(
          //       wordSpacing: 0.2,
          //       letterSpacing: 0.8,
          //       fontWeight: FontWeight.w400,
          //       color: AllColors.black.withOpacity(0.7),
          //     ),
          //   ),
          //   items: controller.statusList.map((String? item) {
          //     return DropdownMenuItem<String>(
          //       value: item,
          //       child: Text(item.toString()),
          //       onTap: () {
          //         print("value $item");
          //         controller.selectedLeadStatus.value = item??"select status";
          //       },
          //     );
          //   }).toList(),
          //   value: controller.selectedLeadStatus.value,
          //   onChanged: (String? newValue) {
          //     controller.selectedLeadStatus.value = newValue ?? "select status";
          //     if(controller.selectedLeadStatus.value!="select status") {
          //       _showBottomSheet(context,controller.selectedLeadStatus.value);
          //     }
          //   },
          //   // validator: (value) {
          //   //   if (value == null || value.isEmpty) {
          //   //     return 'Please select marital status';
          //   //   }
          //   //   return null;
          //   // },
          // )),
          // SizedBox(height: 10.r),
          // RichText(
          //   text: TextSpan(
          //     text: "Notes",
          //     style: fontSmall.copyWith(fontWeight: FontWeight.w600,color: AllColors.black.withOpacity(0.8)),
          //     children: [
          //       TextSpan(text: " *", style: fontSmall.copyWith(color: AllColors.red)),
          //     ],
          //   ),
          // ),
          // SizedBox(height: 10.r),
          // OutlineTextField(
          //   hint: "Remarks here...",
          //   controller: remarks,
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please enter remarks here';
          //     }
          //     return null;
          //   },
          // ),
          // SizedBox(height: 20.r),
          // CustomButton(
          //   title: "Update Lead".tr,
          //   background: true,
          //   miniFont: true,
          //   height: 38.r,
          //   onTap: ()async{
          //     if(controller.selectedLeadStatus.value=="Hold"|| controller.selectedLeadStatus.value=="Verified"|| controller.selectedLeadStatus.value=="Rejected"){
          //       bool status = await controller.updateLeadStatusNetworkApi2(widget.allLeade.leadId.toString(),nextDate.text, nextTime.text,remarks.text,widget.allLeade.custId);
          //       if(status==true){
          //         controller.holdStatusList.clear();
          //         controller.rejectedStatusList.clear();
          //         controller.cust_interested_loan.value = "No";
          //         controller.cust_wants_loan.value = "No";
          //         controller.cust_applied_last_month.value = "No";
          //         controller.cust_processing_loan.value = "No";
          //         controller.cust_bankbay_application.value = "No";
          //       }
          //     }
          //     if(controller.selectedLeadStatus.value=="Login"|| controller.selectedLeadStatus.value=="Sanctioned"|| controller.selectedLeadStatus.value=="Disbursed"){
          //       bool status = await controller.updateLeadStatusNetworkApi(widget.allLeade.leadId.toString(),nextDate.text, nextTime.text,remarks.text,widget.allLeade.custId);
          //       if(status==true){
          //         nextDate.clear();
          //         nextTime.clear();
          //         remarks.clear();
          //       }
          //     }
          //   },
          // ),
          SizedBox(height: 10.r),
        ],
      ),
    );
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
                    TextSpan(text: "(${hint.toString()})", style: fontSmall.copyWith()),
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
