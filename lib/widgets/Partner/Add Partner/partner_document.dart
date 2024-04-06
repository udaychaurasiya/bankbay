import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/document_upload_widget.dart';
import 'package:bank_bay/widgets/Partner/create_partner.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PartnerDocument extends StatefulWidget {
  const PartnerDocument({super.key});

  @override
  State<PartnerDocument> createState() => _PartnerDocumentState();
}

class _PartnerDocumentState extends State<PartnerDocument> {
PartnerController controller = Get.find<PartnerController>();
var property_owner_type = "My Proof".obs;
var address_proof_type = "owned".obs;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
      margin: EdgeInsets.only(bottom: 10.r),
      color: AllColors.white.withOpacity(0.9),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Awesome, ",
                style: fontSmall.copyWith(color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "Phone is validated.",
                style: fontSmall.copyWith(color: Colors.black.withOpacity(0.7)),
              ),
            ],
          ),
          SizedBox(height: 2.r),
          Text(
            "Please upload below documents",
            style: fontSmall.copyWith(color: Colors.black.withOpacity(0.7)),
          ),
          SizedBox(height: 25.r),
          Obx(() => ChooseImageWidget(
            title: "PAN Card".tr,
            image: controller.panCardImage.value,
            subTitle: controller.panCardImageName.value!=""?controller.panCardImageName.value:"",
            onTap: () => partnerDocumentProofImageBox(context, 1),
          ),
          ),
          SizedBox(height: 20.r),
          Obx(() => ChooseImageWidget(
            image: controller.aadhaarCardImage.value,
            subTitle: controller.aadhaarCardImageName.value!=""?controller.aadhaarCardImageName.value:"Single PDF file",
            title: "AADHAAR (both sides)".tr,
            onTap: () => partnerDocumentProofImageBox(context, 2),
          ),
          ),
          SizedBox(height: 20.r),
          Obx(() => ChooseImageWidget(
            image: controller.bankStatementImage.value,
            subTitle: controller.bankStatementImageName.value!=""?controller.bankStatementImageName.value:"latest 6 months",
            title: "Bank Statement".tr,
            onTap: () => partnerDocumentProofImageBox(context, 4),
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
                      print("value ${address_proof_type.value}");
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(5.r),bottomLeft: Radius.circular(5.r)),
                        color:  address_proof_type.value == "owned"?AllColors.blue.withOpacity(0.9):AllColors.white.withOpacity(0.9),
                      ),
                      child: Text("Owned", style: fontBold.copyWith(fontSize: 12.r, color: address_proof_type.value == "owned" ?AllColors.white.withOpacity(0.9):AllColors.blue.withOpacity(0.9)),),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      address_proof_type.value = "rented";
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){
                        controller.bankStatementImageName = "".obs;
                        controller.ownerShipProofName = "".obs;
                        controller.relationshipProofName = "".obs;
                        property_owner_type.value = "My Proof";
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
                        controller.bankStatementImageName = "".obs;
                        controller.ownerShipProofName = "".obs;
                        controller.relationshipProofName = "".obs;
                        property_owner_type.value = "Family Proof";
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
                if(address_proof_type.value == "owned" && (property_owner_type.value=="My Proof"||property_owner_type.value=="Family Proof"))
                  SizedBox(height: 20.r),
                if(address_proof_type.value == "owned" && (property_owner_type.value=="My Proof"||property_owner_type.value=="Family Proof"))
                  Obx(() => ChooseImageWidget(
                    image: controller.ownerShipProof.value,
                    subTitle: controller.ownerShipProofName.value!=""?controller.ownerShipProofName.value:"Electric bill/ Holding tax / Sale deep any ONE",
                    title: "Ownership Proof".tr,
                    onTap: () => partnerDocumentProofImageBox(context, 5),
                  ),),
                  if(address_proof_type.value == "rented" && (property_owner_type.value=="My Proof"||property_owner_type.value=="Family Proof"))
                  SizedBox(height: 20.r),
                if(address_proof_type.value == "rented" && (property_owner_type.value=="My Proof"||property_owner_type.value=="Family Proof"))
                  Obx(() => ChooseImageWidget(
                    image: controller.rentAgreement.value,
                    subTitle: controller.rentAgreementName.value!=""?controller.rentAgreementName.value: "latest 3 months",
                    title: "Rent Agreement".tr,
                    onTap: () => partnerDocumentProofImageBox(context, 3),
                  ),
                  ),
                if((address_proof_type.value == "owned" || address_proof_type.value == "rented") && property_owner_type.value=="Family Proof")
                SizedBox(height: 20.r),
                if((address_proof_type.value == "owned" || address_proof_type.value == "rented") && property_owner_type.value=="Family Proof")
                Obx(() => ChooseImageWidget(
                  image: controller.relationshipProof.value,
                  subTitle: controller.relationshipProofName.value!=""?controller.relationshipProofName.value:"Aadhaar/PAN/DL or Marriage certificate that shows relationship with property owner",
                  title: "Relationship proof".tr,
                  onTap: () => partnerDocumentProofImageBox(context, 6),
                )),
              ],
            ),
          ),
          SizedBox(height: 30.r),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LightCustomButton(
                title: "Back".tr,
                height: 28.r,
                width: 100.r,
                background: false,
                onTap: () => addPartnerTab.value=5,
              ),
              SizedBox(width: 15.r),
              CustomButton(
                title: "Next".tr,
                background: true,
                radius: 30.r,
                height: 30.r,
                width: Get.width - 240,
                onTap: () async{
                  if (controller.panCardImage.value != "" || controller.aadhaarCardImage.value != "" ||controller.rentAgreement.value != "" ||controller.bankStatementImage.value != "" ||controller.ownerShipProof.value != "" ||controller.relationshipProof.value != "" ) {
                    bool status = await controller.partnerUploadDocumentNetworkApi(property_owner_type.value=="Family Proof"?2:1, address_proof_type.value);
                    if(status==true){
                      addPartnerTab.value=7;
                    }
                  }else{
                    BaseController().errorSnack("Please choose all document images");
                  }
                },
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }

  partnerDocumentProofImageBox(BuildContext context, type) {
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
                        controller.partnerDocumentImages(false,type);
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
                        controller.partnerDocumentImages(true,type);
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
