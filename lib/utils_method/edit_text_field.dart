import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditTextFiled extends StatelessWidget {
  final String hint;
  final String label;
  final IconData?icon;
  final int maxLength;
  final bool? isPassword;
  final TextInputType keyboardtype;
  final FormFieldValidator validator;
  final TextEditingController?controller;
  final bool? isdisable;
  final int? maxline;
  final int? minline;
  final FocusNode? myfocus;
  final  List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onDoneClick;
  final GestureTapCallback? onTap;
  final Color? color;
  final Color? colorBorder;
  final EdgeInsets? contentPadding;
  final Widget? suffixIcon;
  final String? prefixText;
  final Widget? prefixIcon;
  final double? width;
  final bool? bold;
  const EditTextFiled({Key?key,required this.hint,this.width,this.color,this.colorBorder,this.contentPadding,required this.label,
    this.myfocus,this.onTap, this.icon,this.onDoneClick,this.onFieldSubmitted,  this.inputFormatters,required this.validator,
    required this.keyboardtype,required this.maxLength, this.isPassword=false, this.controller, this.isdisable, this.maxline,
    this.suffixIcon, this.prefixText, this.prefixIcon, this.bold=false, this.minline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      focusNode : myfocus,
      onChanged: onFieldSubmitted,
      onFieldSubmitted:onDoneClick ,
      inputFormatters: inputFormatters,
      textCapitalization: TextCapitalization.sentences,
      readOnly: isdisable==null?false:isdisable!,
      style: bold==true?fontBold.copyWith(fontSize: 18.r):fontMedium.copyWith(color: AllColors.black.withAlpha(180)),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color:colorBorder?? Theme.of(context).shadowColor.withOpacity(.3))
        ),
        focusedBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: colorBorder??Theme.of(context).shadowColor.withOpacity(.3))
        ),
        errorBorder:   OutlineInputBorder(
            borderSide: BorderSide(color: colorBorder??Theme.of(context).shadowColor.withOpacity(.3))
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorBorder??Theme.of(context).shadowColor.withOpacity(.3))
        ),
        counter: const Offstage(),
        hintText: hint,
        filled: true,
        fillColor: AllColors.white.withOpacity(0.9),
        hintStyle: fontMedium.copyWith(color: AllColors.black.withAlpha(180)),
        labelText: label,
        suffixIcon: suffixIcon,
        prefixText: prefixText,
        prefixIconColor: AllColors.black,
        prefixStyle: fontBold.copyWith(color: AllColors.black),
        isDense: true,
        prefixIcon: prefixIcon,
        prefixIconConstraints: BoxConstraints(
          maxWidth: 50.h,
          minWidth: 50.h,
        ),
        contentPadding: contentPadding?? EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 12.h),
        labelStyle: fontMedium.copyWith(color: AllColors.black.withAlpha(180)),
      ),
      controller: controller,
      keyboardType: keyboardtype,
      maxLength: maxLength,
      obscureText: isPassword!,
      validator:validator,
      maxLines: maxline,
      minLines: minline,
      autofocus: false,
    );
  }
}

// class OutlineTextField extends StatelessWidget {
//   final TextEditingController? controller;
//   final String? labelText;
//   final String? hint;
//   final bool? label;
//   final Function(String)? onChange;
//   final TextInputType? type;
//   final FormFieldValidator? validator;
//   final int? length;
//   final bool? isRead;
//   final bool? icon;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//   final bool? preIcon;
//   final InputBorder? border;
//   final Function()? onTap;
//   final List<TextInputFormatter>? inputFormatters;
//   const OutlineTextField({super.key, this.controller, this.labelText, this.hint, this.label,
//     this.onChange, this.type, this.validator, this.length, this.isRead, this.icon, this.suffixIcon,
//     this.prefixIcon, this.preIcon, this.border, this.onTap, this.inputFormatters});
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       decoration: InputDecoration(
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: AllColors.grey.withOpacity(0.3), width: 1.r),
//           borderRadius: BorderRadius.circular(3.r),
//         ),
//         border: OutlineInputBorder(
//           borderSide: BorderSide(color: AllColors.grey, width: 0.5.r),
//           borderRadius: BorderRadius.circular(3.r),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: AllColors.blue.withOpacity(0.8), width: 2.r),
//           borderRadius: BorderRadius.circular(3.r),
//         ),
//         contentPadding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 10.r),
//         counter: const Offstage(),
//         hintText: hint??"Please fill in the blanks",
//         labelText: label==true?hint??"Please fill in the blanks":null,
//         hintStyle: fontSmall.copyWith(
//           wordSpacing: 0.2,
//           letterSpacing: 0.8,
//           fontWeight: FontWeight.w400,
//           color: AllColors.black.withOpacity(0.7),
//         ),
//         labelStyle: fontSmall.copyWith(
//           wordSpacing: 0.2,
//           letterSpacing: 0.8,
//           fontWeight: FontWeight.w400,
//           color: AllColors.black.withOpacity(0.7),
//         ),
//         isDense: true,
//         suffixIcon: icon == true
//             ? Icon(Icons.arrow_drop_down_sharp,
//             size: 22.r, color: AllColors.black.withOpacity(0.6))
//             : null,
//         prefixIcon: preIcon == true?
//         Text( "+91",style: fontRegular.copyWith(
//           wordSpacing: 0.2,
//           letterSpacing: 0.8,
//           fontWeight: FontWeight.w500,
//           color: AllColors.black.withOpacity(0.7),
//         ),): prefixIcon ?? null,
//         prefixIconConstraints: BoxConstraints(
//           maxWidth: 40.r,
//           minWidth: 35.r,
//         ),
//         suffixIconConstraints: BoxConstraints(minHeight: 10.r, minWidth: 10.r),
//       ),
//       maxLength: length,
//       onTap: onTap,
//       controller: controller,
//       keyboardType: type,
//       inputFormatters: inputFormatters??[
//         type == TextInputType.number
//             ? FilteringTextInputFormatter.digitsOnly
//             : FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
//       ],
//       onChanged: onChange,
//       minLines: 1,
//       maxLines: 1,
//       validator: validator,
//       readOnly: isRead ?? false,
//       cursorColor: AllColors.blue.withOpacity(0.8),
//       style: fontRegular.copyWith(
//         wordSpacing: 0.2,
//         letterSpacing: 0.6,
//         color: AllColors.black.withOpacity(0.7),
//       ),
//     );
//   }
// }


class OutlineTextField extends StatelessWidget {
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
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? preIcon;
  final InputBorder? border;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  const OutlineTextField({super.key, this.controller, this.labelText, this.hint, this.label=true,
    this.onChange, this.type, this.validator, this.length, this.isRead, this.icon, this.suffixIcon,
    this.prefixIcon, this.preIcon, this.border, this.onTap, this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AllColors.grey.withOpacity(0.3), width: 1.r),
          borderRadius: BorderRadius.circular(3.r),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AllColors.grey, width: 0.5.r),
          borderRadius: BorderRadius.circular(3.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AllColors.blue.withOpacity(0.8), width: 2.r),
          borderRadius: BorderRadius.circular(3.r),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 10.r),
        counter: const Offstage(),
        hintText: hint??"Please fill in the blanks",
        labelText: label==true?hint.toString().replaceAll(".", ""):null,
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
            ? Icon(Icons.arrow_drop_down_sharp,
            size: 22.r, color: AllColors.black.withOpacity(0.6))
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
        suffixIconConstraints: BoxConstraints(minHeight: 10.r, minWidth: 10.r),
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
      readOnly: isRead ?? false,
      cursorColor: AllColors.blue.withOpacity(0.8),
      style: fontRegular.copyWith(
        wordSpacing: 0.2,
        letterSpacing: 0.6,
        color: AllColors.black.withOpacity(0.7),
      ),
    );
  }
}