// ignore_for_file: non_constant_identifier_names

import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/Profile/Profile.dart';
import 'package:bank_bay/widgets/dashboard.dart';
import 'package:bank_bay/widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileDocument extends StatefulWidget {
  const ProfileDocument({super.key});

  @override
  State<ProfileDocument> createState() => _ProfileDocumentState();
}

final LoginController controller = Get.find<LoginController>();
final PartnerController _controller = Get.find<PartnerController>();
class _ProfileDocumentState extends State<ProfileDocument> {
  var address_proof_type = (_controller.userdetails.value.data.partnerdetails.addressProofType.toString()=="rented"?"rented":"owned").obs;
  RxString property_owner_type = (_controller.userdetails.value.data.partnerdetails.propertyOwnerType.toString()=="2"?"Family Proof":"My Proof").obs;
  var pan = "".obs;
  var aadhar = "".obs;
  var banking = "".obs;
  var ownerShip = "".obs;
  var rentAgreement = "".obs;
  var relationShip = "".obs;
  @override
  void initState() {
    pan.value = _controller.userdetails.value.data.partnerdetails.docPan.toString();
    aadhar.value = _controller.userdetails.value.data.partnerdetails.docAadhar.toString();
    banking.value = _controller.userdetails.value.data.partnerdetails.docBanking.toString();
    ownerShip.value = _controller.userdetails.value.data.partnerdetails.docOhp.toString();
    rentAgreement.value = _controller.userdetails.value.data.partnerdetails.docRentAgreement.toString();
    relationShip.value = _controller.userdetails.value.data.partnerdetails.docRelationProof.toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 10.w,right: 10.w),
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Obx(() {
            return Column(
            children: [
              SizedBox(height: 15.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.r),
                    Obx(() => _controller.pPanCardImage.value!=""?
                      ChooseImageDocument(
                        title: "PAN Card".tr,
                        image: _controller.pPanCardImage.value,
                        subTitle: _controller.pPanCardImageName.value!=""?_controller.pPanCardImageName.value:"",
                        onTap: () => profileDocsProofImageBox(context, 1),
                      ) :
                      ChooseImageDocumentView(
                        title: "PAN Card".tr,
                        image: pan.value,
                        subTitle: _controller.pPanCardImageName.value!=""?_controller.pPanCardImageName.value:"",
                        onTap: () => profileDocsProofImageBox(context, 1),
                      ),
                    ),
                    SizedBox(height: 20.r),
                    Obx(() => _controller.pAadhaarCardImage.value!=""?
                      ChooseImageDocument(
                        image: _controller.pAadhaarCardImage.value,
                        subTitle: _controller.pAadhaarCardImageName.value!=""?_controller.pAadhaarCardImageName.value:"Single PDF file",
                        title: "AADHAAR (both sides)".tr,
                        onTap: () => profileDocsProofImageBox(context, 2),
                      ):
                      ChooseImageDocumentView(
                        image: aadhar.value,
                        subTitle: _controller.pAadhaarCardImageName.value!=""?_controller.pAadhaarCardImageName.value:"Single PDF file",
                        title: "AADHAAR (both sides)".tr,
                        onTap: () => profileDocsProofImageBox(context, 2),
                      ),
                    ),
                    SizedBox(height: 20.r),
                    Obx(() => _controller.pBankStatementImage.value!=""?
                      ChooseImageDocument(
                        image: _controller.pBankStatementImage.value,
                        subTitle: _controller.pBankStatementImageName.value!=""?_controller.pBankStatementImageName.value:"latest 6 months",
                        title: "Bank Statement".tr,
                        onTap: () => profileDocsProofImageBox(context, 4),
                      ):
                      ChooseImageDocumentView(
                        image: banking.value,
                        subTitle: _controller.pBankStatementImageName.value!=""?_controller.pBankStatementImageName.value:"latest 6 months",
                        title: "Bank Statement".tr,
                        onTap: () => profileDocsProofImageBox(context, 4),
                      ),
                    ),
                    SizedBox(height: 30.r),
                    Text("Address Proof", style: fontBold.copyWith(),),
                    SizedBox(height: 20.r),
                    Obx(() => Container(
                      height: 30.r,
                      width: Get.width/2,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.r, color: AllColors.blue),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                address_proof_type.value = "owned";
                                property_owner_type.value = "My Proof";
                                print("value ${address_proof_type.value}");
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5.r),bottomLeft: Radius.circular(5.r)),
                                  color:  address_proof_type.value == "owned"?AllColors.blue.withOpacity(0.9):AllColors.white.withOpacity(0.9),
                                ),
                                child: Text("Owned", style: fontBold.copyWith(fontSize: 12.r, color: address_proof_type.value == "owned"?AllColors.white.withOpacity(0.9):AllColors.blue.withOpacity(0.9)),),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                address_proof_type.value = "rented";
                                property_owner_type.value = "My Proof";
                                print("value ${address_proof_type.value}");
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(5.r),bottomRight: Radius.circular(5.r)),
                                  color: address_proof_type.value == "rented"?AllColors.blue.withOpacity(0.9):AllColors.white.withOpacity(0.9),
                                ),
                                child: Text("Rented", style: fontBold.copyWith(fontSize: 12.r,color: address_proof_type.value == "rented"?AllColors.white.withOpacity(0.9):AllColors.blue.withOpacity(0.9)),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                    Padding(
                      padding: EdgeInsets.only(top:20.0.r),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0.r),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: (){
                                    property_owner_type.value = "My Proof";
                                    print("object ${property_owner_type.value}");
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 20.r,
                                        width: 20.r,
                                        child: Radio(
                                          value: "My Proof",
                                          groupValue: property_owner_type.value,
                                          onChanged: (value) {
                                            property_owner_type.value = value.toString();
                                            print("object ${property_owner_type.value}");
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10.r),
                                      Text(
                                        "Property proof is in my name",
                                        style: fontSmall.copyWith(
                                            color: Colors.black.withOpacity(0.7),wordSpacing: 0.2,letterSpacing: 0.1),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.r),
                                InkWell(
                                  onTap: (){
                                    property_owner_type.value = "Family Proof";
                                    print("object ${property_owner_type.value}");
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 20.r,
                                        width: 20.r,
                                        child: Radio(
                                          value: "Family Proof",
                                          groupValue: property_owner_type.value,
                                          onChanged: (value) {
                                            property_owner_type.value = value.toString();
                                            print("object ${property_owner_type.value}");
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10.r),
                                      Text(
                                        "Property proof is in my family member's name",
                                        style: fontSmall.copyWith(
                                            color: Colors.black.withOpacity(0.7),wordSpacing: 0.2,letterSpacing: 0.1),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if(property_owner_type.value=="My Proof" && address_proof_type.value == "owned" || property_owner_type.value=="Family Proof" && address_proof_type.value == "owned")
                            SizedBox(height: 20.r),
                          if(property_owner_type.value=="My Proof" && address_proof_type.value == "owned" || property_owner_type.value=="Family Proof" && address_proof_type.value == "owned")
                            Obx(() => _controller.pOwnerShipProof.value!=""?
                              ChooseImageDocument(
                                image: _controller.pOwnerShipProof.value,
                                subTitle: _controller.pOwnerShipProofName.value!=""?_controller.pOwnerShipProofName.value:"Electric bill/ Holding tax / Sale deep any ONE",
                                title: "Ownership Proof".tr,
                                onTap: () => profileDocsProofImageBox(context, 5),
                              ):
                              ChooseImageDocumentView(
                                image: ownerShip.value,
                                subTitle: _controller.pOwnerShipProofName.value!=""?_controller.pOwnerShipProofName.value:"Electric bill/ Holding tax / Sale deep any ONE",
                                title: "Ownership Proof".tr,
                                onTap: () => profileDocsProofImageBox(context, 5),
                              ),
                            ),
                          if(address_proof_type.value == "rented"&&property_owner_type.value=="My Proof" || property_owner_type.value=="Family Proof" && address_proof_type.value == "rented")
                            SizedBox(height: 20.r),
                          if(address_proof_type.value == "rented"&&property_owner_type.value=="My Proof" || property_owner_type.value=="Family Proof" && address_proof_type.value == "rented")
                            Obx(() => _controller.pRentAgreement.value!=""?
                              ChooseImageDocument(
                                image: _controller.pRentAgreement.value,
                                subTitle: _controller.pRentAgreementName.value!=""?_controller.pRentAgreementName.value: "latest 3 months",
                                title: "Rent Agreement".tr,
                                onTap: () => profileDocsProofImageBox(context, 3),
                              ):
                              ChooseImageDocumentView(
                                image: rentAgreement.value,
                                subTitle: _controller.pRentAgreementName.value!=""?_controller.pRentAgreementName.value: "latest 3 months",
                                title: "Rent Agreement".tr,
                                onTap: () => profileDocsProofImageBox(context, 3),
                              ),
                            ),
                          if(property_owner_type.value=="Family Proof" && address_proof_type.value == "owned"||property_owner_type.value=="Family Proof" && address_proof_type.value == "rented")
                          SizedBox(height: 20.r),
                          if(property_owner_type.value=="Family Proof" && address_proof_type.value == "owned"||property_owner_type.value=="Family Proof" && address_proof_type.value == "rented")
                          Obx(() => _controller.pRelationshipProof.value!=""?
                            ChooseImageDocument(
                              image: _controller.pRelationshipProof.value,
                              subTitle: _controller.pRelationshipProofName.value!=""?_controller.pRelationshipProofName.value:"Aadhaar/PAN/DL or Marriage certificate that shows relationship with property owner",
                              title: "Relationship proof".tr,
                              onTap: () => profileDocsProofImageBox(context, 6),
                            ):
                            ChooseImageDocumentView(
                              image: relationShip.value,
                              subTitle: _controller.pRelationshipProofName.value!=""?_controller.pRelationshipProofName.value:"Aadhaar/PAN/DL or Marriage certificate that shows relationship with property owner",
                              title: "Relationship proof".tr,
                              onTap: () => profileDocsProofImageBox(context, 6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.r),
              InkWell(
                onTap: () async{
                  if (_controller.pPanCardImage.value != "" || _controller.pAadhaarCardImage.value != ""
                      ||_controller.pBankStatementImage.value != "" ||_controller.pOwnerShipProof.value != ""
                      ||_controller.pRentAgreement.value != "" ||_controller.pRelationshipProof.value != ""
                      || pan.value != ""|| aadhar.value != "" || banking.value != "" || ownerShip.value != ""
                      || rentAgreement.value != "" || relationShip.value != ""
                  ) {
                    bool status = await _controller.profileUploadDocumentNetworkApi(property_owner_type.value=="Family Proof"?2:1, address_proof_type.value);
                    if(status==true){
                      profileCompleteDialogBox(context);
                    }
                  }else{
                    BaseController().errorSnack("Please choose all document images");
                  }
                },
                child: Container(
                  height: 40.h,
                  width:170.w,
                  decoration: BoxDecoration(
                      color: AllColors.darkBlue,
                      border: Border.all(color: AllColors.darkBlue)
                  ),
                  child: Center(
                    child: Text("Update",style: fontBold.copyWith(color: Colors.white),),
                  ),
                ),
              ),
              SizedBox(height: 65.r),
            ],
          );
          },
          ),
        ),
      ),
    );
  }

  profileCompleteDialogBox(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        child: Container(
          height: 260.r,
          width: double.infinity,
          padding: EdgeInsets.all(10.r),
          child: Column(
            children: [
              SizedBox(height: 10.r),
              Text("Hooray !!",style: fontBold.copyWith(fontSize: 19.r)),
              SizedBox(height: 40.r),
              Text("Your profile is completed.",style: fontBold.copyWith(fontSize: 18.r)),
              SizedBox(height: 20.r),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 15.0.r),
                child: Text("We are evaluating your profile. You should ba able o add lead for your customers shortly",
                  style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.5)),
                ),
              ),
              SizedBox(height: 30.r),
              InkWell(
                onTap: ()async{
                  Get.offAll(() => const DashboardScreen());
                  controller.index.value=0;
                  indexValue.value=1;
                  BaseController().successSnack("Your request have been successfully submitted!!");
                },
                child: CustomButton(
                  background: true,
                  width: 60.r,
                  height: 30.r,
                  radius: 3.r,
                  title: "Ok".tr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  profileDocsProofImageBox(BuildContext context, type) {
    showDialog(
      context: context,
      builder: (BuildContext context,) {
        return AlertDialog(
          content: SizedBox(
            height: 180.r,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25.r, right: 25.r, top: 20.r),
                  child: Column(
                    children: [
                      Text(
                        "Choose Image",
                        style: fontBold.copyWith(fontSize: 18.r),
                      ),
                      SizedBox(height: 15.r),
                      Container(
                        height: 2.r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: AllColors.lightGrey.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.r),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        _controller.profileDocumentImages(false,type);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0.r),
                        child: Column(
                          children: [
                            Image.asset(
                              Images.gallery,
                              height: 50.r,
                              width: 50.r,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 5.r),
                            Text(
                              "Gallery",
                              style: fontMedium.copyWith(fontSize: 15.r),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 1.r,
                      height: 40.r,
                      color: AllColors.lightGrey.withOpacity(0.8),
                      margin: EdgeInsets.symmetric(vertical: 5.r),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        _controller.profileDocumentImages(true,type);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0.r),
                        child: Column(
                          children: [
                            Image.asset(
                              Images.camera,
                              height: 50.r,
                              width: 50.r,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 5.r),
                            Text(
                              "Camera",
                              style: fontMedium.copyWith(fontSize: 15.r),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
          contentPadding: EdgeInsets.zero,
          actionsOverflowButtonSpacing: 0,
          actionsOverflowDirection: VerticalDirection.down,
          actions: [
            Container(
              color: Colors.red,
            )
          ],
        );
      },
    );
  }
}
