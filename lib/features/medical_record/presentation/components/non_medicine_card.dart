import 'package:cloud_medix/core/theming/font_weight_helper.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NonMedicineCard extends StatelessWidget {
  const NonMedicineCard({
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
          '• ${item.description}', // Now dynamic
          style: TextStyles.medicalRecordName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 8.h),
        Text(
          'Notes: ',
          style: TextStyles.medicalRecordTypeDesc,
        ),
        Expanded(
          // Prevents overflow by wrapping text properly
          child: Text(
            '${item.notes ?? "No description available."}', // Dynamic description
            style: TextStyles.medicalRecordTypeDesc
                .copyWith(fontWeight: FontWeightHelper.regular),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
