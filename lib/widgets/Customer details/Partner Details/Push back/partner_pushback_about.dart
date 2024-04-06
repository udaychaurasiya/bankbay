// ignore_for_file: invalid_use_of_protected_member, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:convert';

import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/edit_text_field.dart';
import 'package:bank_bay/utils_method/underline_dropdown.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/widgets/Customer%20details/Partner%20Details/partner_pushback_details.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/Partner/partner_home.dart';
import 'package:bank_bay/widgets/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class PartnerPushbackAboutScreen extends StatefulWidget {
  final String partnerId;
  const PartnerPushbackAboutScreen({super.key, required this.partnerId});

  @override
  State<PartnerPushbackAboutScreen> createState() => _PartnerPushbackAboutScreenState();
}
final PartnerController controller = Get.find<PartnerController>();

class _PartnerPushbackAboutScreenState extends State<PartnerPushbackAboutScreen> {
  TextEditingController remarks = TextEditingController();

  @override
  void initState() {
    saveData();
    super.initState();
  }

  saveData()async{
    bool status = await controller.getCustomerDetailsNetworkApi(widget.partnerId.toString());
    if(status==true){
      controller.pPushbackFName.text = controller.customerDetails.value.data.details.custName??"";
      controller.pPushbackDob.text = controller.customerDetails.value.data.details.custDob??"";
      controller.pPushbackEmail.text = controller.customerDetails.value.data.details.custEmail??"";
      controller.pPushbackPinCode.text = controller.customerDetails.value.data.details.custPincode??"";
      controller.pPushbackAddress.text = controller.customerDetails.value.data.details.custAddress??"";
      controller.pPushbackNumber.text = controller.customerDetails.value.data.details.custPhone??"";
      controller.pPushbackState.text = controller.customerDetails.value.data.details.custState??"";
      controller.pPushbackCountry.text = controller.customerDetails.value.data.details.custCountry??"";
      String data=controller.customerDetails.value.data.details.custSocial.toString();
      try {
        List<dynamic> custSocialList = json.decode(data);
        for (dynamic item in custSocialList) {
          print("social $item");
          String fabValue = item['fab'];
          String linkedinValue = item['linkdin'];
          controller.pPushbackFacebook.text =fabValue;
          controller.pPushbackLinkedin.text =linkedinValue;
        }
      } catch (e) {
        print('Error decoding JSON: $e');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    Rx<String?> gender = (controller.customerDetails.value.data.details.custGender!=""&&controller.customerDetails.value.data.details.custGender!=null?controller.customerDetails.value.data.details.custGender.toString().capitalize:"Select Gender").obs;
    Rx<String?> marital = (controller.customerDetails.value.data.details.custMaritalStatus!=""&&controller.customerDetails.value.data.details.custMaritalStatus!=null?controller.customerDetails.value.data.details.custMaritalStatus.toString().capitalize:"Select Marital").obs;
    Rx<String?> qualification = (controller.customerDetails.value.data.details.custEducation!=""&&controller.customerDetails.value.data.details.custEducation!=null?controller.customerDetails.value.data.details.custEducation.toString().capitalize:"Select Qualification").obs;
    return Column(
      children: [
        SizedBox(height: 15.r),
        TitleWidget(
          count: 1,
          title: "Basic Details".tr,
          icon: true,
          children: [
            SizedBox(height: 15.r),
            UnderLineTextField(
              controller: controller.pPushbackFName,
              labelText: "Name".tr,
              hint: "Name".tr,
              label: true,
              type: TextInputType.text,
              length: 30,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter name';
                }
                return null;
              },
            ),
            SizedBox(height: 5.r),
            UnderLineTextField(
              controller: controller.pPushbackDob,
              labelText: "Date of Birth".tr,
              hint: "Date of Birth".tr,
              label: true,
              type: TextInputType.text,
              length: 20,
              icon: true,
              isRead: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2800));
                if (pickedDate != null) {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  controller.pDob.text = formattedDate;
                } else {}
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please choose date of birth';
                }
                return null;
              },
            ),
            SizedBox(height: 2.r),
            CustomUnderlineDropdownField(
              items: ["Select Gender" ,"Male", "Female", "Other"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                gender.value = newValue ?? "Select Gender";
                print("gender = ${gender.value}");
              },
              value: gender.value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select gender';
                }
                return null;
              },
              hint: "Gender",
            ),
            SizedBox(height: 8.r),
            CustomUnderlineDropdownField(
              items: ["Select Marital", "Married", "Single", "Divorced"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                marital.value = newValue ?? "Select Marital";
                print("marital = ${marital.value}");
              },
              value: marital.value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select marital status';
                }
                return null;
              },
              hint: "Marital Status",
            ),
            SizedBox(height: 8.r),
            CustomUnderlineDropdownField(
              items: ["Select Qualification", "High School", "Graduation", "Masters", "Phd", "Certificate", "Diploma","Mca"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                qualification.value = newValue ?? "Select Qualification";
                print("qualification = ${qualification.value}");
              },
              value: qualification.value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please highest qualification';
                }
                return null;
              },
              hint: "Highest Qualification",
            ),
            SizedBox(height: 8.r),
            UnderLineTextField(
              controller: controller.pPushbackEmail,
              labelText: "Email ID".tr,
              hint: "Email ID".tr,
              label: true,
              type: TextInputType.emailAddress,
              onTap: () {},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email ID';
                }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                  return 'Please enter valid email ID';
                }
                return null;
              },
            ),
            SizedBox(height: 5.r),
            UnderLineTextField(
              controller: controller.pPushbackFacebook,
              labelText: "Facebook Link".tr,
              hint: "Facebook Link".tr,
              label: true,
              type: TextInputType.text,
              // length: 30,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter facebook link';
              //   }
              //   return null;
              // },
            ),
            SizedBox(height: 5.r),
            UnderLineTextField(
              controller: controller.pPushbackLinkedin,
              labelText: "Linkedin Link".tr,
              hint: "Linkedin Link".tr,
              label: true,
              type: TextInputType.text,
              // length: 30,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter linkedin link';
              //   }
              //   return null;
              // },
            ),
            SizedBox(height: 2.r),
            // DropdownButtonFormField(
            //     isExpanded: true,
            //     value: controller.selectCountry,
            //     items: controller.countryModel.value.data.map((CountryData items) {
            //       return DropdownMenuItem(
            //         value: items,
            //         child: Text(items.countryName.toString()),
            //       );
            //     }).toList(),
            //     hint: Text(
            //       "Country",
            //       style: fontSmall.copyWith(
            //         wordSpacing: 0.2,
            //         letterSpacing: 0.8,
            //         fontWeight: FontWeight.w400,
            //         color: AllColors.black.withOpacity(0.7),
            //         overflow: TextOverflow.ellipsis,
            //       ),
            //     ),
            //     onChanged: (dynamic newValue) {
            //       controller.selectCountry = newValue;
            //       controller.pCountry.text = newValue.countryName.toString();
            //       controller.countryModel.refresh();
            //       controller.selectState = null;
            //       controller.getStateNetworkApi(controller.selectCountry.id.toString());
            //     },
            //   ),
            // SizedBox(height: 8.r),
            // controller.stateModel.value.data.isNotEmpty
            //     ? DropdownButtonFormField(
            //       value: controller.selectState,
            //       items: controller.stateModel.value.data.map((StateData items){
            //         return DropdownMenuItem(
            //           value: items,
            //           child: Text(items.stateName.toString()),
            //         );
            //       }).toList(),
            //       hint: Text("State",style: fontSmall.copyWith(
            //         wordSpacing: 0.2,
            //         letterSpacing: 0.8,
            //         fontWeight: FontWeight.w400,
            //         color: AllColors.black.withOpacity(0.7),
            //         overflow: TextOverflow.ellipsis,
            //       ),),
            //       onChanged: (dynamic newValue) {
            //         controller.selectState=newValue;
            //         print("state ${newValue.id}");
            //         controller.pState.text= newValue.stateName.toString();
            //         controller.stateModel.refresh();
            //       },
            //     )
            //     : Container(),
            SizedBox(height: 8.r),
            UnderLineTextField(
              controller: controller.pPushbackPinCode,
              labelText: "PinCode".tr,
              hint: "PinCode".tr,
              label: true,
              type: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              length: 6,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter pincode';
                }
                return null;
              },
            ),
            SizedBox(height: 5.r),
            UnderLineTextField(
              controller: controller.pPushbackAddress,
              labelText: "Line Address".tr,
              hint: "Line Address".tr,
              label: true,
              type: TextInputType.text,
              length: 40,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter address';
                }
                return null;
              },
            ),
            SizedBox(height: 5.r),
            UnderLineTextField(
              controller: controller.pPushbackNumber,
              hint: "Phone Number".tr,
              labelText: "Phone Number".tr,
              onTap: () {},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter phone number';
                }else if (value.length != 10){
                  return 'Mobile Number must be of 10 digit';
                }
                return null;
              },
              isRead: false,
              length: 10,
              type: TextInputType.number,
              preIcon: true,
            ),
            SizedBox(height: 25.r),
            CustomButton(
              title: "Next".tr,
              bgColor: AllColors.green,
              background: false,
              height: 38.r,
              radius: 0.r,
              onTap: ()async{
                bool status = await controller.partnerPushbackAboutNetworkApi(
                  controller.customerDetails.value.data.partnerdetails.custId,
                  qualification.value, marital.value, gender.value,
                );
                if(status==true){
                  partnerPushbackDetailsTab.value = 2;
                }
              },
            ),
          ],
        ),
        if(widget.partnerId.toString()=="partnerRequest" && (controller.customerDetails.value.data.partnerdetails.reqApproverId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()||
            controller.customerDetails.value.data.partnerdetails.supId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()))
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(widget.partnerId.toString()=="partnerRequest")
                SizedBox(height: 15.r),
              if(widget.partnerId.toString()=="partnerRequest")
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0.r),
                  child: EditTextFiled(
                    controller: remarks,
                    hint: "Remarks".tr,
                    label: "Remarks",
                    validator: (value) {
                      if(value==null){
                        return "please fill remarks ";
                      }
                      else{
                        return null;
                      }
                    },
                    keyboardtype: TextInputType.text,
                    maxline: 6,
                    minline: 1,
                    maxLength: 100,
                  ),
                ),
              if(widget.partnerId.toString()=="partnerRequest")
                SizedBox(height: 15.r),
              if(widget.partnerId.toString()=="partnerRequest")
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:15.0.r),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        title: "Approve".tr,
                        width: 120.r,
                        bgColor: AllColors.green,
                        background: false,
                        height: 35.r,
                        radius: 0,
                        onTap: ()async{
                          bool status = await controller.partnerUpdateAboutNetworkApi(controller.customerDetails.value.data.partnerdetails.pid.toString(), "active", remarks.text);
                          if(status==true){
                            Get.off(()=> const DashboardScreen());
                            partnerTab.value=3;
                          }
                        },
                      ),
                      CustomButton(
                        title: "Push back".tr,
                        width: 120.r,
                        background: true,
                        height: 35.r,
                        radius: 0,
                        onTap: ()async{
                          bool status = await controller.partnerUpdateAboutNetworkApi(controller.customerDetails.value.data.partnerdetails.pid.toString(), "push-back", remarks.text);
                          if(status==true){
                            Get.off(()=> const DashboardScreen());
                            partnerTab.value=3;
                          }
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        SizedBox(height: 10.r),
        ListView.builder(
          itemCount: controller.customerDetails.value.data.remarks.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var remarksData = controller.customerDetails.value.data.remarks[index];
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(15.r),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.r, color: AllColors.grey.withOpacity(0.7)),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 10.r),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: remarksData.updateByName??"NA",
                            style: fontSmall.copyWith(fontWeight: FontWeight.w500, color: AllColors.themeColor, fontSize: 12.5.r,wordSpacing: 0, letterSpacing: 0,),
                            children: [
                              TextSpan(text: " (${remarksData.remarkUpdateBy??"NA"})", style: fontSmall.copyWith(fontWeight: FontWeight.w400,  fontSize: 12.r,color: AllColors.black.withOpacity(0.6),wordSpacing: 0, letterSpacing: 0, overflow: TextOverflow.ellipsis,)),
                            ],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2.r),
                        RichText(
                          text: TextSpan(
                            text: "Date : ",
                            style: fontSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),wordSpacing: 0, letterSpacing: 0, fontSize: 11.r, overflow: TextOverflow.ellipsis),
                            children: [
                              TextSpan(text: remarksData.remarkDateTime??"", style: fontSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),wordSpacing: 0, letterSpacing: 0, fontSize: 11.r, overflow: TextOverflow.ellipsis)),
                            ],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(width: 1.r),
                        Text(remarksData.remark??"", style: fontSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),wordSpacing: 0, letterSpacing: 0),),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },),
        SizedBox(height: 20.r),
      ],
    );
  }
}

class TitleWidget extends StatefulWidget {
  final String title;
  final bool? icon;
  final List<Widget> children;
  final int count;

  const TitleWidget(
      {super.key, required this.title, this.icon, required this.children, required this.count});

  @override
  State<TitleWidget> createState() => _TitleWidgetState();
}
RxBool obscureText1 = true.obs;
class _TitleWidgetState extends State<TitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: _toggle,
          child: Container(
            decoration: BoxDecoration(
                color: AllColors.lightTeal.withOpacity(0.3),
                border: Border.symmetric(horizontal: BorderSide(
                  width: 1.r, color: AllColors.black.withOpacity(0.1),))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                RichText(
                  text: TextSpan(
                    text: "::",
                    style: fontBold.copyWith(fontSize: 12.r,
                        color: AllColors.black.withOpacity(0.6)),
                    children: [
                      TextSpan(text: " ${widget.title} ",
                          style: fontBold.copyWith(fontSize: 12.r)),
                      TextSpan(text: "::",
                          style: fontBold.copyWith(fontSize: 12.r,
                              color: AllColors.black.withOpacity(0.6))),
                    ],
                  ),
                ),
                if(widget.icon == true)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 3.r),
                    color: AllColors.lightGrey,
                    child: Icon(obscureText1.value ?
                    Icons.keyboard_arrow_up_outlined:
                    Icons.keyboard_arrow_down_outlined,
                      size: 25.r,
                      color: AllColors.black,
                    ),
                  ),
              ],
            ),
          ),
        ),
        if(obscureText1.value)
          SizedBox(height: 10.r),
        if(obscureText1.value)
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:10.0.r),
              child: Column(
                children: widget.children,
              ),
            ),
          ),
      ],
    );
  }

  void _toggle() {
    setState(() {
      obscureText1.value = !obscureText1.value;
    });
  }
}
