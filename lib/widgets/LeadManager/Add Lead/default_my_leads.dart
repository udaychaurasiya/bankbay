// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use
import 'package:bank_bay/controllers/login_controller.dart';
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

class DefaultMyLeads extends StatefulWidget {
  const DefaultMyLeads({super.key});

  @override
  State<DefaultMyLeads> createState() => _DefaultMyLeadsState();
}

class _DefaultMyLeadsState extends State<DefaultMyLeads> {
  final _controller = Get.find<PartnerController>();
  LoginController controller = Get.find<LoginController>();

  @override
  void initState() {
    _controller.getProfileCompleteApi();
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
            children: [
              SizedBox(height: 20.r),
              Padding(
                padding: EdgeInsets.symmetric(vertical:30.0.r),
                child: Text("Join as Partner to Add Lead & earn Incentive",style: fontMedium.copyWith(),),
              ),
              RichText(
                text: TextSpan(
                  text: "Bankbay offers our partners with ",
                  style: fontRegular.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.7)),
                  children: [
                    TextSpan(text: 'Direct ', style: fontMedium.copyWith(fontSize: 12.r)),
                    TextSpan(text: 'and ', style: fontRegular.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.7))),
                    TextSpan(text: 'Indirect incentive ', style: fontMedium.copyWith(fontSize: 12.r)),
                    TextSpan(text: 'beselt under is Partners progran', style: fontRegular.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.7))),
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
              RichText(
                text: TextSpan(
                  text: "If you know someone who is need of our services, ",
                  style: fontRegular.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.7)),
                  children: [
                    TextSpan(text: "just and a lead and relax II ", style: fontMedium.copyWith(fontSize: 12.r)),
                    TextSpan(text: "Our backend team will work with your customer and fulfill their need.", style: fontRegular.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.7))),
                  ],
                ),
              ),
              SizedBox(height: 20.r),
              Text("As a partner there are several long term benefits like Recognition & Rewards, Access & Support, and Education & Insights.", style: fontRegular.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.7))),
              SizedBox(height: 20.r),
              Text("Join our Partner program and create long term earning stream?", style: fontRegular.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.7))),
              SizedBox(height: 40.r),
              if(GetStorage().read(AppConstant.add_lead).toString().toLowerCase() == "yes")
                GetBuilder<PartnerController>(
                  builder: (_controller) {
                    return InkWell(
                      onTap: ()async{
                        if(_controller.profileComplete.value.data.popupStatus.toString()=="true"){
                          _underProcessAccess(context);
                        }else if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10")==true){
                          print("Employee Login !!!");
                        }else {
                          _profileComplete(context, _controller.profileComplete.value.data);
                        }
                      },
                      child: Container(
                        height: 35.r,
                          width: Get.width-80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: AllColors.themeColor,
                        ),
                        child: Text("Make a Partner",style: fontBold.copyWith(fontSize: 14.r, color: AllColors.white.withOpacity(0.8)),),
                      ),
                    );
                  }
                ),
            ],
          ),
        ),
      ),
    );
  }

  _underProcessAccess(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () => Navigator.pop(context),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Waiting Approval"),
      content: Text("Your partner request was submitted successfully and is under review."
          "\n\nYou will be able to add lead sooner !!", style: fontRegular.copyWith(fontSize: 13.5.r),),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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
                    SizedBox(width: 5.r),
                    InkWell(
                      onTap: ()=> Navigator.pop(context),
                      child: Icon(Icons.close_outlined, size: 22.r, color: AllColors.red.withOpacity(0.8),),
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
                    profileIndex.value=1;
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
