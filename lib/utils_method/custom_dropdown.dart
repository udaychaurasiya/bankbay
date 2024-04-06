import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdownButtonContactWidget extends StatelessWidget {
  final Object? selectvalue;
  final List<Map> list;
  final String? title;
  final String? hint;
  final String onPress;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<Object?> change;

  const DropdownButtonContactWidget(
      {Key? key,
        required this.selectvalue,
        required this.change,
        required this.onPress,
        required this.list,
        this.title,
        this.hint,
        this.prefixIcon,
        this.suffixIcon})
      : super(key: key);

  List<DropdownMenuItem<Map>> _addDividersAfterItems(List<Map> items) {
    final List<DropdownMenuItem<Map>> menuItems = [];
    for (final Map item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<Map>(
            value:item,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["name"],
                    style: fontMedium.copyWith(),
                  ),
                  if (item != items.last)
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Divider(
                        thickness: .5,
                        height: .5,
                        color: Colors.grey,
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      );
    }
    return menuItems;
  }


  List<double> _getCustomItemsHeights(items) {
    final List<double> itemsHeights = [];
    for (int i = 0; i < items.length; i++) {
      itemsHeights.add(55);
    }
    return itemsHeights;
  }
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(     // <- Here
        splashColor: AllColors.none,    // <- Here
        highlightColor: AllColors.none, // <- Here
        hoverColor: AllColors.none,     // <- Here
      ),
      child: InputDecorator(
          decoration: InputDecoration(
              enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: AllColors.green.withOpacity(0.8), width: 2.r),),
              focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: AllColors.green.withOpacity(0.8), width: 2.r),),
              errorBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: AllColors.green.withOpacity(0.8), width: 2.r),),
              focusedErrorBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: AllColors.green.withOpacity(0.8), width: 2.r),),
              counter: const Offstage(),
              hintText: hint??"",
              hintStyle: TextStyle(color: Theme.of(context).shadowColor),
              labelText: hint,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: AllColors.white.withOpacity(0.8),
              prefixIconConstraints: BoxConstraints(maxWidth: 10.r, minWidth: 10.r),
              contentPadding: EdgeInsets.zero,
              labelStyle: fontMedium.copyWith(color: AllColors.black.withAlpha(180))),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 2.w, right: 10.w),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                value: selectvalue,
                items: _addDividersAfterItems(list),
                onChanged: change,
                hint: Text(title??"", style: fontMedium.copyWith(color: AllColors.black.withAlpha(180))),
                style: fontMedium.copyWith(color: AllColors.black.withAlpha(180)),
                selectedItemBuilder: (BuildContext context) {
                  return list.map<Widget>((Map item) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      constraints: const BoxConstraints(minWidth: 100),
                      child: Text(
                        item["name"],
                        style: fontBold.copyWith(color: AllColors.black.withAlpha(180)),
                      ),
                    );
                  }).toList();
                },
                menuItemStyleData: MenuItemStyleData(
                  overlayColor:  MaterialStateColor.resolveWith((states) => Colors.transparent),
                  padding: const EdgeInsets.all(0),
                  customHeights: _getCustomItemsHeights(list),
                ),
                buttonStyleData:ButtonStyleData(
                  overlayColor:  MaterialStateColor.resolveWith((states) => Colors.transparent),

                ),
                dropdownStyleData: DropdownStyleData(
                    maxHeight: 400,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(width: 1, color: Colors.grey),
                    )),
              ),
            ),
            //Icon(Icons.calendar_today, color: Colors.white),
          )),
    );
  }
}

class DropdownButtonString extends StatelessWidget {
  final Object? selectvalue;
  final List<String> list;
  final String title;
  final String hint;
  final String onPress;
  final ValueChanged<Object?> change;

  const DropdownButtonString(
      {Key? key,
        required this.selectvalue,
        required this.change,
        required this.onPress,
        required this.list,
        required this.title,
        required this.hint,
      })
      : super(key: key);

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final String item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.zero,
              child: Text(
                item,
                style: fontSmall.copyWith(
                  wordSpacing: 0.2,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w500,
                  color: AllColors.black.withOpacity(0.6),
                ) ,
              ),
            ),
          ),
        ],
      );
    }
    return menuItems;
  }
  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      isHovering: true,
        decoration: InputDecoration(
            enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: AllColors.green.withOpacity(0.8), width: 2.r),),
            focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: AllColors.green.withOpacity(0.8), width: 2.r),),
            errorBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: AllColors.green.withOpacity(0.8), width: 2.r),),
            focusedErrorBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: AllColors.green.withOpacity(0.8), width: 2.r),),
            counter: const Offstage(),
            hintText: hint,
            focusColor: Colors.transparent,
            hintStyle: fontMedium.copyWith(color: AllColors.white.withOpacity(0.8)),
            // labelText: hint,
            isDense: true,
            contentPadding: EdgeInsets.zero,
            labelStyle: fontExtraSmall.copyWith(color: AllColors.black.withOpacity(0.6))),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              //focus: Colors.transparent,
              value: selectvalue,
              items: _addDividersAfterItems(list),
              onChanged: change,
              // hint: Text(title, style: fontMedium.copyWith(color: AllColors.white.withOpacity(0.8)),),
              style: fontMedium.copyWith(color: AllColors.white.withOpacity(0.8)),
              menuItemStyleData: MenuItemStyleData(
                overlayColor:  MaterialStateColor.resolveWith((states) => Colors.transparent),
              ),
              dropdownStyleData: DropdownStyleData(
                  maxHeight: 500.r,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    // border: Border.all(width: 1, color: Colors.grey),
                    color: AllColors.white,
                  )),
            ),
          ),
          //Icon(Icons.calendar_today, color: Colors.white),
        ));
  }
}




