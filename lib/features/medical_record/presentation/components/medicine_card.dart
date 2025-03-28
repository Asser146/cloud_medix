import 'package:cloud_medix/core/theming/font_weight_helper.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MedicineCard extends StatelessWidget {
  const MedicineCard({
    super.key,
    required this.item,
  });

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '• ${item.name}', // Now dynamic
          style: TextStyles.medicalRecordName,
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Text(
              'Dose: ',
              style: TextStyles.medicalRecordTypeDesc,
            ),
            Text(
              '${item.dose ?? "N/A"}', // Use dynamic type value
              style: TextStyles.medicalRecordTypeDesc
                  .copyWith(fontWeight: FontWeightHelper.regular),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Text(
              'Start Date: ',
              style: TextStyles.medicalRecordTypeDesc,
            ),
            Text(
              DateFormat('yyyy-MM-dd')
                  .format(item.startDate), // Use dynamic type value
              style: TextStyles.medicalRecordTypeDesc
                  .copyWith(fontWeight: FontWeightHelper.regular),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Text(
              'End Date: ',
              style: TextStyles.medicalRecordTypeDesc,
            ),
            Text(
              DateFormat('yyyy-MM-dd')
                  .format(item.endDate), // Use dynamic type value
              style: TextStyles.medicalRecordTypeDesc
                  .copyWith(fontWeight: FontWeightHelper.regular),
            ),
          ],
        ),
      ],
    );
  }
}
