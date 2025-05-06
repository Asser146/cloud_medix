import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:cloud_medix/features/diagnosis_treatments/presentation/blocs/diagnosis_treatment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwitchTabs extends StatelessWidget {
  const SwitchTabs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> categories = ["Diagnosis", "Treatments"];

    return DefaultTabController(
        length: 2,
        child: TabBar(
          labelStyle: TextStyles.tabsText.copyWith(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyles.tabsText,
          isScrollable: false,
          tabAlignment: TabAlignment.fill,
          labelPadding: EdgeInsets.symmetric(horizontal: 3.w),
          dividerColor: Colors.transparent,
          indicator: const BoxDecoration(),
          tabs: categories.asMap().entries.map(
            (entry) {
              int index = entry.key;
              String category = entry.value;
              return GestureDetector(
                  onTap: () =>
                      context.read<DiagnosisTreatmentCubit>().changeTab(index),
                  child: Tab(
                    child: Container(
                      height: 80.h,
                      width: 140.w,
                      decoration: BoxDecoration(
                        color: context
                                    .watch<DiagnosisTreatmentCubit>()
                                    .selectedtabIndex ==
                                index
                            ? ColorsManager.midcyanColors
                            : Colors.white,
                        borderRadius: BorderRadius.circular(
                            20.r), // Smaller border radius
                      ),
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.h,
                              horizontal: 12.w,
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                color: context
                                            .watch<DiagnosisTreatmentCubit>()
                                            .selectedtabIndex ==
                                        index
                                    ? Colors.black
                                    : ColorsManager.primaryColor,
                              ),
                            ),
                          )),
                    ),
                  ));
            },
          ).toList(),
        ));
  }
}
