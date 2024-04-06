import 'package:bank_bay/controllers/permission_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';

class MyEarningScreen extends StatefulWidget {
  const MyEarningScreen({super.key});

  @override
  State<MyEarningScreen> createState() => _MyEarningScreenState();
}

class _MyEarningScreenState extends State<MyEarningScreen> {
  var controller = Get.find<PermissionController>();
  var partnerController = Get.find<PartnerController>();
  @override
  void initState() {
    if(GetStorage().read(AppConstant.name).toString() != "null") {
      controller.getMyEarningsNetworkApi();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.withOpacity(0.1),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left:10.0.r, right:10.0.r, top:10.0.r),
          // color: AllColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 10.r),
                width: Get.width,
                decoration: BoxDecoration(
                    color: AllColors.white,
                    // border: Border(bottom: BorderSide(width: 1.r, color: AllColors.black.withOpacity(0.1)))
                ),
                child: Text("My Earning", style: fontBold.copyWith()),
              ),
              SizedBox(height: 6.r),
              Obx(() => controller.my_earning_loader.value?
                ListView.builder(
                  itemCount: controller.my_earning_model.value.data.length,
                  // padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 10.r),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                  return GetBuilder<PermissionController>(
                    builder: (controller) {
                    var data = controller.my_earning_model.value.data[index];
                      return Container(
                        margin: EdgeInsets.only(top: index==0?0:6.r),
                        color: AllColors.white,
                        padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 10.r),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: "Lead I'd  :  ",
                                    style: fontMedium.copyWith(fontSize: 13.r),
                                    children: [
                                      TextSpan(text: data.leadId??"", style:  fontRegular.copyWith(color: AllColors.black.withOpacity(0.6), fontSize: 12.r)),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 3.r),
                                RichText(
                                  text: TextSpan(
                                    text: "User I'd  :  ",
                                    style: fontMedium.copyWith(fontSize: 13.r),
                                    children: [
                                      TextSpan(text: data.userId??"", style:  fontRegular.copyWith(color: AllColors.black.withOpacity(0.6), fontSize: 12.r)),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 3.r),
                                RichText(
                                  text: TextSpan(
                                    text: "Date  :  ",
                                    style: fontMedium.copyWith(fontSize: 13.r),
                                    children: [
                                      TextSpan(text: data.datetime??"", style:  fontRegular.copyWith(color: AllColors.black.withOpacity(0.6), fontSize: 12.r)),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                            if(data.amount.toString().isNotEmpty)
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0.r),
                                child: RichText(
                                  text: TextSpan(
                                    text: "+ ",
                                    style: fontMedium.copyWith(color: AllColors.green, fontSize: 12.r),
                                    children: [
                                      TextSpan(text: "₹", style: fontBold.copyWith(color: AllColors.green)),
                                      TextSpan(text: partnerController.formatAmount(data.amount??"0"), style: fontBold.copyWith(color: AllColors.green)),
                                    ],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            // Padding(
                            //   padding: EdgeInsets.symmetric(horizontal: 10.0.r),
                            //   child: Text("+ ${data.amount??""}", style: fontBold.copyWith(color: AllColors.green)),
                            // )
                          ],
                        ),
                      );
                    }
                  );
                },
                ):
                ListView.builder(
                  itemCount: 12,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return Container(
                      margin: EdgeInsets.only(top: index==0?0:6.r),
                      padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 10.r),
                      color: AllColors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      height: 12.r,
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
                                      width: 200.r,
                                      height: 10.r,
                                      color: AllColors.white,
                                      margin: EdgeInsets.only(right: 5.r),
                                    ),
                                  ),
                                ],
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: Container(
                                  width: 60.r,
                                  height: 16.r,
                                  margin: EdgeInsets.only(right: 10.r),
                                  decoration: BoxDecoration(
                                    color: AllColors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if(index!=11)
                            Container(
                              height: 1.r,
                              margin: EdgeInsets.symmetric(vertical: 10.r),
                              color: AllColors.lightGrey,
                            ),
                        ],
                      ),
                    );
                  })),
              Obx(() => controller.my_earning_model.value.message.toString()=="Data Not Found."?
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: Get.height/2.88),
                    padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 10.r),
                    child: Text("Data not found !!",style: fontRegular.copyWith(letterSpacing: 0,color: AllColors.black.withOpacity(0.7)),)
                ): const SizedBox()),
              if( controller.my_earning_model.value.data.length>6)
              SizedBox(height: 70.r),
            ],
          ),
        ),
      ),
    );
  }
}
