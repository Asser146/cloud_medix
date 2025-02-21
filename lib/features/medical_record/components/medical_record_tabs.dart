import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicalRecordTabs extends StatelessWidget {
  const MedicalRecordTabs({
    super.key,
    required this.categories,
  });

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: TabBar(
          labelStyle: TextStyles.tabsText.copyWith(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyles.tabsText,
          isScrollable: false,
          tabAlignment: TabAlignment.fill,
          labelPadding: EdgeInsets.symmetric(horizontal: 3.w),
          dividerColor: Colors.transparent,
          indicator: const BoxDecoration(),
          tabs: categories.map(
            (category) {
              return Tab(
                child: Container(
                    height: 80.h,
                    width: 140.w,
                    decoration: BoxDecoration(
                      color: ColorsManager.midcyanColors,
                      borderRadius:
                          BorderRadius.circular(20.r), // Smaller border radius
                    ),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8.h,
                          horizontal: 12.w,
                        ),
                        child: Text(category),
                      ),
                    )),
              );
            },
          ).toList(),
        ));
  }
}
