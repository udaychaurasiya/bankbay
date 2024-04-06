// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use

import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/Profile/Model/profile_complete_model.dart';
import 'package:bank_bay/widgets/Profile/Profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DefaultLeadsScreen extends StatefulWidget {
  const DefaultLeadsScreen({super.key});

  @override
  State<DefaultLeadsScreen> createState() => _DefaultLeadsScreenState();
}


class _DefaultLeadsScreenState extends State<DefaultLeadsScreen> {
  var _controller =  Get.find<PartnerController>();

  @override
  void initState() {
    _controller.getProfileCompleteApi();
    if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10")==true){
      _controller.getEmployeeDetailsGetAmountNetworkApi(GetStorage().read(AppConstant.cust_id).toString());
    }else if(GetStorage().read(AppConstant.cust_id).toString().startsWith("C10")==true){
      _controller.getUserDetailsApi(GetStorage().read(AppConstant.cust_id).toString().trim());
    }else{
      return;
    }
    _controller.getUserDetailsApi(GetStorage().read(AppConstant.cust_id).toString().trim());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.withOpacity(0.1),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.r),
              Padding(
                padding: EdgeInsets.symmetric(vertical:30.0.r),
                child: Text("You are yet to build your team",style: fontBold.copyWith(),),
              ),
              SizedBox(height: 25.r),
              RichText(
                text: TextSpan(
                  text: "BankBay offers our partners with ",
                  style: fontRegular.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.7)),
                  children: [
                    TextSpan(text: 'Direct ', style: fontMedium.copyWith(fontSize: 12.r)),
                    TextSpan(text: 'and ', style: fontRegular.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.7))),
                    TextSpan(text: 'Indirect incentive ', style: fontMedium.copyWith(fontSize: 12.r)),
                    TextSpan(text: 'beset under is Partners program', style: fontRegular.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.7))),
                  ],
                ),
              ),
              SizedBox(height: 20.r),
              RichText(
                text: TextSpan(
                  text: "What's more, you can refer ",
                  style: fontRegular.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.7)),
                  children: [
                    TextSpan(text: "unlimited partners ", style: fontMedium.copyWith(fontSize: 12.r)),
                    TextSpan(text: "and build your own team and ", style: fontRegular.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.7))),
                    TextSpan(text: 'run your business without any investment ar rick. ', style: fontMedium.copyWith(fontSize: 12.r)),
                  ],
                ),
              ),
              SizedBox(height: 20.r),
              Text("Join our Partner program and create long term earning stream?", style: fontRegular.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.7))),
              SizedBox(height: 60.r),
              Obx(() {
                if(_controller.profileComplete.value.data.popupStatus.toString()=="true"){
                  return _controller.userdetails.value.data.partnerdetails.partnerStatus.toString() == "active"?
                      CustomButton(
                        title: "You have not any access".tr,
                        background: true,
                        radius: 0,
                        width: Get.width-80,
                      ):
                      Container(
                        width: Get.width-150,
                        height: 40.r,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AllColors.themeColor.withOpacity(0.9),
                        ),
                        child: Obx(() => Text(_controller.userdetails.value.data.partnerdetails.partnerStatus.toString().capitalize??"NA",
                          style: fontMedium.copyWith(color: AllColors.white, fontSize: 16.r),)),
                      );
                }else{
                  return CustomButton(
                    title: "Make a partner".tr,
                    background: true,
                    onTap: (){
                      _profileComplete(context, _controller.profileComplete.value.data);
                    },
                    width: Get.width-180,
                  );
                }
              }
              ),
            ],
          ),
        ),
      ),
    );
  }
  _profileComplete(BuildContext context, ProfileData profileData) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: Future.value,
        child: Dialog(
          child: Container(
            height: 350.r,
            width: double.infinity,
            padding: EdgeInsets.all(10.r),
            child: GetBuilder<PartnerController>(builder:(controller)=> Column(
              children: [
                SizedBox(height: 10.r),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Complete profile to add lead & earn incentive",
                        style: fontBold.copyWith(fontSize: 13.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.r),
                ListView.builder(
                  itemCount: profileData.cmpStatus.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data = profileData.cmpStatus[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${data.title}",
                          style: fontBold,
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 145,
                          animation: true,
                          lineHeight: 6.r,
                          percent: double.parse(data.count.toString()) / 100,
                          animationDuration: 2000,
                          trailing: Text(
                            "${data.count!.toStringAsFixed(0)}%",
                            style: fontBold.copyWith(color: AllColors.green),
                          ),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: AllColors.green,
                          backgroundColor: Colors.amberAccent,
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 10.r,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const Profile());
                  },
                  child: CustomButton(
                    background: true,
                    width: 150.r,
                    height: 35.r,
                    radius: 5.r,
                    title: "Update Profile".tr,
                  ),
                ),
              ],
            ),
            ),
          ),
        ),
      ),
    );
  }
}
