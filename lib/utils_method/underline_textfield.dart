// ignore_for_file: unnecessary_null_in_if_null_operators
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UnderLineTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hint;
  final bool? label;
  final Function(String)? onChange;
  final TextInputType? type;
  final FormFieldValidator? validator;
  final int? length;
  final bool? isRead;
  final bool? icon;
  final bool? dataView;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? preIcon;
  final InputBorder? border;
  final Function()? onTap;
  final TextDirection? textDirection;
  final List<TextInputFormatter>? inputFormatters;
  const UnderLineTextField({super.key, this.controller, this.labelText="", this.hint, this.label=true,
    this.onChange, this.type, this.validator, this.length, this.isRead, this.icon, this.suffixIcon,
    this.prefixIcon, this.preIcon, this.border, this.onTap, this.textDirection, this.inputFormatters, this.dataView=false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textDirection: textDirection,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide:
          BorderSide(color: AllColors.grey.withOpacity(0.3), width: 1.r),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: AllColors.grey, width: 0.5.r),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AllColors.blue.withOpacity(0.8), width: 2.r),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 2.r, vertical: 6.r),
        counter: const Offstage(),
        hintText: hint??"Please fill in the blanks",
        labelText: label==true?labelText!=""?labelText:hint:null,
        hintStyle: fontSmall.copyWith(
          wordSpacing: 0.2,
          letterSpacing: 0.8,
          fontWeight: FontWeight.w400,
          color: AllColors.black.withOpacity(0.7),
        ),
        labelStyle: fontSmall.copyWith(
          wordSpacing: 0.2,
          letterSpacing: 0.8,
          fontWeight: FontWeight.w400,
          color: AllColors.black.withOpacity(0.7),
        ),
        isDense: true,
        suffixIcon: icon == true
            ?dataView==true?Padding(
              padding: EdgeInsets.only(right: 3.0.r),
              child: Icon(Icons.lock_open_outlined, size: 20.r, color: AllColors.black.withOpacity(0.5),),
            ):  suffixIcon?? Icon(Icons.arrow_drop_down_sharp,
            size: 20.r, color: AllColors.black.withOpacity(0.6))
            : null,
        prefixIcon: preIcon == true?
        Text( "+91",style: fontRegular.copyWith(
          wordSpacing: 0.2,
          letterSpacing: 0.8,
          fontWeight: FontWeight.w500,
          color: AllColors.black.withOpacity(0.7),
        ),): prefixIcon ?? null,
        prefixIconConstraints: BoxConstraints(
          maxWidth: 40.r,
          minWidth: 35.r,
        ),
        suffixIconConstraints: BoxConstraints(
          minHeight: 10.r, minWidth: 10.r,
        ),
      ),
      maxLength: length,
      onTap: onTap,
      controller: controller,
      keyboardType: type,
      inputFormatters: inputFormatters??[
        type == TextInputType.number
            ? FilteringTextInputFormatter.digitsOnly
            : FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
      ],
      onChanged: onChange,
      minLines: 1,
      maxLines: 1,
      validator: validator,
      readOnly: dataView==true?true: isRead ?? false,
      cursorColor: AllColors.blue.withOpacity(0.8),
      style: fontRegular.copyWith(
        wordSpacing: 0.2,
        letterSpacing: 0.8,
        color: AllColors.black.withOpacity(0.7),
      ),
    );
  }
}

/// no hint text
class CustomUnderLineTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hint;
  final Function(String)? onChange;
  final TextInputType? type;
  final FormFieldValidator? validator;
  final int? length;
  final bool isPassword;
  final bool? isRead;
  final bool? boldNon;
  final IconData? prefixIcon;
  final Function()? onTap;
  final Color? prefixIconColor;
  final Color? hintColor;
  final bool? levelText;
  final String? autofillHints;
  final List<TextInputFormatter>? inputFormatters;

  const CustomUnderLineTextField(
      {super.key, this.isPassword=false, this.controller, this.onChange, this.type, this.validator, this.length,
        this.isRead, this.prefixIcon, this.onTap, this.inputFormatters, required this.hint, this.prefixIconColor,
        this.hintColor, this.boldNon, this.levelText=true, this.autofillHints=""});

  @override
  State<CustomUnderLineTextField> createState() => _CustomUnderLineTextFieldState();
}

class _CustomUnderLineTextFieldState extends State<CustomUnderLineTextField> {
  RxBool obscureText = true.obs;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    // _focusNode.dispose();
    obscureText.value = !obscureText.value;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: widget.isPassword ? obscureText.value : false,
        focusNode: _focusNode,
        controller: widget.controller,
        keyboardType: widget.type,
        onTap: widget.onTap,
        inputFormatters: widget.inputFormatters,
        enableSuggestions: true,
        autofillHints: widget.autofillHints=="number"?
        const [
          AutofillHints.telephoneNumber,
        ] : widget.autofillHints=="password"?
        const [
          AutofillHints.password,
        ] : null,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.prefixIcon,
            size: 22.r,
            color: widget.prefixIconColor??AllColors.black.withOpacity(0.4),
          ),
          suffixIcon: widget.isPassword ?
          InkWell(
            onTap: _toggle,
            child: Icon(obscureText.value
                ? Icons.visibility_off
                : Icons.visibility,
              size: 20.r,
              color: widget.prefixIconColor??AllColors.black.withOpacity(0.4),
            ),
          ) : null,
          constraints: BoxConstraints(
            minWidth: 25.r,
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 26.r,
          ),
          suffixIconConstraints: BoxConstraints(
            minWidth: 25.r,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AllColors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AllColors.grey),
          ),
          counter: const Offstage(),
          hintText: widget.hint.toString(),
          labelText: widget.levelText==true?widget.hint:null,
          hintStyle: fontBold.copyWith(
            color: widget.hintColor??AllColors.black.withOpacity(0.4),
            fontWeight: widget.boldNon==true?FontWeight.w400:FontWeight.w600,
          ),
          labelStyle: fontBold.copyWith(
            color: widget.hintColor??AllColors.black.withOpacity(0.4),
            fontWeight: widget.boldNon==true?FontWeight.w400:FontWeight.w600,
          ),
          isDense: true,
          contentPadding: EdgeInsets.only(top: 2.r, bottom: 2.r,),
        ),
        validator: widget.validator,
        maxLength: widget.length,
        style: fontMedium.copyWith(
          color: widget.hintColor!=null?AllColors.white.withOpacity(0.8):AllColors.black.withOpacity(0.6),
          fontWeight: widget.boldNon==true?FontWeight.w400:FontWeight.w600,
          fontSize: 18.r,
        ));
  }

  void _toggle() {
    setState(() {
      obscureText.value = !obscureText.value;
    });
  }
}

