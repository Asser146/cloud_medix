import 'package:cloud_medix/features/diagnosis_treatments/presentation/blocs/diagnosis_treatment_cubit.dart';
import 'package:cloud_medix/features/diagnosis_treatments/presentation/components/data_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListBuilder extends StatelessWidget {
  const ListBuilder({
    super.key,
    required this.selectedIndex,
  });

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final diagnosisList = context.watch<DiagnosisTreatmentCubit>().diagnosis;
    final treatmentList = context.watch<DiagnosisTreatmentCubit>().treatments;
    final recList = selectedIndex == 0 ? diagnosisList : treatmentList;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: recList.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.all(10.w),
              itemCount: recList.length,
              itemBuilder: (context, index) {
                return DataCard(
                  data: recList[index], // Pass individual record
                );
              },
            )
          : const Center(
              child: Text(
                "No Records found.",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
    );
  }
}
