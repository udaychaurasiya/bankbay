import 'package:bank_bay/controllers/create_customer_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/utils_method/custom_image.dart';
import 'package:bank_bay/utils_method/custom_image_view.dart';
import 'package:bank_bay/utils_method/uppercase_formate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'create_customer.dart';
import 'cust_select_type.dart';

class SearchCustomerWidget extends StatefulWidget {
  const SearchCustomerWidget({super.key});

  @override
  State<SearchCustomerWidget> createState() => _SearchCustomerWidgetState();
}

class _SearchCustomerWidgetState extends State<SearchCustomerWidget> {
  CreateCustomerController createCustomerController = Get.put(CreateCustomerController());
  TextEditingController searchPan = TextEditingController();
  GlobalKey<FormState> formKeySearch = GlobalKey<FormState>(debugLabel: '_homeScreenKey');
  var checkCust = false.obs;
  @override
  void initState() {
    createCustomerController.searchCustomerModel.value.data.clear();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Customer"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.r),
        child: SingleChildScrollView(
          child: Obx(() {
              return Column(
                children: [
                  SizedBox(height: 20.r),
                  Form(
                    key: formKeySearch,
                    child: TextField(
                      controller: searchPan,
                      inputFormatters: [UpperCaseTextFormatter()],
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AllColors.grey.withOpacity(0.3), width: 1.r),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AllColors.grey, width: 0.5.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AllColors.blue.withOpacity(0.8), width: 2.r),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.r),
                        counter: const Offstage(),
                        hintText: "Enter Pan Number",
                        hintStyle: fontSmall.copyWith(
                          wordSpacing: 0.2,
                          letterSpacing: 0.8,
                          fontSize: 14.r,
                          fontWeight: FontWeight.w400,
                          color: AllColors.black.withOpacity(0.7),
                        ),
                        labelStyle: fontSmall.copyWith(
                          wordSpacing: 0.2,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w400,
                          color: AllColors.black.withOpacity(0.7),
                        ),
                        isDense: true,
                        suffixIcon: InkWell(
                          onTap: ()async{
                            if(GetStorage().read(AppConstant.name)!=null) {
                              if (formKeySearch.currentState != null && formKeySearch.currentState!.validate()) {
                                createCustomerController.searchCustomerNetworkApi(searchPan.text);
                              }
                            }else{
                              BaseController().errorSnack("You are not Sign In please sign in");
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 1.r),
                            decoration:  BoxDecoration(
                              color: AllColors.lightRed,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(2.r),bottomRight: Radius.circular(2.r))
                            ),
                            child: Icon(Icons.search, size: 22.r),
                          ),
                        ),
                        suffixIconConstraints: BoxConstraints(
                          maxWidth: 40.r,
                          minWidth: 40.r,
                          maxHeight: 40.r,
                          minHeight: 35.r,
                        ),
                      ),
                      onChanged: (value){
                        if(GetStorage().read(AppConstant.name)!=null) {
                          if (formKeySearch.currentState != null && formKeySearch.currentState!.validate()) {
                            createCustomerController.searchCustomerNetworkApi(value);
                          }
                        }else{
                          BaseController().errorSnack("You are not Sign In please sign in");
                        }
                      },
                    ),
                  ),
                  if(createCustomerController.searchCustomerModel.value.data.isNotEmpty)
                  Container(
                    padding: EdgeInsets.only(left: 10.r),
                    alignment: Alignment.topLeft,
                    child: Text("Matches found ...",
                      style: fontMedium.copyWith(color: AllColors.green),
                    ),
                  ),
                  if(createCustomerController.searchCustomerModel.value.message=="Data Not Found.")
                  Container(
                    padding: EdgeInsets.only(left: 10.r),
                    alignment: Alignment.topLeft,
                    child: Text("Matches failed...",
                      style: fontMedium.copyWith(color: AllColors.red.withOpacity(0.7)),
                    ),
                  ),
                  if(createCustomerController.searchCustomerModel.value.message=="Data Not Found.")
                  Padding(
                    padding: EdgeInsets.only(top: 20.0.r),
                    child: Text("Customer Data not found...",
                      style: fontMedium.copyWith(color: AllColors.red),
                    ),
                  ),
                  if(createCustomerController.searchCustomerModel.value.data.isNotEmpty)
                  SizedBox(height: 15.r),
                  Obx(() => ListView.builder(
                      itemCount: createCustomerController.searchCustomerModel.value.data.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var searchData =  createCustomerController.searchCustomerModel.value.data[index];
                        return Container(
                          margin: EdgeInsets.only(top: index==0?0:12.r),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: (){
                                  GetStorage().write(AppConstant.lead_id, createCustomerController.searchCustomerModel.value.data[index].id??"");
                                  GetStorage().write(AppConstant.lead_cust_id, createCustomerController.searchCustomerModel.value.data[index].custId??"");
                                  GetStorage().write(AppConstant.create_id, createCustomerController.searchCustomerModel.value.data[index].id??"");
                                  GetStorage().write(AppConstant.create_cust_id, createCustomerController.searchCustomerModel.value.data[index].custId??"");
                                  Get.to(()=> CustomImageView(imageUrls: AppConstants.BASE_URL+searchData.custProfilePic.toString()));
                                },
                                child: CircleAvatar(
                                  radius: 22.r,
                                  backgroundColor: AllColors.lightTeal.withOpacity(0.6),
                                  child: CustomImage(
                                    image: searchData.custProfilePic.toString(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.r),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(searchData.custName.toString().capitalize??"", style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.7))),
                                    Text("Add : ${searchData.custAddress??"NA"}", style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.6), fontSize: 13.5.r)),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Active lead : ',
                                        style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.6), fontSize: 13.5.r),
                                        children: [
                                          TextSpan(text: "${searchData.loanCount??0}", style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.7))),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Pan No : ',
                                        style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.6), fontSize: 13.5.r),
                                        children: [
                                          TextSpan(text: searchData.custPan.toString().toUpperCase(), style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.7))),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 25.r,
                                width: 25.r,
                                child:  Obx(()=> Radio(
                                    value: index,
                                    activeColor: AllColors.green,
                                    groupValue: createCustomerController.selectedRadioTile.value,
                                    onChanged: (int? value) {
                                      createCustomerController.selectedRadioTile.value = value!;
                                      createCustomerController.selectedRadioTile.refresh();
                                      GetStorage().write(AppConstant.create_id, searchData.id??"");
                                      GetStorage().write(AppConstant.create_cust_id, searchData.custId??"");
                                      print(searchData.custId);
                                    },
                                  ),
                                ),
                              ),
                            ],
                        ),
                      );
                    },
                  )),
                  SizedBox(height: 20.r),
                  if(createCustomerController.searchCustomerModel.value.data.isNotEmpty)
                    InkWell(
                      onTap: (){
                        if(GetStorage().read(AppConstant.create_cust_id)!=null){
                          Get.to(()=> const CustSelectType(loanType: "userLoan"));
                        }
                      },
                      child: Container(
                        height: 35.r,
                        width: Get.width/2,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AllColors.themeColor,
                            borderRadius: BorderRadius.circular(5.r)),
                        child: Text(
                          "Proceed",
                          style: fontMedium.copyWith(color: AllColors.white),
                        ),
                      ),
                    ),
                  if(createCustomerController.searchCustomerModel.value.data.isNotEmpty)
                    SizedBox(height: 20.r),
                  if(createCustomerController.searchCustomerModel.value.message=="Data Not Found.")
                  InkWell(
                    onTap: (){
                      Get.to(()=> const CreateCustomerWidget(addLoan: true));
                    },
                    child: Container(
                      height: 35.r,
                      width: Get.width/1.5,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AllColors.green,
                          border: Border.all(width: 0.5.r, color: AllColors.black.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(5.r)),
                      child: Text(
                        "Add Customer",
                        style: fontMedium.copyWith(color: AllColors.white.withOpacity(0.9)),
                      ),
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
class Customer {
  // Sample Customer class, replace with your actual data model
  final String custName;
  final String custAddress;
  final String custProfilePic;

  Customer(this.custName, this.custAddress, this.custProfilePic);
}