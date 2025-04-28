import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/theming/font_weight_helper.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:flutter/material.dart';
//
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppTextField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String? hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? borderRadius;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final String? label;
  final String? restorationId;
  final int? maxLine;
  final Color? hintTextColor;
  final Function(String)? onChanged;
  const MyAppTextField({
    super.key,
    this.borderRadius,
    this.restorationId,
    this.contentPadding,
    this.onChanged,
    this.hintTextColor,
    this.maxLine = 1,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    this.prefixIcon,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      restorationId: restorationId,
      controller: controller,
      maxLines: maxLine,
      onChanged: onChanged,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: label,
        isDense: false,
        // label: label != null ? Text(label!) : null,
        labelStyle: TextStyles.appBarTexts.copyWith(fontSize: 17.sp),
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.lightgreyColor,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorsManager.lightgreyColor,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorsManager.lightgreyColor,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
        ),
        hintStyle: hintStyle ??
            TextStyles.appBarTexts.copyWith(
                fontWeight: FontWeightHelper.regular,
                color: hintTextColor ?? ColorsManager.darkgreyColor,
                fontSize: 17.sp),
        // ??
        //  TextStyles.font14LightGrayRegular,
        hintText: hintText,
        suffixIcon: suffixIcon,
        fillColor: ColorsManager.lightgreyColor,
        prefixIcon: Icon(Icons.search),
        prefixIconConstraints: BoxConstraints(
          minWidth: 30.w,
          minHeight: 40.h,
        ),
        // ?? ColorsManager.moreLightGray,
        filled: true,
      ),
      obscureText: isObscureText ?? false,
      style: TextStyles.appBarTexts.copyWith(
          fontSize: 16.sp,
          decoration: TextDecoration.none,
          decorationThickness: 0),
    );
  }
}
