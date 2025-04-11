import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/features/medical_record/data/allergy.dart';
import 'package:cloud_medix/features/medical_record/data/chronic.dart';
import 'package:cloud_medix/features/medical_record/data/current_medication.dart';
import 'package:cloud_medix/features/medical_record/presentation/components/medicine_card.dart';
import 'package:cloud_medix/features/medical_record/presentation/components/non_medicine_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicalRecordCard extends StatelessWidget {
  const MedicalRecordCard({
    super.key,
    required this.record,
    required this.category,
    required this.index,
  });

  final List<dynamic> record;
  final int category;
  final int index;

  // Properly typecast the record entry
  dynamic getRecordItem() {
    switch (category) {
      case 0:
        return record[index] as Allergy;
      case 1:
        return record[index] as Chronic;
      case 2:
        return record[index] as CurrentMedication;
      default:
        return record[index] as Allergy;
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = getRecordItem();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
      child: Card(
        elevation: 3,
        child: Container(
          height: 140.h,
          decoration: BoxDecoration(
            color: ColorsManager.lightgreyColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.r),
              bottomRight: Radius.circular(15.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
            child: category == 2
                ? MedicineCard(item: item)
                : NonMedicineCard(item: item),
          ),
        ),
      ),
    );
  }
}
