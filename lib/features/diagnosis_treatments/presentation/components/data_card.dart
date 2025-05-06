import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/theming/font_weight_helper.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:cloud_medix/features/diagnosis_treatments/data/diagnosis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DataCard extends StatelessWidget {
  const DataCard({
    super.key,
    required this.data,
  });

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    // Safely parse issuedDate to DateTime
    DateTime? parsedDate;
    if (data.issuedDate is String) {
      parsedDate = DateTime.tryParse(data.issuedDate);
    } else if (data.issuedDate is DateTime) {
      parsedDate = data.issuedDate;
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
      child: Card(
        elevation: 3,
        child: Container(
          height: data is Diagnosis ? 140.h : 100.h,
          decoration: BoxDecoration(
            color: ColorsManager.lightgreyColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.r),
              bottomRight: Radius.circular(15.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '• ${data.type}',
                  style: TextStyles.medicalRecordName,
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      'Date: ',
                      style: TextStyles.medicalRecordTypeDesc,
                    ),
                    Text(
                      parsedDate != null
                          ? DateFormat('yyyy-MM-dd').format(parsedDate)
                          : 'Invalid date',
                      style: TextStyles.medicalRecordTypeDesc.copyWith(
                        fontWeight: FontWeightHelper.regular,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Doctor: ',
                      style: TextStyles.medicalRecordTypeDesc,
                    ),
                    Text(
                      '${data.physicianFullname}',
                      style: TextStyles.medicalRecordTypeDesc.copyWith(
                        fontWeight: FontWeightHelper.regular,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Hospital: ',
                      style: TextStyles.medicalRecordTypeDesc,
                    ),
                    Text(
                      '${data.hospitalName}',
                      style: TextStyles.medicalRecordTypeDesc.copyWith(
                        fontWeight: FontWeightHelper.regular,
                      ),
                    ),
                  ],
                ),
                if (data is Diagnosis) ...[
                  Text(
                    'Description: ',
                    style: TextStyles.medicalRecordTypeDesc,
                  ),
                  Expanded(
                    child: Text(
                      '${data.description}',
                      style: TextStyles.medicalRecordTypeDesc.copyWith(
                        fontWeight: FontWeightHelper.regular,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
