import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterOption extends StatelessWidget {
  const FilterOption({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.w, top: 3.h, bottom: 3.h),
      decoration: BoxDecoration(
        color: ColorsManager.primaryColor, // Background color
        borderRadius: BorderRadius.circular(12.r), // Rounded corners
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: 'Today', // Set default value
          icon: Icon(
            Icons.arrow_drop_down_rounded,
            color: Colors.white, // Dropdown icon color
            size: 40.sp,
          ),
          dropdownColor: ColorsManager.primaryColor, // Dropdown background
          style: TextStyles.appBarTexts.copyWith(fontSize: 14.sp), // Text style
          items: ['Today', 'Today2', 'Today3', 'Today4'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(color: Colors.white)),
            );
          }).toList(),
          onChanged: (String? newValue) {},
        ),
      ),
    );
  }
}
