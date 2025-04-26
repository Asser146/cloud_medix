import 'dart:developer';

import 'package:cloud_medix/core/widgets/loading_widget.dart';
import 'package:cloud_medix/core/widgets/my_app_bar.dart';
import 'package:cloud_medix/core/widgets/my_error_widget.dart';
import 'package:cloud_medix/features/reservation/make_reservation/presentation/components/filter_option.dart';
import 'package:cloud_medix/features/tests_scan_results/data/test_request.dart';
import 'package:cloud_medix/features/tests_scan_results/data/test_result.dart';
import 'package:cloud_medix/features/tests_scan_results/presentation/blocs/lab_cubit.dart';
import 'package:cloud_medix/features/tests_scan_results/presentation/components/report_dialog.dart';
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
      appBar: MyAppBar(title: "Tests/Scans Resuls"),
      backgroundColor: ColorsManager.backgroundColor,
      body: BlocBuilder<LabCubit, LabState>(
        builder: (context, state) {
          log(state.toString());
          List<TestRequest> requests = [];
          TestResult? result;
          bool showOverlayLoader = false;

          if (state is LabLoaded) {
            requests = state.tests;
          } else if (state is LabResultLoading) {
            requests = state.tests;
            showOverlayLoader = true;
          } else if (state is LabLoading) {
            return const Center(child: LoadingWidget());
          } else if (state is LabError) {
            return Center(child: MyErrorWidget(message: state.message));
          } else if (state is LabResultLoaded) {
            requests = state.tests;
            result = state.result;
            showOverlayLoader = false;

            // Show dialog after the build is complete
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (result != null) {
                showDialog(
                  context: context,
                  builder: (_) => ReportDialog(testResult: result!),
                );
              }
            });
          }

          if (requests.isEmpty) {
            return const Center(
              child: Text("No available Requests.",
                  style: TextStyle(color: Colors.black, fontSize: 16)),
            );
          }

          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  children: [
                    SizedBox(height: 15.h),
                    const FilterOption(),
                    SizedBox(height: 15.h),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorsManager.primaryColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15.r),
                              topLeft: Radius.circular(15.r)),
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.all(10.w),
                          itemCount: requests.length,
                          itemBuilder: (context, index) {
                            return TestScanCard(testRequest: requests[index]);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (showOverlayLoader) const Center(child: LoadingWidget()),
            ],
          );
        },
      ),
    );
  }
}
