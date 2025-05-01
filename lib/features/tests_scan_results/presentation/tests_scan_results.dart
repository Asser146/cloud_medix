import 'package:cloud_medix/core/widgets/loading_widget.dart';
import 'package:cloud_medix/core/widgets/my_app_bar.dart';
import 'package:cloud_medix/core/widgets/my_error_widget.dart';
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
              if (!context.mounted) return; // <<=== ADD THIS SAFETY CHECK
              if (result != null) {
                showDialog(
                  context: context,
                  builder: (_) => ReportDialog(testResult: result!),
                ).then((_) {
                  if (context.mounted) {
                    context.read<LabCubit>().switchStates();
                  }
                });
              }
            });
          }

          if (requests.isEmpty) {
            return Center(
                child: MyErrorWidget(message: "No Available Requests"));
            ;
          }

          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: ListView.builder(
                  padding: EdgeInsets.all(10.w),
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    return TestScanCard(testRequest: requests[index]);
                  },
                ),
              ),
              if (showOverlayLoader)
                const Center(
                    child: CircularProgressIndicator(
                  color: ColorsManager.primaryColor,
                )),
            ],
          );
        },
      ),
    );
  }
}
