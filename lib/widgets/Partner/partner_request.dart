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

class PartnerRequestScreen extends StatefulWidget {
  const PartnerRequestScreen({super.key});

  @override
  State<PartnerRequestScreen> createState() => _ApprovedScreenState();
}

class _ApprovedScreenState extends State<PartnerRequestScreen> {
  var controller = Get.find<PartnerController>();

  @override
  void initState() {
    controller.partnerApprovedNext = 10;
    controller.partnerRequestNetworkApi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.lightBlue.withOpacity(0.1),
      body: SingleChildScrollView(
        controller: controller.partnerApprovedController,
        child: Container(
          width: width,
          margin: EdgeInsets.only(top: 15.r,left: 10.r, right: 10.r,bottom: 50.r),
          padding: EdgeInsets.symmetric(horizontal: 10.0.r),
          color: Colors.white,
          child: Column(
            children: [
              GetBuilder<PartnerController>(
                builder: (controller) {
                  return controller.partner_request_loader.value?
                  ListView.builder(
                      itemCount: controller.partner_request_model.value.data.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: controller.partner_request_model.value.data.isNotEmpty?EdgeInsets.only(top: 10.r):EdgeInsets.zero,
                      itemBuilder: (context, index){
                        var partnerRequestData = controller.partner_request_model.value.data[index];
                        return Container(
                          margin: EdgeInsets.only(top: index==0?0:8.r),
                          padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 3.r),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1.r, color: AllColors.lightGrey)
                          ),
                          child: EmpPartnerViewCard(
                            userId: partnerRequestData.pid??"NA",
                            title: partnerRequestData.custName??"",
                            profileImage: partnerRequestData.custProfilePic??"",
                            address: partnerRequestData.custAddress??"NA",
                            expireDate: partnerRequestData.partnerJoinDate??"NA",
                            preDate: partnerRequestData.partnerJoinDate??"NA",
                            star: true,
                            color: partnerRequestData.pushbackCount.toString()=="0"?AllColors.green : AllColors.orange,
                            onTap: (){
                              partnerDetailsTab.value = 1;
                              partnerPushbackDetailsTab.value = 1;
                              Get.to(()=>PartnerDetailsHome(pageName: "partnerRequest", partnerId: partnerRequestData.custId.toString()));
                            },
                            nameTap: ()=> Get.to(()=> PartnerDetailsList(partnerId: partnerRequestData.custId, pageName: "partnerRequest")),
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
                      }) ;
                },
              ),
              Obx(() =>controller.partner_request_model.value.message.toString()=="Data Not Found."?
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: Get.height/2.85),
                  child: Text("Data not found !!", style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.6)),),
                ):const SizedBox()),
              if(controller.partner_request_model.value.message.toString()!="Data Not Found.")
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0.r),
                  child: Text("Hooray !!! All Caught up", style: fontRegular.copyWith(color: AllColors.grey),),
                ),
              Obx(() => controller.partnerLoadMore.value? const LoadingMoreData():const SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
