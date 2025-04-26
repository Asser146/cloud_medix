import 'package:cloud_medix/core/theming/styles.dart';
import 'package:cloud_medix/features/tests_scan_results/data/test_request.dart';
import 'package:cloud_medix/features/tests_scan_results/presentation/blocs/lab_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewReportButton extends StatelessWidget {
  const ViewReportButton({super.key, required this.testRequest});

  final TestRequest testRequest;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<LabCubit>().getResult(testRequest.id);
      },
      child: Row(
        children: [
          Text(
            "View Report",
            style: TextStyles.testName.copyWith(fontSize: 13.sp),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white,
            size: 16,
          ),
        ],
      ),
    );
  }
}
