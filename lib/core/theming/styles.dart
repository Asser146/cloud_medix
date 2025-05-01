import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/theming/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  static TextStyle welcomBack = TextStyle(
    fontSize: 30.sp,
    // fontFamily: 'Circular Std',
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.primaryColor,
  );
  static TextStyle medicalRecordName = TextStyle(
    fontSize: 20.sp,
    // fontFamily: 'Circular Std',
    fontWeight: FontWeightHelper.bold,
    color: Colors.black,
  );
  static TextStyle medicalRecordTypeDesc = medicalRecordName.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.semiBold,
  );
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
  static TextStyle testName = TextStyle(
    fontSize: 20.sp,
    // fontFamily: 'Circular Std',
    fontWeight: FontWeightHelper.bold,
    color: Colors.white,
  );
  static TextStyle testdate = TextStyle(
    fontSize: 17.sp,
    // fontFamily: 'Circular Std',
    fontWeight: FontWeightHelper.regular,
    color: Colors.white,
  );
  static TextStyle tabsText = TextStyle(
    fontSize: 15.sp,
    // fontFamily: 'Circular Std',
    fontWeight: FontWeightHelper.medium,
    color: Colors.black,
  );
  static TextStyle authTitles = TextStyle(
    fontSize: 24.sp,
    fontFamily: 'Roboto',
    fontWeight: FontWeightHelper.regular,
    color: Colors.black,
  );
  static TextStyle authHintTitle = TextStyle(
    fontSize: 20.sp,
    fontFamily: 'Roboto',
    fontWeight: FontWeightHelper.regular,
    color: Colors.grey,
  );
  static TextStyle authField = TextStyle(
    fontSize: 16.sp,
    fontFamily: 'Roboto',
    fontWeight: FontWeightHelper.medium,
    color: Colors.grey,
  );
}
