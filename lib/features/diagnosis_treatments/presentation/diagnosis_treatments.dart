import 'package:cloud_medix/core/widgets/loading_widget.dart';
import 'package:cloud_medix/core/widgets/my_app_bar.dart';
import 'package:cloud_medix/core/widgets/server_error_widget.dart';
import 'package:cloud_medix/features/diagnosis_treatments/presentation/blocs/diagnosis_treatment_cubit.dart';
import 'package:cloud_medix/features/diagnosis_treatments/presentation/components/list_builder.dart';
import 'package:cloud_medix/features/diagnosis_treatments/presentation/components/switch_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_medix/core/theming/colors.dart';

class DiagnosisTreatments extends StatelessWidget {
  const DiagnosisTreatments({super.key});
  @override
  Widget build(BuildContext context) {
    context.read<DiagnosisTreatmentCubit>().getMyDiagnosis();

    return Scaffold(
      appBar: MyAppBar(title: "Diagnosis/Treatments"),
      backgroundColor: ColorsManager.backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: Column(
          children: [
            SwitchTabs(),
            SizedBox(height: 15.h),
            Expanded(
              child:
                  BlocBuilder<DiagnosisTreatmentCubit, DiagnosisTreatmentState>(
                builder: (context, state) {
                  if (state is DiagnosisTreatmentLoading) {
                    return const Center(
                      child: LoadingWidget(),
                    );
                  } else if (state is DiagnosisTreatmentError) {
                    return ServerErrorWidget(message: state.message);
                  } else if (state is DiagnosisLoaded) {
                    return ListBuilder(
                        selectedIndex: context
                            .watch<DiagnosisTreatmentCubit>()
                            .selectedtabIndex);
                  } else if (state is TreatmentLoaded) {
                    return ListBuilder(
                        selectedIndex: context
                            .watch<DiagnosisTreatmentCubit>()
                            .selectedtabIndex);
                  } else {
                    return ServerErrorWidget(message: "Something Went Wrong");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
