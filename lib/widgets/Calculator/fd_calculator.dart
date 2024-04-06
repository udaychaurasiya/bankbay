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

class FDCalculator extends StatefulWidget {
  const FDCalculator({super.key});

  @override
  State<FDCalculator> createState() => FDCalculatorState();
}

class FDCalculatorState extends State<FDCalculator> {
  var partnerController = Get.find<PartnerController>();
  var calculatorController = Get.put(CalculatorController());
  GlobalKey<FormState> formKeyCheckFD = GlobalKey<FormState>();

  @override
  void initState() {
    calculatorController.resetFDData();
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
          title: "FD Calculator".tr,
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
                  key: formKeyCheckFD,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Investment       (₹)", style: fontSmall.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AllColors.black.withOpacity(0.6),
                          ),),
                          SizedBox(width: 10.r),
                          Expanded(
                            child: UnderLineTextField(
                              hint: "                                                 0".tr,
                              label: false,
                              controller: calculatorController.amountFdController,
                              type: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                              length: 20,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter investment';
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
                              controller: calculatorController.interestFdRate,
                              type: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                              value: calculatorController.selectedFdYear.value,
                              onChanged: (value) => calculatorController.selectedFdYear.value = value!,
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
                              //     if (value == null) {
                              //       return 'select year';
                              //     }else if (value == 0) {
                              //       return 'select year';
                              //     }
                              //     return null;
                              //   },
                              hint: Text("Year", style: fontSmall.copyWith(color: AllColors.grey),),
                            ),
                          ),
                          SizedBox(width: 10.r),
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: calculatorController.selectedFdMonth.value,
                              onChanged: (value) => calculatorController.selectedFdMonth.value = value!,
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
                              //     if (value == null) {
                              //       return 'select month';
                              //     }else if (value == 0) {
                              //       return 'select month';
                              //     }
                              //     return null;
                              //   },
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
                              if (formKeyCheckFD.currentState != null && formKeyCheckFD.currentState!.validate()){
                                if(calculatorController.selectedFdYear.value!=0||calculatorController.selectedFdMonth.value!=0){
                                  calculatorController.calculateFd();
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
                            onTap: calculatorController.resetFDData,
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
                          Text(calculatorController.percentageFDValue.value!=0.0?
                           "${100-calculatorController.percentageFDValue.value*100}%" :"0.0",
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
                            percent: calculatorController.percentageFDValue.value,
                            backgroundColor: AllColors.yellow.withOpacity(0.9),
                            circularStrokeCap: CircularStrokeCap.square,
                            progressColor: AllColors.deepPurple.withOpacity(0.9),
                          ),
                          Text("${calculatorController.percentageFDValue.value*100}%",
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
                            child: Text(partnerController.formatAmount(calculatorController.totalFdProfit.value.toStringAsFixed(2)),
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
                            child: Text(partnerController.formatAmount(calculatorController.investedFdAmount.value.toStringAsFixed(2)),
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
                            child: Text(partnerController.formatAmount(calculatorController.totalFdValue.value.toStringAsFixed(2)),
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
                    calculatorController.fdDetailsList.isNotEmpty ?
                    ListView.builder(
                      itemCount: calculatorController.fdDetailsList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var data = calculatorController.fdDetailsList[index];
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
          ),
          ),
        ),
      ),
    );
  }
}

class FDDataDetails {
  final int month;
  final double investment;
  final double profit;
  final double totalAmount;

  FDDataDetails({
    required this.month,
    required this.investment,
    required this.profit,
    required this.totalAmount,
  });
}
