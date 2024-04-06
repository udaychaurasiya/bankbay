
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_dropdown.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/Profile/Profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

final PartnerController _controller = Get.find<PartnerController>();
class _ProfileFormState extends State<ProfileForm> {
  var formKeyProfile =GlobalKey<FormState>(debugLabel: "_formKeyProfile");
  Rx<String?> gender = "Select Gender".obs;
  Rx<String?> marital = "Select Marital".obs;
  Rx<String?> qualification = "Select Qualification".obs;
  @override
  void initState() {
    saveDetailsData();
    super.initState();
  }

  saveDetailsData()async{
    bool status = await _controller. getUserDetailsApi(GetStorage().read(AppConstant.cust_id).toString());
    if(status==true){
      _controller.saveProfileDate();
      gender.value = (_controller.userdetails.value.data.details.custGender!=""&&_controller.userdetails.value.data.details.custGender!=null?_controller.userdetails.value.data.details.custGender.toString().capitalize:"Select Gender");
      marital.value = (_controller.userdetails.value.data.details.custMaritalStatus!=""&&_controller.userdetails.value.data.details.custMaritalStatus!=null?_controller.userdetails.value.data.details.custMaritalStatus.toString().capitalize:"Select Marital");
      qualification.value = (_controller.userdetails.value.data.details.custEducation!=""&&_controller.userdetails.value.data.details.custEducation!=null?_controller.userdetails.value.data.details.custEducation.toString().capitalize:"Select Qualification");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 10.w,right: 10.w),
      child: SingleChildScrollView(
        child: GetBuilder<PartnerController>(builder:(controller) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade50)
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Form(
                    key: formKeyProfile,
                    child: Column(
                      children: [
                        SizedBox(height: 15.r),
                        UnderLineTextField(
                          controller: _controller.pFName,
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
                          controller: _controller.pDob,
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
                              _controller.pDob.text = formattedDate;
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
                            if(value=="Select Gender"){
                              return DropdownMenuItem<String>(
                                value: value,
                                enabled: false,
                                child: Text(value.toString(),style: fontRegular.copyWith(color: AllColors.grey,wordSpacing: 0, letterSpacing: 0),),
                              );
                            }else{
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }
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
                            if(value=="Select Marital"){
                              return DropdownMenuItem<String>(
                                value: value,
                                enabled: false,
                                child: Text(value.toString(),style: fontRegular.copyWith(color: AllColors.grey,wordSpacing: 0, letterSpacing: 0),),
                              );
                            }else{
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }
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
                            if(value=="Select Qualification"){
                              return DropdownMenuItem<String>(
                                value: value,
                                enabled: false,
                                child: Text(value.toString(),style: fontRegular.copyWith(color: AllColors.grey,wordSpacing: 0, letterSpacing: 0),),
                              );
                            }else{
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }
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
                          controller: _controller.pEmail,
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
                          controller: _controller.pFacebook,
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
                          controller: _controller.pLinkedin,
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
                        //     value: _controller.selectCountry,
                        //     items: _controller.countryModel.value.data.map((CountryData items) {
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
                        //       _controller.selectCountry = newValue;
                        //       _controller.pCountry.text = newValue.countryName.toString();
                        //       _controller.countryModel.refresh();
                        //       _controller.selectState = null;
                        //       _controller.getStateNetworkApi(_controller.selectCountry.id.toString());
                        //     },
                        //   ),
                        // SizedBox(height: 8.r),
                        // _controller.stateModel.value.data.isNotEmpty
                        //     ? DropdownButtonFormField(
                        //       value: _controller.selectState,
                        //       items: _controller.stateModel.value.data.map((StateData items){
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
                        //         _controller.selectState=newValue;
                        //         print("state ${newValue.id}");
                        //         _controller.pState.text= newValue.stateName.toString();
                        //         _controller.stateModel.refresh();
                        //       },
                        //     )
                        //     : Container(),
                        SizedBox(height: 8.r),
                        UnderLineTextField(
                          controller: _controller.pPinCode,
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
                          controller: _controller.pAddress,
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
                          controller: _controller.pNumber,
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
                        GetBuilder<PartnerController>(builder:(controller) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0.r),
                          child: CustomButton(
                            title: "Update".tr,
                            bgColor: AllColors.green,
                            background: false,
                            height: 38.r,
                            radius: 5.r,
                            onTap: ()async{
                              if (formKeyProfile.currentState != null && formKeyProfile.currentState!.validate()){
                                bool status = await controller.updateProfileNetwork(qualification.value, marital.value, gender.value);
                                if(status==true){
                                  _otpVerifyBox(context);
                                }
                              }
                            },
                          ),
                        ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  _otpVerifyBox(BuildContext context) {
    _controller.resetTimer();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        child: Container(
          height: 300.r,
          width: double.infinity,
          padding: EdgeInsets.all(10.r),
          child: Column(
            children: [
              SizedBox(height: 10.r),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "Please validate your phone number",
                      style: fontBold.copyWith(fontSize: 13.sp),
                    ),
                  ),
                  InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(
                        Icons.close,
                        size: 22.r,
                        color: AllColors.black,
                      ))
                ],
              ),
              SizedBox(height: 20.r),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("OTP send to +91 ${_controller.pNumber.text}",style: fontExtraSmall.copyWith()),
                  SizedBox(width: 10.r),
                  Obx(() => Text(
                    DateFormat('ss:mm').format(
                        DateTime(0, 0, 0, 0, _controller.seconds.value)),
                    style: fontBold.copyWith(
                      fontSize: 16.r,
                      decoration: TextDecoration.underline,
                      color: _controller.seconds.value==0?AllColors.red:AllColors.green,
                    ),
                  ),
                  ),
                ],
              ),
              SizedBox(height: 15.r),
              SizedBox(
                width: 220.w,
                height: 40.h,
                child: OTPTextField(
                  length: 4,
                  controller: _controller.pOtpVerify,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: 40.w,
                  style:fontBold.copyWith(fontSize: 18.sp,color: Colors.black),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.underline,
                  onCompleted: (pin) {},
                  onChanged: (value){
                    _controller.verifyOtp.value=value;
                  },
                ),
              ),
              SizedBox(height: 30.r,),
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(_controller.seconds.value != 00)
                    Text("Please enter 4 digit code that send \nto your mobile number.", style: fontSmall.copyWith(
                        color: AllColors.black.withOpacity(0.6),
                        fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  if(_controller.seconds.value == 00)
                    Text("Didn't get the code ? ", style: fontMedium.copyWith(
                        color: AllColors.black.withOpacity(0.6),
                        fontWeight: FontWeight.w400),),
                  if(_controller.seconds.value == 00)
                    InkWell(
                      onTap: ()async{
                        if (_controller.seconds.value == 00) {
                          bool status = await _controller.profileResendOTPNetworkApi(context);
                          if(status==true){
                            _controller.resetTimer();
                          }
                        }
                      },
                      child: Text(" Resend Otp ", style: fontMedium.copyWith(
                          color: AllColors.darkBlue.withOpacity(0.8),
                          fontWeight: FontWeight.w400),),
                    ),
                ],
              ),
              ),
              SizedBox(height: 30.r),
              InkWell(
                onTap: ()async{
                  bool status = await _controller.profileOtpVerificationApi(_controller.verifyOtp.value);
                  if(status==true){
                    Navigator.pop(context);
                    profileIndex.value=2;
                    // _controller.getUserDetailsApi();
                  }
                },
                child: CustomButton(
                  background: true,
                  width: 150.r,
                  height: 35.r,
                  radius: 5.r,
                  title: "Validate".tr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
