import 'package:bank_bay/Login/create_password.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'cust_basic.dart';
import 'cust_kyc.dart';
import 'cust_photo.dart';

var createCustIndex = 1.obs;
class CreateCustomerWidget extends StatefulWidget {
  final bool addLoan;
  final String? pageName;
  const CreateCustomerWidget({super.key, required this.addLoan, this.pageName});

  @override
  State<CreateCustomerWidget> createState() => _CreateCustomerWidgetState();
}

class _CreateCustomerWidgetState extends State<CreateCustomerWidget> {
  var checkCust = false.obs;
  @override
  Widget build(BuildContext context) {
    createCustIndex.value=1;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Customer"),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: Container(
            height: 40.r,
            color: AllColors.lightGrey,
            padding: EdgeInsets.symmetric(horizontal: 5.r),
            child: Obx(() => createCustIndex.value!=-1 ?
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    // onTap: ()=> createCustIndex.value=1,
                    child: AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20.r),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: createCustIndex.value==1?AllColors.themeColor:AllColors.none))
                      ),
                      child: Text("Basic".tr,
                        style:  fontBold.copyWith(fontSize: 14.r, wordSpacing: 0,letterSpacing: 0.4,color: createCustIndex.value==1?AllColors.black.withOpacity(0.8):AllColors.black.withOpacity(0.5)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: ()=> createCustIndex.value=2,
                    child: AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20.r),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: createCustIndex.value==2?AllColors.themeColor:AllColors.none))
                      ),
                      child: Text("Photo".tr,
                        style:  fontBold.copyWith(fontSize: 14.r, wordSpacing: 0,letterSpacing: 0.4,color: createCustIndex.value==2?AllColors.black.withOpacity(0.8):AllColors.black.withOpacity(0.5)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: ()=> createCustIndex.value=4,
                    child: AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20.r),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: createCustIndex.value==4?AllColors.themeColor:AllColors.none))
                      ),
                      child: Text("Kyc".tr,
                        style:  fontBold.copyWith(fontSize: 14.r, wordSpacing: 0,letterSpacing: 0.4,color: createCustIndex.value==4?AllColors.black.withOpacity(0.8):AllColors.black.withOpacity(0.5)),
                      ),
                    ),
                  ),
                ],
              ) :
              const SizedBox(),
            ),
          ),
      ),
      ),
      body: SingleChildScrollView(
        child: Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(createCustIndex.value==1) const CustBasicScreen(),
              if(createCustIndex.value==2) const CustPhotoScreen(),
              if(createCustIndex.value==3) const CreatePasswordScreen(),
              if(createCustIndex.value==4) CustKycScreen(addLoan: widget.addLoan),
              SizedBox(height: 10.r),
            ],
          ),
        ),
      ),
    );
  }
}
