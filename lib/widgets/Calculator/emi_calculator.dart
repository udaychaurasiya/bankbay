import 'package:bank_bay/controllers/calculator_controller.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/utils_method/custom_appbar.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class EMICalculator extends StatefulWidget {
  const EMICalculator({super.key});

  @override
  State<EMICalculator> createState() => EMICalculatorState();
}

class EMICalculatorState extends State<EMICalculator> {
  var partnerController = Get.find<PartnerController>();
  var calculatorController = Get.put(CalculatorController());
  GlobalKey<FormState> formKeyCheckEMI = GlobalKey<FormState>();

  @override
  void initState() {
    calculatorController.resetEMIData();
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
          title: "EMI Calculator".tr,
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
          child: Obx((){
            return Column(
              children: [
                SizedBox(height: 15.r),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.r),
                  padding: EdgeInsets.all(15.r),
                  color: AllColors.white,
                  child: Form(
                    key: formKeyCheckEMI,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Loan Amount   (₹)", style: fontSmall.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AllColors.black.withOpacity(0.6),
                            ),),
                            SizedBox(width: 10.r),
                            Expanded(
                              child: UnderLineTextField(
                                hint: "                                                 0".tr,
                                label: false,
                                controller: calculatorController.amountEmiController,
                                type: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                length: 20,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter loan amount';
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
                            SizedBox(width: 10.r),
                            Expanded(
                              child: UnderLineTextField(
                                hint: "                                                 0".tr,
                                label: false,
                                controller: calculatorController.interestEmiController,
                                type: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                                length: 20,
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
                            SizedBox(width: width/6),
                            Expanded(
                              child: DropdownButtonFormField<int>(
                                value: calculatorController.selectedYear.value,
                                onChanged: (value) => calculatorController.selectedYear.value = value!,
                                items: List.generate(
                                  21, (index) => DropdownMenuItem(
                                  value: index,
                                  child: Text('Year $index', style: fontRegular.copyWith(
                                    wordSpacing: 0.2,
                                    letterSpacing: 0.8,
                                    color: AllColors.black.withOpacity(0.7),
                                  )),
                                ),
                                ),
                                // validator: (value) {
                                //   if (value == null) {
                                //     return 'select year';
                                //   }else if (value == 0) {
                                //     return 'select year';
                                //   }
                                //   return null;
                                // },
                                hint: Text("Year", style: fontSmall.copyWith(color: AllColors.grey),),
                              ),
                            ),
                            SizedBox(width: 10.r),
                            Expanded(
                              child: DropdownButtonFormField<int>(
                                value: calculatorController.selectedMonth.value,
                                onChanged: (value) => calculatorController.selectedMonth.value = value!,
                                items: List.generate(
                                  13, (index) => DropdownMenuItem(
                                  value: index,
                                  child: Text('Month $index',  style: fontRegular.copyWith(
                                    wordSpacing: 0.2,
                                    letterSpacing: 0.8,
                                    color: AllColors.black.withOpacity(0.7),
                                  )),
                                ),
                                ),
                                // validator: (value) {
                                //   if (value == null) {
                                //     return 'select month';
                                //   }else if (value == 0) {
                                //     return 'select month';
                                //   }
                                //   return null;
                                // },
                                hint: Text("Year", style: fontSmall.copyWith(color: AllColors.grey),),
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
                                if (formKeyCheckEMI.currentState != null && formKeyCheckEMI.currentState!.validate()){
                                  if(calculatorController.selectedYear.value!=0||calculatorController.selectedMonth.value!=0){
                                    calculatorController.calculateEMI();
                                  }else{
                                    BaseController().errorSnack("Please select month or year");
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
                              onTap: calculatorController.resetEMIData,
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
                              Text("Principle Amount",
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
                              Text("Interest Amount",
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
                            Text(calculatorController.percentageEMIValue.value!=0.0?
                            "${100-calculatorController.percentageEMIValue.value*100}%" :"0.0",
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
                              percent: calculatorController.percentageEMIValue.value,
                              backgroundColor: AllColors.yellow.withOpacity(0.9),
                              circularStrokeCap: CircularStrokeCap.square,
                              progressColor: AllColors.deepPurple.withOpacity(0.9),
                            ),
                            Text("${calculatorController.percentageEMIValue.value*100}%",
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
                            Text("Monthly EMI          (₹)",
                              style: fontMedium.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 13.r,
                                color: AllColors.black.withOpacity(0.6),
                              ),
                            ),
                            Expanded(
                              child: Text(partnerController.formatAmount(calculatorController.emi.value.toStringAsFixed(2)),
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
                            Text("Interest Amount    (₹)",
                              style: fontMedium.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 13.r,
                                color: AllColors.black.withOpacity(0.6),
                              ),
                            ),
                            Expanded(
                              child: Text(partnerController.formatAmount(calculatorController.totalInterest.value.toStringAsFixed(2)),
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
                            Text("Total Amount         (₹)",
                              style: fontMedium.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 13.r,
                                color: AllColors.black.withOpacity(0.6),
                              ),
                            ),
                            Expanded(
                              child: Text(partnerController.formatAmount(calculatorController.totalAmount.value.toStringAsFixed(2)),
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
                  color: AllColors.white,
                  child: Column(
                    children: [
                      Container(
                        color: AllColors.lightGrey.withOpacity(0.8),
                        height: 35.r,
                        child: Row(
                          children: [
                            Container(
                              width: width/5,
                              alignment: Alignment.center,
                              child: Text("Month",
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
                              child: Text("Principle",
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
                              child: Text("Interest",
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
                                child: Text("Balance",
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
                      calculatorController.emiDetailsList.isNotEmpty ?
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: calculatorController.emiDetailsList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var details = calculatorController.emiDetailsList[index];
                          return SizedBox(
                            height: 35.r,
                            child: Row(
                              children: [
                                Container(
                                  width: width/5,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(right: 10.r),
                                  child: Text("${details.month}",
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
                                  child: Text(partnerController.formatAmount(details.principalAmount.toStringAsFixed(2)),
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
                                  child: Text(partnerController.formatAmount(details.interestAmount.toStringAsFixed(2)),
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
                                    child: Text(partnerController.formatAmount(details.totalBalance.toStringAsFixed(2)),
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
                      ) :
                      Container(
                        color: AllColors.white,
                        width: Get.width,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 15.0.r, bottom: 15.r),
                        child: Text("Data not found.", style: fontMedium.copyWith(),),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          ),
        ),
      ),
    );
  }
}

class EMIDataDetails {
  final int month;
  final double principalAmount;
  final double interestAmount;
  final double totalBalance;

  EMIDataDetails({
    required this.month,
    required this.principalAmount,
    required this.interestAmount,
    required this.totalBalance,
  });
}
