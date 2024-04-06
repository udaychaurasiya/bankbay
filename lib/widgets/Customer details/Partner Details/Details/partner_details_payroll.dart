import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/Profile/Model/user_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PartnerDetailsPayrollScreen extends StatefulWidget {
  final UserDetailsData partnerDetails;
  const PartnerDetailsPayrollScreen({super.key, required this.partnerDetails});

  @override
  State<PartnerDetailsPayrollScreen> createState() => _PartnerDetailsPayrollScreenState();
}

class _PartnerDetailsPayrollScreenState extends State<PartnerDetailsPayrollScreen> {
    TextEditingController supervisorId = TextEditingController();
    TextEditingController brand = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(
      builder: (controller){
        supervisorId.text = widget.partnerDetails.partnerdetails.supId??"";
        brand.text = widget.partnerDetails.partnerdetails.partnerBand??"";
        return Column(
          children: [
            SizedBox(height: 10.r),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0.r),
              child: Column(
                children: [
                  UnderLineTextField(
                    labelText: "Supervisor ID".tr,
                    hint: "Supervisor ID".tr,
                    label: true,
                    controller: supervisorId,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    type: TextInputType.text,
                    length: 20,
                    isRead: true,
                  ),
                  SizedBox(height: 10.r),
                  CustomerCountView(
                    title: "Partner referral ID".tr,
                    value: widget.partnerDetails.partnerdetails.partnerReference??"0000",
                  ),
                  SizedBox(height: 15.r),
                  CustomerCountView(
                    title: "Functional Unit".tr,
                    value: widget.partnerDetails.partnerdetails.partnerStatus??"NA",
                  ),
                  SizedBox(height: 8.r),
                  UnderLineTextField(
                    labelText: "Band".tr,
                    hint: "Band".tr,
                    label: true,
                    controller: brand,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.0.r),
                      child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                    ),
                    icon: true,
                    type: TextInputType.text,
                    length: 20,
                    isRead: true,
                  ),
                  SizedBox(height: 15.r),
                  CustomerCountView(
                    title: "Partner initiation date".tr,
                    value: widget.partnerDetails.partnerdetails.partnerJoinDate??"00-00-0000",
                  ),
                  SizedBox(height: 15.r),
                  CustomerCountView(
                    title: "Partner approval date".tr,
                    value: widget.partnerDetails.partnerdetails.partnerJoinDate??"00-00-0000",
                  ),
                  SizedBox(height: 15.r),
                  CustomerCountView(
                    title: "Partner exit date".tr,
                    value: widget.partnerDetails.partnerdetails.partnerJoinDate??"00-00-0000",
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
  final String? value;
  const CustomerCountView({Key? key, required this.title, this.value=""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title : ",style: fontMedium.copyWith(fontSize: 13.r,color: AllColors.black.withOpacity(0.5)),),
        SizedBox(height: 2.r),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 10.r),
          color: AllColors.grey.withOpacity(0.2),
          child: Text(value.toString(),style: fontBold.copyWith(fontSize: 12.r,color: AllColors.black.withOpacity(0.6)),),
        ),
      ],
    );
  }
}
