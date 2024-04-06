// ignore_for_file: invalid_use_of_protected_member

import 'dart:ui';
import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/Login/login_home.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/widgets/home_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserSelectLoanType extends StatefulWidget {
  const UserSelectLoanType({super.key});

  @override
  State<UserSelectLoanType> createState() => _UserSelectLoanTypeState();
}

class _UserSelectLoanTypeState extends State<UserSelectLoanType> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<LoginController>();
    _dataClear(){
      controller.leadProfileSelfie.value="";
      controller.panCardImage.value="";
      controller.aadhaarCardImage.value="";
      controller.salarySlipsImage.value="";
      controller.bankStatementImage.value="";
      controller.ownerShipProof.value="";
      controller.relationshipProof.value="";
      controller.leadProfileSelfieName.value="";
      controller.panCardImageName.value="";
      controller.aadhaarCardImageName.value="";
      controller.salarySlipsImageName.value="";
      controller.bankStatementImageName.value="";
      controller.ownerShipProofName.value="";
      controller.relationshipProofName.value="";
      controller.etName.clear();
      controller.etEmail.clear();
      controller.etPassword.clear();
      controller.etPanCard.clear();
      controller.etNumber.clear();
      controller.etDob.clear();
      controller.etCompanyName.clear();
      controller.etMonthlyAmount.clear();
      controller.loanTextFieldList.clear();
      controller.gender.value ="Select Gender";
      controller.companyType.value = "Select Company";
      controller.maritalStatus.value = "Select Marital Status";
      controller.highestQualification.value = "Select Qualification";
      controller.userFieldList.value.clear();
      controller.userFieldList.value.add({
        "loan_type": null,
        "tenure": null,
        "month": null,
        "loan_amt": TextEditingController(),
        "roi": TextEditingController(),
      });
    }

    return SizedBox(
      height: 180.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                height: 150.0.h,
                autoPlay: true,
                enlargeCenterPage: true,
                disableCenter: true,
                viewportFraction: 1.0,
                autoPlayInterval: const Duration(seconds: 3),
                onPageChanged: (index, reason) {
                  controller.setCurrentIndex(index, true);
                  sliderValue.value= index;
                },
              ),
              items: controller.bannerData.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: (){
                        if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E100")==true){
                          print("Employee login !!!");
                          _dataClear();
                        }else{
                          if(GetStorage().read(AppConstant.name).toString() !="null"){
                            indexValue.value=5;
                            _dataClear();
                          }else{
                            _dataClear();
                            Get.to(()=> const LoginScreen(value: "userHome"));
                          }
                        }
                      },
                      child: Container(
                        height: 149.0.h,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: 0.r,
                            right: 0.r,
                            top: 10,
                            bottom: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0.r),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(1, 1),
                                blurRadius: 2,
                                color:
                                Color.fromRGBO(0, 0, 0, 0.20),
                              )
                            ],
                            color: Colors.white,
                            image: DecorationImage(
                                image: NetworkImage(i),
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2),
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.only(
                                top: 70, left: 8.0, right: 8.0, bottom: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(5.0.r),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 5.r),
        ],
      ),
    );
  }
}
