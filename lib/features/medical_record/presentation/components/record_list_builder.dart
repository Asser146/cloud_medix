import 'package:cloud_medix/core/widgets/empty_state_widget.dart';
import 'package:cloud_medix/features/medical_record/presentation/blocs/medical_record_cubit.dart';
import 'package:cloud_medix/features/medical_record/presentation/components/medical_record_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecordListBuilder extends StatelessWidget {
  const RecordListBuilder({
    super.key,
    required this.selectedIndex,
  });

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final recList =
        context.watch<MedicalRecordCubit>().medicalRecordLists[selectedIndex];
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
                return MedicalRecordCard(
                  record: recList, // Pass individual record
                  category: selectedIndex,
                  index: index,
                );
              },
            )
          : Center(child: EmptyStateWidget(message: "No Records Found")),
    );
  }
}
