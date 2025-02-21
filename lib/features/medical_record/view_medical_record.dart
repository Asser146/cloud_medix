import 'package:cloud_medix/core/widgets/my_app_bar.dart';
import 'package:cloud_medix/features/medical_record/components/medical_record_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_medix/core/theming/colors.dart';

class ViewMedicalRecord extends StatelessWidget {
  const ViewMedicalRecord({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = ["Allergies", "Diseases", "Diagnosis", "Medications"];
    return Scaffold(
      appBar: const MyAppBar(title: "Medical Record"),
      backgroundColor: ColorsManager.backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: Column(
          children: [
            MedicalRecordTabs(categories: categories),
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
                  child: const Column(
                    children: [
                      Text("Allergies"),
                      Text("allergy-1"),
                      Text("allergy-2"),
                      Text("allergy-3")
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
