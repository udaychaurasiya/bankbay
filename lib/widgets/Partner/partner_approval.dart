import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/emp_partner_view_list.dart';
import 'package:bank_bay/utils_method/loading_more_widget.dart';
import 'package:bank_bay/widgets/Customer%20details/Partner%20Details/partner_details.dart';
import 'package:bank_bay/widgets/Customer%20details/Partner%20Details/partner_details_home.dart';
import 'package:bank_bay/widgets/Customer%20details/Partner%20Details/partner_pushback_details.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/Customer%20details/partner_details_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class PartnerApprovalScreen extends StatefulWidget {
  const PartnerApprovalScreen({super.key});

  @override
  State<PartnerApprovalScreen> createState() => _ApprovedScreenState();
}

class _ApprovedScreenState extends State<PartnerApprovalScreen> {
  var controller = Get.find<PartnerController>();

  @override
  void initState() {
    controller.partnerRequestNext = 10;
    controller.partnerApprovalNetworkApi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.lightBlue.withOpacity(0.1),
        body: SingleChildScrollView(
          controller: controller.partnerRequestController,
          child: Container(
            width: width,
            margin: EdgeInsets.only(top: 15.r,left: 10.r, right: 10.r,bottom: 50.r),
            padding: EdgeInsets.symmetric(horizontal: 10.0.r),
            color: Colors.white,
            child: GetBuilder<PartnerController>(
              builder: (controller) {
                return Column(
                  children: [
                    controller.partner_approval_loader.value?
                    ListView.builder(
                        itemCount: controller.partner_approval_model.value.data.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: controller.partner_approval_model.value.data.isNotEmpty?
                        EdgeInsets.only(top: 10.r):EdgeInsets.zero,
                        itemBuilder: (context, index){
                          var partnerApprovalData = controller.partner_approval_model.value.data[index];
                          return Container(
                            margin: EdgeInsets.only(top: index==0?0:8.r),
                            padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 3.r),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1.r, color: AllColors.lightGrey)
                            ),
                            child: EmpPartnerViewCard(
                                userId: partnerApprovalData.pid??"NA",
                                title: partnerApprovalData.custName??"",
                                profileImage: partnerApprovalData.custProfilePic.toString(),
                                address: partnerApprovalData.custAddress??"NA",
                                expireDate: partnerApprovalData.partnerJoinDate??"NA",
                                preDate: partnerApprovalData.partnerJoinDate??"NA",
                                onTap: (){
                                  Future.delayed(Duration.zero, () async {
                                    partnerDetailsTab.value = 1;
                                    partnerPushbackDetailsTab.value = 1;
                                    Get.to(()=>PartnerDetailsHome(pageName: "partnerDirectRequest", partnerId: partnerApprovalData.custId??""));
                                  });
                                },
                              nameTap: ()=> Get.to(()=> PartnerDetailsList(partnerId: partnerApprovalData.custId, pageName: "partnerApproval")),
                            ),
                          );
                        }) :
                    ListView.builder(
                        itemCount: 8,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10.r),
                        itemBuilder: (context, index){
                          return Container(
                            margin: EdgeInsets.only(top: index==0?0:10.0.r),
                            padding: EdgeInsets.symmetric(horizontal: 5.0.r,vertical: 10.r),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1.r, color: AllColors.lightGrey)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  enabled: true,
                                  child: CircleAvatar(
                                    radius: 20.r,
                                    backgroundColor: AllColors.white,
                                  ),
                                ),
                                SizedBox(width: 10.r),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Shimmer.fromColors(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor: Colors.grey.shade100,
                                                enabled: true,
                                                child: Container(
                                                  width: 150.r,
                                                  height: 10.r,
                                                  color: AllColors.white,
                                                  margin: EdgeInsets.only(right: 5.r),
                                                ),
                                              ),
                                              SizedBox(height: 5.r),
                                              Shimmer.fromColors(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor: Colors.grey.shade100,
                                                enabled: true,
                                                child: Container(
                                                  width: 80.r,
                                                  height: 8.r,
                                                  color: AllColors.white,
                                                  margin: EdgeInsets.only(right: 5.r),
                                                ),
                                              ),
                                              SizedBox(height: 5.r),
                                              Shimmer.fromColors(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor: Colors.grey.shade100,
                                                enabled: true,
                                                child: Container(
                                                  width: 135.r,
                                                  height: 8.r,
                                                  color: AllColors.white,
                                                  margin: EdgeInsets.only(right: 5.r),
                                                ),
                                              ),
                                              SizedBox(height: 5.r),
                                              Shimmer.fromColors(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor: Colors.grey.shade100,
                                                enabled: true,
                                                child: Container(
                                                  width: 110.r,
                                                  height: 8.r,
                                                  color: AllColors.white,
                                                  margin: EdgeInsets.only(right: 5.r),
                                                ),
                                              ),
                                              SizedBox(height: 5.r),
                                              Shimmer.fromColors(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor: Colors.grey.shade100,
                                                enabled: true,
                                                child: Container(
                                                  width: 160.r,
                                                  height: 8.r,
                                                  color: AllColors.white,
                                                  margin: EdgeInsets.only(right: 5.r),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                    Obx(() =>controller.partner_approval_model.value.message.toString()=="Data Not Found."?
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: Get.height/2.85),
                        child: Text("Data not found !!", style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.6)),),
                      ):const SizedBox(),
                    ),
                    if(controller.partner_approval_model.value.message.toString()!="Data Not Found.")
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0.r),
                        child: Text("Hooray !!! All Caught up", style: fontRegular.copyWith(color: AllColors.grey),),
                      ),
                    Obx(() => controller.partnerLoadMore.value? const LoadingMoreData():const SizedBox()),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
