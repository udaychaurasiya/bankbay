import 'dart:math';
import 'package:bank_bay/widgets/Calculator/emi_calculator.dart';
import 'package:bank_bay/widgets/Calculator/fd_calculator.dart';
import 'package:bank_bay/widgets/Calculator/sip_calculator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorController extends GetxController {
  GetStorage storage = GetStorage();

  /// EMI calculator codes
  final TextEditingController amountEmiController = TextEditingController();
  final TextEditingController interestEmiController = TextEditingController();
  final RxInt selectedYear = 0.obs;
  final RxInt selectedMonth = 0.obs;
  final RxDouble emi = 0.0.obs;
  final RxDouble totalAmount = 0.0.obs;
  final RxDouble totalInterest = 0.0.obs;
  final RxDouble percentageEMIValue = 0.0.obs;
  final RxDouble percentageSIPValue = 0.0.obs;
  final RxDouble percentageFDValue = 0.0.obs;
  var emiDetailsList = <EMIDataDetails>[].obs;

  void calculateEMI() {
    Parser p = Parser();
    ContextModel cm = ContextModel();
    double principal = double.parse(amountEmiController.text);
    double interestRate = double.parse(interestEmiController.text) / 100 / 12;
    int tenureInMonths = selectedYear.value * 12 + selectedMonth.value;
    String expression = "(p * i * (1 + i)^t) / ((1 + i)^t - 1)";
    Expression exp = p.parse(expression);
    cm.bindVariableName('p', Variable('p'));
    cm.bindVariableName('i', Variable('i'));
    cm.bindVariableName('t', Variable('t'));
    cm.bindVariable(Variable('p'), Number(principal));
    cm.bindVariable(Variable('i'), Number(interestRate));
    cm.bindVariable(Variable('t'), Number(tenureInMonths.toDouble()));
    double emiResult = exp.evaluate(EvaluationType.REAL, cm);
    double totalAmountResult = emiResult * tenureInMonths;

    emi.value = emiResult;
    totalAmount.value = totalAmountResult;
    totalInterest.value = totalAmountResult - principal;
    emiDetailsList.clear();
    double principalRemaining = principal;
    for (int i = 1; i <= tenureInMonths; i++) {
      double interest = (principalRemaining * interestRate);
      double principalPaid = emiResult - interest;
      principalRemaining -= principalPaid;
      EMIDataDetails details = EMIDataDetails(
        month: i,
        principalAmount: principalPaid,
        interestAmount: interest,
        totalBalance: principalRemaining,
      );
      emiDetailsList.add(details);
    }
    convertDecimalValue(totalAmount.value.toStringAsFixed(0), principal, 1);
  }
  void resetEMIData() {
    amountEmiController.text = '';
    interestEmiController.text = '';
    selectedYear.value = 0;
    selectedMonth.value = 0;
    emi.value = 0.0;
    totalAmount.value = 0.0;
    totalInterest.value = 0.0;
    percentageEMIValue.value = 0.0;
    emiDetailsList.clear();
  }

  /// SIP calculator codes
  var investmentController = TextEditingController();
  var interestSipController = TextEditingController();
  var durationSipController = TextEditingController();
  var investedAmount = 0.0.obs;
  var expectedAmount = 0.0.obs;
  var totalProfit = 0.0.obs;
  var sipDetailsList = <SIPDataDetails>[].obs;
  var yearDetailsList = <SIPDataDetails>[].obs;

  void calculateSIP() {
    double amount = double.parse(investmentController.text);
    double interestRate = double.parse(interestSipController.text);
    int months = int.parse(durationSipController.text);
    double monthlyInterest = interestRate / 100;
    // double monthlyInterest = interestRate / 12 / 100;
    // Using math_expressions to calculate power
    Expression power = Power(1 + monthlyInterest, months);
    double sipAmount = (amount * monthlyInterest * power.evaluate(EvaluationType.REAL, ContextModel()));
    investedAmount.value = sipAmount * months;
    expectedAmount.value = investedAmount.value;
    double ttlProfit = investedAmount.value - amount;
    if(ttlProfit>0) {
      totalProfit.value = ttlProfit;
    }else{
      totalProfit.value = 0;
    }
    sipDetailsList.clear();
    double totalAmount = 0;
    for (int i = 1; i <= months; i++) {
      double monthlyInvestment = sipAmount;
      double monthlyProfit = (amount * monthlyInterest * pow(1 + monthlyInterest, i - 1)) - (monthlyInvestment * i - amount);
      totalAmount += monthlyInvestment;
      sipDetailsList.add(
        SIPDataDetails(
          month: i,
          investment: monthlyInvestment,
          profit: monthlyProfit,
          totalAmount: totalAmount,
        ),
      );
    }
    convertDecimalValue(totalProfit.value.toStringAsFixed(0), amount, 2);
  }

  void resetSIPData() {
    investmentController.clear();
    interestSipController.clear();
    durationSipController.clear();
    investedAmount.value = 0.0;
    expectedAmount.value = 0.0;
    totalProfit.value = 0.0;
    percentageSIPValue.value = 0.0;
    sipDetailsList.clear();
  }

  void calculateSIPYearly() {
    double amount = double.parse(investmentController.text);
    double interestRate = double.parse(interestSipController.text);
    double monthlyInterest = interestRate / 100;
    int years =  int.parse(durationSipController.text);
    int totalMonths = years * 12;
    Expression power = Power(1 + monthlyInterest, totalMonths);
    double sipAmount = (amount * monthlyInterest * power.evaluate(EvaluationType.REAL, ContextModel()));
    investedAmount.value = sipAmount * totalMonths;
    expectedAmount.value = investedAmount.value;
    totalProfit.value = investedAmount.value - amount;
    if (kDebugMode) {
      print("hxb ${investedAmount.value } shs ${expectedAmount.value} hsb ${totalProfit.value}");
    }
    yearDetailsList.clear();
    double totalAmount = 0;
    for (int i = 1; i <= totalMonths; i++) {
      double monthlyInvestment = sipAmount;
      double monthlyProfit = (amount * monthlyInterest * pow(1 + monthlyInterest, i - 1)) -
          (monthlyInvestment * i - amount);
      totalAmount += monthlyInvestment;
      if (i % 12 == 0) {
        int currentYear = i ~/ 12;
        yearDetailsList.add(
          SIPDataDetails(
            month: currentYear,
            investment: monthlyInvestment * 12,
            profit: monthlyProfit,
            totalAmount: totalAmount,
          ),
        );
      }
    }
  }

  void resetSIPDataYearly() {
    investedAmount.value = 0.0;
    expectedAmount.value = 0.0;
    totalProfit.value = 0.0;
    yearDetailsList.clear();
  }

  /// FD calculator codes
  var amountFdController = TextEditingController();
  var interestFdRate = TextEditingController();
  final RxInt selectedFdYear = 0.obs;
  final RxInt selectedFdMonth = 0.obs;
  var totalFdProfit = 0.0.obs;
  var investedFdAmount = 0.0.obs;
  var totalFdValue = 0.0.obs;
  var fdDetailsList = <FDDataDetails>[].obs;
  void calculateFd() {
    double principal = double.parse(amountFdController.text);
    double monthlyInterest = double.parse(interestFdRate.text) / 100;
    int n = int.parse(selectedFdYear.value.toString()) * 12 + int.parse(selectedFdMonth.value.toString());
    // double monthlyInterest = rate / 100;
    double compoundInterest = principal * (pow(1 + monthlyInterest, n) - 1);
    double totalAmount = principal + compoundInterest;
    investedFdAmount.value = principal;
    totalFdProfit.value = compoundInterest;
    totalFdValue.value = totalAmount;
    fdDetailsList.value = generateMonthList(principal, monthlyInterest, n);
    convertDecimalValue(totalFdValue.value.toStringAsFixed(0), principal, 3);
  }
  List<FDDataDetails> generateMonthList(
      double principal,
      double monthlyInterest,
      int n,
      ) {
    List<FDDataDetails> list = [];
    for (int i = 1; i <= n; i++) {
      double interest = principal * monthlyInterest;
      principal += interest;
      list.add(FDDataDetails(
          month: i,
          investment: principal,
          profit: interest,
          totalAmount: principal + interest,
        ),
      );
    }
    return list;
  }

  void resetFDData() {
    amountFdController.clear();
    interestFdRate.clear();
    selectedFdYear.value = 0;
    selectedFdMonth.value = 0;
    totalFdValue.value = 0;
    percentageFDValue.value = 0;
    totalFdProfit.value=0;
    investedFdAmount.value=0;
    fdDetailsList.clear();
  }

  convertDecimalValue(ttlAmount, emiAmount, type){
    double totalAmountValue = double.parse(ttlAmount);
    double amount = emiAmount;
    if(totalAmountValue>0){
      double percentage = (amount / totalAmountValue) * 100;
      double decimal = double.parse(percentage.toStringAsFixed(0));
      double percentageAsDecimal = decimal/100;
      if((percentageEMIValue.value >= 0.0 && percentageEMIValue.value <= 0.9) || percentageEMIValue.value == 1){
      switch (type) {
        case 1:
          percentageEMIValue.value = double.parse(percentageAsDecimal.toStringAsFixed(1));
          break;
        case 2:
          percentageSIPValue.value = double.parse(percentageAsDecimal.toStringAsFixed(1));
          break;
        case 3:
          percentageFDValue.value = double.parse(percentageAsDecimal.toStringAsFixed(1));
          break;
      }
    }
      else{
      switch (type) {
        case 1:
          percentageEMIValue.value = 0;
          break;
        case 2:
          percentageSIPValue.value = 0;
          break;
        case 3:
          percentageFDValue.value = 0;
          break;
      }
    }
    }else{
      percentageEMIValue.value=0;
      percentageSIPValue.value=0;
      percentageFDValue.value=0;
    }
  }

}
