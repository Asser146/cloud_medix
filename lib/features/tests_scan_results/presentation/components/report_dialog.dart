import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/features/tests_scan_results/data/test_result.dart';
import 'package:cloud_medix/features/tests_scan_results/presentation/components/result_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportDialog extends StatelessWidget {
  final TestResult testResult;

  const ReportDialog({super.key, required this.testResult});

  @override
  Widget build(BuildContext context) {
    bool isNotes = testResult.notes != null && testResult.notes!.isNotEmpty;

    return AlertDialog(
      backgroundColor: ColorsManager.thirdColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Test Name",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  Text("Result",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
              SizedBox(height: 10.h),
              ResultsTable(testResult: testResult),
              if (isNotes) ...[
                SizedBox(height: 20.h),
                const Text(
                  "Notes",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 10.h),
                Text(
                  testResult.notes!,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                ),
              ]
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Close",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
