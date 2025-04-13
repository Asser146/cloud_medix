import 'package:cloud_medix/core/widgets/loading_widget.dart';
import 'package:cloud_medix/core/widgets/my_app_bar.dart';
import 'package:cloud_medix/core/widgets/my_error_widget.dart';
import 'package:cloud_medix/features/medical_record/presentation/blocs/medical_record_cubit.dart';
import 'package:cloud_medix/features/medical_record/presentation/components/medical_record_tabs.dart';
import 'package:cloud_medix/features/medical_record/presentation/components/record_list_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_medix/core/theming/colors.dart';

class ViewMedicalRecord extends StatelessWidget {
  const ViewMedicalRecord({super.key});

  /// Generic method to get the correct list based on the selected tab

  @override
  Widget build(BuildContext context) {
    context.read<MedicalRecordCubit>().getMedRecord();
    return Scaffold(
      appBar: const MyAppBar(title: "Medical Record"),
      backgroundColor: ColorsManager.backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: Column(
          children: [
            MedicalRecordTabs(
                categories: context.read<MedicalRecordCubit>().categories),
            SizedBox(height: 15.h),
            Expanded(
              child: BlocBuilder<MedicalRecordCubit, MedicalRecordState>(
                builder: (context, state) {
                  if (state is MedicalRecordLoading) {
                    return const Center(
                      child: LoadingWidget(),
                    );
                  } else if (state is MedicalRecordError) {
                    return MyErrorWidget(message: state.message);
                  } else if (state is MedicalRecordLoaded) {
                    return RecordListBuilder(
                        selectedIndex: context
                            .watch<MedicalRecordCubit>()
                            .selectedtabIndex);
                  } else {
                    return MyErrorWidget(message: "Something Went Wrong");
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
