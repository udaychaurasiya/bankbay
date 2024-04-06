import 'package:bank_bay/controllers/calculator_controller.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_appbar.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SIPCalculator extends StatefulWidget {
  const SIPCalculator({super.key});

  @override
  State<SIPCalculator> createState() => SIPCalculatorState();
}

class SIPCalculatorState extends State<SIPCalculator> {
  var partnerController = Get.find<PartnerController>();
  var calculatorController = Get.put(CalculatorController());
  GlobalKey<FormState> formKeyCheckSIP = GlobalKey<FormState>();

  @override
  void initState() {
    calculatorController.resetSIPData();
    calculatorController.resetSIPDataYearly();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          50.0.r,
        ),
        child: CustomAppBar(
          title: "SIP Calculator".tr,
          leadingBool: false,
          back: true,
          onTab: ()async{
            Get.back();
          },
        ),
      ),
      body: Container(
        color: Colors.lightBlue.withOpacity(0.1),
        child: SingleChildScrollView(
          child: Obx(() => Column(
              children: [
                SizedBox(height: 15.r),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.r),
                  padding: EdgeInsets.all(15.r),
                  color: AllColors.white,
                  child: Form(
                    key: formKeyCheckSIP,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                partnerController.handleRadioValueChanged(1);
                                calculatorController.resetSIPData();
                                calculatorController.resetSIPDataYearly();
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 18.r,
                                    width: 30.r,
                                    child: Radio(
                                      value: 1,
                                      groupValue: partnerController.radioSelected.value,
                                      activeColor: AllColors.green,
                                      onChanged: (value) {
                                        partnerController.handleRadioValueChanged(1);
                                        calculatorController.resetSIPData();
                                        calculatorController.resetSIPDataYearly();
                                      },
                                    ),
                                  ),
                                  Text('Monthly', style: fontMedium.copyWith(fontSize: 13.r),),
                                ],
                              ),
                            ),
                            SizedBox(width: 12.r),
                            InkWell(
                              onTap: (){
                                partnerController.handleRadioValueChanged(2);
                                calculatorController.resetSIPData();
                                calculatorController.resetSIPDataYearly();
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 18.r,
                                    width: 30.r,
                                    child: Radio(
                                      value: 2,
                                      groupValue: partnerController.radioSelected.value,
                                      activeColor: AllColors.green,
                                      onChanged: (value){
                                        partnerController.handleRadioValueChanged(2);
                                        calculatorController.resetSIPData();
                                        calculatorController.resetSIPDataYearly();
                                      },
                                    ),
                                  ),
                                  Text('Yearly', style: fontMedium.copyWith(fontSize: 13.r),),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.r),
                        Row(
                          children: [
                            Text("Monthly Investment   (₹)", style: fontSmall.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AllColors.black.withOpacity(0.6),
                            ),),
                            SizedBox(width: 10.r),
                            Expanded(
                              child: UnderLineTextField(
                                hint: "                                      0".tr,
                                label: false,
                                // textDirection: TextDirection.rtl,
                                controller: calculatorController.investmentController,
                                type: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                length: 30,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter monthly investment';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.r),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Interest Rate   (%)", style: fontSmall.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AllColors.black.withOpacity(0.6),
                            ),),
                            SizedBox(width: 40.r),
                            Expanded(
                              child: UnderLineTextField(
                                hint: "                                         0".tr,
                                label: false,
                                // textDirection: TextDirection.rtl,
                                controller: calculatorController.interestSipController,
                                type: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                                length: 30,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter interest rate';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.r),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Duration ", style: fontSmall.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AllColors.black.withOpacity(0.6),
                            ),),
                            SizedBox(width: width/5),
                            Expanded(
                              child: UnderLineTextField(
                                hint: "                                              0".tr,
                                // textDirection: TextDirection.rtl,
                                label: false,
                                controller: calculatorController.durationSipController,
                                type: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                length: 30,
                                onTap: (){},
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter duration';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.r),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: (){
                                if (formKeyCheckSIP.currentState != null && formKeyCheckSIP.currentState!.validate()){
                                  if(partnerController.radioSelected.value==1){
                                    calculatorController.calculateSIP();
                                  }else if(partnerController.radioSelected.value==2){
                                    calculatorController.calculateSIPYearly();
                                    print(" jhbx @ 2");
                                  }
                                }
                              },
                              child: Container(
                                width: width/3.5,
                                height: 30.r,
                                color: AllColors.themeColor,
                                alignment: Alignment.center,
                                child: Text("Calculator ", style: fontMedium.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AllColors.white,
                                  fontSize: 13.r,
                                ),),
                              ),
                            ),
                            SizedBox(width: 20.r),
                            InkWell(
                              onTap: (){
                                calculatorController.resetSIPData();
                                calculatorController.resetSIPDataYearly();
                              },
                              child: Container(
                                width: width/3.8,
                                height: 30.r,
                                color: AllColors.grey.withOpacity(0.5),
                                alignment: Alignment.center,
                                child: Text("Reset ", style: fontMedium.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AllColors.black,
                                  fontSize: 13.r,
                                ),),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.r),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.r),
                  padding: EdgeInsets.all(10.r),
                  color: AllColors.white,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Summary result",
                            style: fontExtraSmall.copyWith(
                            fontWeight: FontWeight.w500,
                            wordSpacing: 0,
                            letterSpacing: 0,
                            color: AllColors.black.withOpacity(0.6),
                            ),
                          ),
                          SizedBox(width: 10.r),
                          Row(
                            children: [
                              Container(
                                width: 25.r,
                                height: 10.r,
                                color: AllColors.deepPurple.withOpacity(0.5),
                              ),
                              SizedBox(width: 5.r),
                              Text("Investment",
                                style: fontExtraSmall.copyWith(
                                  fontWeight: FontWeight.w500,
                                  wordSpacing: 0,
                                  letterSpacing: 0,
                                  color: AllColors.black.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 10.r),
                          Row(
                            children: [
                              Container(
                                width: 25.r,
                                height: 10.r,
                                color: AllColors.yellow.withOpacity(0.9),
                              ),
                              SizedBox(width: 5.r),
                              Text("Profit Earned",
                                style: fontExtraSmall.copyWith(
                                  fontWeight: FontWeight.w500,
                                  wordSpacing: 0,
                                  letterSpacing: 0,
                                  color: AllColors.black.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0.r, vertical: 15.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(calculatorController.percentageSIPValue.value!=0.0?
                            "${100-calculatorController.percentageSIPValue.value*100}%" :"0.0",
                              style: fontExtraBold.copyWith(
                                fontSize: 22.r,
                                wordSpacing: 0,
                                letterSpacing: 0,
                                color: AllColors.yellow.withOpacity(0.9),
                              ),
                            ),
                            CircularPercentIndicator(
                              radius: 80.0,
                              lineWidth: 14.0,
                              animation: true,
                              percent: calculatorController.percentageSIPValue.value,
                              backgroundColor: AllColors.yellow.withOpacity(0.9),
                              circularStrokeCap: CircularStrokeCap.square,
                              progressColor: AllColors.deepPurple.withOpacity(0.9),
                            ),
                            Text("${calculatorController.percentageSIPValue.value*100}%",
                              style: fontExtraBold.copyWith(
                                fontSize: 22.r,
                                wordSpacing: 0,
                                letterSpacing: 0,
                                color: AllColors.deepPurple.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.r),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Expected Amount         (₹)",
                              style: fontMedium.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.r,
                              color: AllColors.black.withOpacity(0.6),
                              ),
                            ),
                            Expanded(
                              child: Text(partnerController.formatAmount(calculatorController.investedAmount.toStringAsFixed(2)),
                                style: fontMedium.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15.r,
                                  color: AllColors.black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.r),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Amount Invested    (₹)",
                              style: fontMedium.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.r,
                              color: AllColors.black.withOpacity(0.6),
                              ),
                            ),
                            Expanded(
                              child: Text(partnerController.formatAmount(calculatorController.expectedAmount.toStringAsFixed(2)),
                                style: fontMedium.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15.r,
                                  color: AllColors.black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.r),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total Profit         (₹)",
                              style: fontMedium.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.r,
                              color: AllColors.black.withOpacity(0.6),
                              ),
                            ),
                            Expanded(
                              child: Text(partnerController.formatAmount(calculatorController.totalProfit.toStringAsFixed(2)),
                                style: fontMedium.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15.r,
                                  color: AllColors.black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.r),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.r),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.grey.shade100,
                        height: 35.r,
                        child: Row(
                          children: [
                           Container(
                             width: width/5.5,
                             alignment: Alignment.center,
                             child: Text(partnerController.radioSelected.value==2?"Yearly":"Month",
                               style: fontBold.copyWith(
                                 fontSize: 13.r,
                                 color: AllColors.black.withOpacity(0.9),
                                 overflow: TextOverflow.ellipsis,
                               ),
                             ),
                            ),
                            SizedBox(width: 5.r),
                            Container(
                              width: width/4.2  ,
                              alignment: Alignment.center,
                              child: Text("Investment",
                                style: fontBold.copyWith(
                                  fontSize: 13.r,
                                  color: AllColors.black.withOpacity(0.9),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            SizedBox(width: 5.r),
                            Container(
                              width: width/4.2,
                              alignment: Alignment.center,
                              child: Text("Profit",
                                style: fontBold.copyWith(
                                  fontSize: 13.r,
                                  color: AllColors.black.withOpacity(0.9),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            SizedBox(width: 5.r),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text("Amount",
                                  style: fontBold.copyWith(
                                    fontSize: 13.r,
                                    color: AllColors.black.withOpacity(0.9),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(() {
                        if(partnerController.radioSelected.value==1){
                          if(calculatorController.sipDetailsList.isNotEmpty){
                            return ListView.builder(
                              itemCount: calculatorController.sipDetailsList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                SIPDataDetails data = calculatorController.sipDetailsList[index];
                                return Container(
                                  color: AllColors.white,
                                  height: 35.r,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: width/5.5,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(right: 10.r),
                                        child: Text("${data.month}",
                                          style: fontMedium.copyWith(
                                            fontSize: 13.r,
                                            color: AllColors.black.withOpacity(0.6),
                                            overflow: TextOverflow.ellipsis,
                                            wordSpacing: 0,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5.r),
                                      Container(
                                        width: width/4.2,
                                        alignment: Alignment.center,
                                        child: Text(partnerController.formatAmount(data.investment.toStringAsFixed(2)),
                                          style: fontMedium.copyWith(
                                            fontSize: 13.r,
                                            color: AllColors.black.withOpacity(0.6),
                                            overflow: TextOverflow.ellipsis,
                                            wordSpacing: 0,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5.r),
                                      Container(
                                        width: width/4.2,
                                        alignment: Alignment.center,
                                        child: Text(partnerController.formatAmount(data.profit.toStringAsFixed(2)),
                                          style: fontMedium.copyWith(
                                            fontSize: 13.r,
                                            color: AllColors.black.withOpacity(0.6),
                                            overflow: TextOverflow.ellipsis,
                                            wordSpacing: 0,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5.r),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(partnerController.formatAmount(data.totalAmount.toStringAsFixed(2)),
                                            style: fontMedium.copyWith(
                                              fontSize: 13.r,
                                              color: AllColors.black.withOpacity(0.6),
                                              overflow: TextOverflow.ellipsis,
                                              wordSpacing: 0,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                          else{
                            return Container(
                              color: AllColors.white,
                              width: Get.width,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: 15.0.r, bottom: 15.r),
                              child: Text("Data not found.", style: fontMedium.copyWith(),),
                            );
                          }
                        }else if(partnerController.radioSelected.value==2){
                          if(calculatorController.yearDetailsList.isNotEmpty){
                            return ListView.builder(
                              itemCount: calculatorController.yearDetailsList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                SIPDataDetails data = calculatorController.yearDetailsList[index];
                                return Container(
                                  color: AllColors.white,
                                  height: 35.r,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: width/5.5,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(right: 10.r),
                                        child: Text("${data.month}",
                                          style: fontMedium.copyWith(
                                            fontSize: 13.r,
                                            color: AllColors.black.withOpacity(0.6),
                                            overflow: TextOverflow.ellipsis,
                                            wordSpacing: 0,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5.r),
                                      Container(
                                        width: width/4.2,
                                        alignment: Alignment.center,
                                        child: Text(partnerController.formatAmount(data.investment.toStringAsFixed(2)),
                                          style: fontMedium.copyWith(
                                            fontSize: 13.r,
                                            color: AllColors.black.withOpacity(0.6),
                                            overflow: TextOverflow.ellipsis,
                                            wordSpacing: 0,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5.r),
                                      Container(
                                        width: width/4.2,
                                        alignment: Alignment.center,
                                        child: Text(partnerController.formatAmount(data.profit.toStringAsFixed(2)),
                                          style: fontMedium.copyWith(
                                            fontSize: 13.r,
                                            color: AllColors.black.withOpacity(0.6),
                                            overflow: TextOverflow.ellipsis,
                                            wordSpacing: 0,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5.r),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(partnerController.formatAmount(data.totalAmount.toStringAsFixed(2)),
                                            style: fontMedium.copyWith(
                                              fontSize: 13.r,
                                              color: AllColors.black.withOpacity(0.6),
                                              overflow: TextOverflow.ellipsis,
                                              wordSpacing: 0,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                          else{
                            return Container(
                              color: AllColors.white,
                              width: Get.width,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: 15.0.r, bottom: 15.r),
                              child: Text("Data not found.", style: fontMedium.copyWith(),),
                            );
                          }
                        }else{
                          return const SizedBox();
                        }
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SIPDataDetails {
  final int month;
  final double investment;
  final double profit;
  final double totalAmount;

  SIPDataDetails({
    required this.month,
    required this.investment,
    required this.profit,
    required this.totalAmount,
  });
}