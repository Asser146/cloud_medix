import 'package:cloud_medix/core/widgets/my_app_bar.dart';
import 'package:cloud_medix/features/medical_record/blocs/medical_record_cubit.dart';
import 'package:cloud_medix/features/medical_record/components/medical_record_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_medix/core/theming/colors.dart';

class ViewMedicalRecord extends StatelessWidget {
  const ViewMedicalRecord({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> data = context.watch<MedicalRecordCubit>().getRecordData();
    return Scaffold(
      appBar: const MyAppBar(title: "Medical Record"),
      backgroundColor: ColorsManager.backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: Column(
          children: [
            MedicalRecordTabs(
                categories: context.watch<MedicalRecordCubit>().categories),
            SizedBox(height: 15.h),
            Expanded(
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14.sp),
                      topRight: Radius.circular(14.sp),
                    ),
                  ),
                  child: Column(
                    children: [
                      for (int i = 0; i < data.length; i++)
                        Row(
                          children: [
                            Icon(Icons.medical_services),
                            Text(data[i])
                          ],
                        )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
