import 'package:cloud_medix/core/widgets/my_app_bar.dart';
import 'package:cloud_medix/features/reservation/make_reservation/presentation/components/filter_option.dart';
import 'package:cloud_medix/features/tests_scan_results/presentation/blocs/lab_cubit.dart';
import 'package:cloud_medix/features/tests_scan_results/presentation/components/test_scan_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_medix/core/theming/colors.dart';

class TestsScanResults extends StatelessWidget {
  const TestsScanResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Tests/Scan Results"),
      backgroundColor: ColorsManager.backgroundColor,
      body: Padding(
        padding:
            EdgeInsets.only(top: 10.h, bottom: 15.h, left: 12.w, right: 12.r),
        child: BlocBuilder<LabCubit, LabState>(
          builder: (context, state) {
            return Column(
              children: [
                const FilterOption(),
                SizedBox(height: 15.h),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorsManager.primaryColor,
                        borderRadius: BorderRadius.circular(15.r)),
                    child: ListView.builder(
                      padding: EdgeInsets.all(10.w),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return const TestScanCard();
                      },
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
