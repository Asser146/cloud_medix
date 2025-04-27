import 'package:cloud_medix/features/tests_scan_results/data/test_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultsTable extends StatelessWidget {
  const ResultsTable({
    super.key,
    required this.testResult,
  });

  final TestResult testResult;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // <--- ADD shrinkWrap
      physics:
          const NeverScrollableScrollPhysics(), // <--- prevent nested scroll
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
    );
  }
}
