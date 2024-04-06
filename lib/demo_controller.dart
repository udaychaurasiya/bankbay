import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DemoController extends GetxController {
  var dateRange = DateTimeRange(start: DateTime.now().subtract(const Duration(days: 5)), end: DateTime.now()).obs;

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: Get.context!,
      initialDateRange: dateRange.value,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      helpText: 'Select Range Date',
      fieldStartHintText: 'Start date',
      fieldEndHintText: 'End date',
    );
    if (newDateRange == null) return;
    dateRange.value = newDateRange;
    dateRange.refresh();
    update();
  }
}