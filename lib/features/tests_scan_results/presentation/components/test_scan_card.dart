import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:cloud_medix/features/tests_scan_results/data/test_request.dart';
import 'package:cloud_medix/features/tests_scan_results/presentation/blocs/lab_cubit.dart';
import 'package:cloud_medix/features/tests_scan_results/presentation/components/view_report_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TestScanCard extends StatelessWidget {
  const TestScanCard({super.key, required this.testRequest});

  final TestRequest testRequest;

  @override
  Widget build(BuildContext context) {
    final statusList = context.read<LabCubit>().status;
    final testStatus = (testRequest.status < statusList.length)
        ? statusList[testRequest.status]
        : 'Unknow';

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Card(
        elevation: 2,
        shadowColor: ColorsManager.lightgreyColor,
        child: Container(
          height: 120.h,
          decoration: BoxDecoration(
            color: ColorsManager.thirdColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "Issued Doc: ${testRequest.physicianFullName.split(' ').first} ${testRequest.physicianFullName.split(' ').last}",
                    style: TextStyles.testName,
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "Issued Date: ${DateFormat.yMd().format(DateTime.parse(testRequest.dateOfRequest.toString()))}",
                    style: TextStyles.testdate,
                  ),
                ),
                if (testStatus == "COMPLETED")
                  Row(
                    children: [
                      Text(
                        "Status: $testStatus",
                        style: TextStyles.testName.copyWith(fontSize: 15.sp),
                      ),
                      const Spacer(),
                      ViewReportButton(testRequest: testRequest),
                    ],
                  )
                else
                  Text(
                    "Status: $testStatus",
                    style: TextStyles.testName.copyWith(fontSize: 15.sp),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
