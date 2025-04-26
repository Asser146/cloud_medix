import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/features/tests_scan_results/data/test_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportDialog extends StatelessWidget {
  final TestResult testResult;

  const ReportDialog({super.key, required this.testResult});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorsManager.thirdColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            SizedBox(
              height: 250.h,
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView.builder(
                  itemCount: testResult.tests.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              testResult.tests[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              testResult.results[index],
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Close",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
