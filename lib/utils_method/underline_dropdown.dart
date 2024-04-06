import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomUnderlineDropdownField extends StatelessWidget {
  final List<DropdownMenuItem<String>>? items;
  final Function(String?)? onChanged;
  final String? hint;
  final FormFieldValidator? validator;
  final bool? label;
  final bool? isRead;
  final String? value;
  const CustomUnderlineDropdownField({super.key, this.items, this.hint, this.onChanged, this.validator, this.label=true, this.value, this.isRead=false});

  @override
  Widget build(BuildContext context) {
    return  DropdownButtonFormField(
      items: items,
      onChanged: onChanged,
      style: fontRegular.copyWith(
        wordSpacing: 0.2,
        letterSpacing: 0.8,
        color: AllColors.black.withOpacity(0.7),
      ),
      decoration: InputDecoration(
        enabled: isRead==true?false:true,
        hintText: hint,
        labelText: label==true?hint.toString().replaceAll(".", ""):null,
        hintStyle: fontSmall.copyWith(
          wordSpacing: 0.2,
          letterSpacing: 0.8,
          fontWeight: FontWeight.w400,
          color: AllColors.black.withOpacity(0.7),
          overflow: TextOverflow.ellipsis,
        ),
        labelStyle: fontSmall.copyWith(
          wordSpacing: 0.2,
          letterSpacing: 0.8,
          fontWeight: FontWeight.w400,
          color: AllColors.black.withOpacity(0.7),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: AllColors.grey.withOpacity(0.3), width: 1.r),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: AllColors.grey, width: 0.5.r),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AllColors.blue.withOpacity(0.8), width: 2.r),
        ),
      contentPadding: EdgeInsets.symmetric(vertical: 8.r),
      ),
      isDense: true,
      validator: validator,
      value: value,
    );
  }
}
