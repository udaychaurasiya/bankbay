import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:bank_bay/widgets/Profile/Model/user_details_model.dart';

class LoanListFormDetail extends StatelessWidget {
  final AllLeade allLeade;
  const LoanListFormDetail({super.key, required this.allLeade});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController gender = TextEditingController();
    TextEditingController marital = TextEditingController();
    TextEditingController highQualification = TextEditingController();
    TextEditingController eMail = TextEditingController();
    TextEditingController panNumber = TextEditingController();
    TextEditingController phone = TextEditingController();
    return Padding(
      padding: EdgeInsets.all(5.0.r),
      child: GetBuilder<PartnerController>(
        builder: (controller) {
          name.text = allLeade.custName??"";
          gender.text = allLeade.custGender??"";
          marital.text = allLeade.custMaritalStatus??"";
          highQualification.text = allLeade.custEducation??"";
          eMail.text = allLeade.custEmail??"";
          panNumber.text = allLeade.custPan??"";
          phone.text = allLeade.custPhone??"";
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.r),
                child: Column(
                  children: [
                    UnderLineTextField(
                      labelText: "Name".tr,
                      hint: "Name".tr,
                      label: true,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 3.0.r),
                        child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                      ),
                      icon: true,
                      isRead: true,
                      controller: name,
                      type: TextInputType.text,
                    ),
                    UnderLineTextField(
                      labelText: "Gender".tr,
                      hint: "Gender".tr,
                      controller: gender,
                      label: true,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 3.0.r),
                        child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                      ),
                      icon: true,
                      type: TextInputType.text,
                      length: 20,
                      isRead: true,
                    ),
                    SizedBox(height: 5.r),
                    UnderLineTextField(
                      labelText: "Marital".tr,
                      hint: "Marital".tr,
                      controller: marital,
                      label: true,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 3.0.r),
                        child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                      ),
                      icon: true,
                      type: TextInputType.text,
                      length: 20,
                      isRead: true,
                    ),
                    SizedBox(height: 5.r),
                    UnderLineTextField(
                      labelText: "Please highest qualification".tr,
                      hint: "Please highest qualification".tr,
                      controller: highQualification,
                      label: true,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 3.0.r),
                        child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                      ),
                      icon: true,
                      type: TextInputType.text,
                      length: 20,
                      isRead: true,
                    ),
                    SizedBox(height: 5.r),
                    UnderLineTextField(
                      labelText: "Email ID".tr,
                      hint: "Email ID".tr,
                      label: true,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 3.0.r),
                        child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                      ),
                      icon: true,
                      isRead: true,
                      controller: eMail,
                      type: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 5.r),
                    UnderLineTextField(
                      labelText: "Pan Number".tr,
                      hint: "Pan Number".tr,
                      label: true,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 3.0.r),
                        child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                      ),
                      icon: true,
                      isRead: true,
                      controller: panNumber,
                      type: TextInputType.text,
                      length: 30,
                    ),
                    SizedBox(height: 5.r),
                    UnderLineTextField(
                      controller: phone,
                      hint: "Phone Number".tr,
                      labelText: "Phone Number".tr,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 3.0.r),
                        child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
                      ),
                      icon: true,
                      isRead: true,
                      length: 15,
                      type: TextInputType.number,
                      preIcon: true,
                    ),

                  ],
                ),
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
              //           // controller.addEmployeeAboutNetworkApi("1");
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
              //           // controller.addEmployeeAboutNetworkApi("2");
              //         },
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(height: 10.r),
            ],
          );
        }
      ),
    );
  }
}
