import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/theming/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  static TextStyle cyanTexts = TextStyle(
    fontSize: 16.sp,
    // fontFamily: 'Circular Std',
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.midcyanColors,
  );
  static TextStyle appBarTexts = cyanTexts.copyWith(color: Colors.white);
  static TextStyle slotDuration = TextStyle(
    fontSize: 14.sp,
    // fontFamily: 'Circular Std',
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.primaryColor,
  );
  static TextStyle doctorName = TextStyle(
    fontSize: 16.sp,
    // fontFamily: 'Circular Std',
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.primaryColor,
  );
  static TextStyle hospitalName = TextStyle(
    fontSize: 12.sp,
    // fontFamily: 'Circular Std',
    fontWeight: FontWeightHelper.semiBold,
    color: ColorsManager.primaryColor,
  );
}
