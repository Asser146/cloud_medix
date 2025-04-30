import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterOption extends StatefulWidget {
  const FilterOption({super.key});

  @override
  State<FilterOption> createState() => _FilterOptionState();
}

class _FilterOptionState extends State<FilterOption> {
  String selectedValue = 'ICU'; // default value

  final List<String> options = [
    'ICU',
    'Andalusia',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.4.sw, // Set a fixed width (you can adjust this)
      padding: EdgeInsets.only(left: 10.w, top: 3.h, bottom: 3.h),
      decoration: BoxDecoration(
        color: ColorsManager.primaryColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true, // Important: make the dropdown fill the container
          value: selectedValue,
          icon: Icon(
            Icons.arrow_drop_down_rounded,
            color: Colors.white,
            size: 40.sp,
          ),
          dropdownColor: ColorsManager.primaryColor,
          style: TextStyles.appBarTexts.copyWith(fontSize: 14.sp),
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Center(
                child: Text(
                  value,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedValue = newValue;
              });
            }
          },
        ),
      ),
    );
  }
}
