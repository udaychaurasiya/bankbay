import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/widgets/Profile/Model/user_details_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PartnerDetailsKYCScreen extends StatefulWidget {
  final UserDetailsData partnerDetails;
  const PartnerDetailsKYCScreen({super.key, required this.partnerDetails});

  @override
  State<PartnerDetailsKYCScreen> createState() => _PartnerDetailsKYCScreenState();
}

class _PartnerDetailsKYCScreenState extends State<PartnerDetailsKYCScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller){
        return Column(
          children: [
            SizedBox(height: 15.r),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 120.r,
                  margin: EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 10.r),
                  padding: EdgeInsets.only(bottom: 10.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    shape: BoxShape.rectangle,
                  ),
                  child: DottedBorder(
                    borderType: BorderType.Rect,
                    radius: Radius.circular(5.r),
                    strokeWidth: 1.5.r,
                    dashPattern: const [4,3],
                    color: AllColors.blue.withOpacity(0.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0.r),
                          child: UnderLineTextField(
                            labelText: "Enter PAN Number".tr,
                            hint: "Enter PAN Number".tr,
                            label: true,
                            isRead: true,
                            controller: TextEditingController(text: widget.partnerDetails.details.custPan?? ""),
                            type: TextInputType.text,
                            // inputFormatters: [
                            //   UpperCaseTextFormatter(),
                            // ],
                          ),
                        ),
                        // SizedBox(height: 20.r),
                        // Text(
                        //   "Request Customer OTP",
                        //   style: fontMedium.copyWith(
                        //     color: AllColors.themeColor,
                        //     fontSize: 12.r,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: Get.width/4-5.r,
                  top: 12.r,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10.r, left: 10.r, right: 10.r),
                    color: Colors.white,
                    child: Text(
                      "PAN Authentication",
                      style: fontMedium.copyWith(fontSize: 12.r),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 120.r,
                  margin: EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 10.r),
                  padding: EdgeInsets.only(bottom: 10.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    shape: BoxShape.rectangle,
                  ),
                  child: DottedBorder(
                    borderType: BorderType.Rect,
                    radius: Radius.circular(5.r),
                    strokeWidth: 1.5.r,
                    dashPattern: const [4,3],
                    color: AllColors.blue.withOpacity(0.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0.r),
                          child: UnderLineTextField(
                            controller: TextEditingController(text:  widget.partnerDetails.details.custAadhar ?? ""),
                            hint: "Enter Aadhaar Number".tr,
                            label: true,
                            icon: true,
                            isRead: true,
                            type: TextInputType.number,
                            length: 12,
                            // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            suffixIcon: Lottie.asset(Images.success, height: 25.r, width: 25.r,),
                          ),
                        ),
                        // SizedBox(height: 5.r),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 20.0.r),
                        //   child: UnderLineTextField(
                        //     // controller: controller.etPanCard,
                        //     hint: "Enter OTP".tr,
                        //     label: false,
                        //     icon: true,
                        //     type: TextInputType.text,
                        //     length: 10,
                        //     suffixIcon: Text("Verify OTP",style: fontMedium.copyWith(fontSize: 12.r,wordSpacing: 0,letterSpacing: 0),),
                        //     validator: (value) {
                        //       if (value == null || value.isEmpty) {
                        //         return 'Please enter OTP';
                        //       }
                        //       return null;
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: Get.width/4-5.r,
                  top: 12.r,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10.r, left: 10.r, right: 10.r),
                    color: Colors.white,
                    child: Text(
                      "AADHAAR Authentication",
                      style: fontMedium.copyWith(fontSize: 12.r),
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(height: 15.r),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal:15.0.r),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       CustomButton(
            //         title: "Approve".tr,
            //         width: 120.r,
            //         bgColor: AllColors.green,
            //         background: false,
            //         height: 35.r,
            //         radius: 0,
            //         onTap: (){
            //           print("add emp type 1");
            //           controller.addEmployeeAboutNetworkApi("1");
            //         },
            //       ),
            //       CustomButton(
            //         title: "Push back".tr,
            //         width: 120.r,
            //         // bgColor: AllColors.green,
            //         background: true,
            //         height: 35.r,
            //         radius: 0,
            //         onTap: ()async{
            //           print("add emp type 2");
            //           // if (formKeyEducation.currentState != null && formKeyEducation.currentState!.validate()) {
            //           //   bool status = await controller.addEmployeeAboutNetworkApi("2");
            //           //   if (status == true) {
            //           //     // Get.offAll(() => const DashboardScreen());
            //           //   }
            //           // }
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 20.r),
          ],
        );
      },
    );
  }
}
