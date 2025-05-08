import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_medix/features/reservation/blocs/reservation_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterOption extends StatefulWidget {
  const FilterOption({super.key});

  @override
  State<FilterOption> createState() => _FilterOptionState();
}

class _FilterOptionState extends State<FilterOption> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReservationCubit>();

    final selectedHospitalId = cubit.selectedHospitalId;

    final selectedHospitalName = cubit.hospitals
        .firstWhere((h) => h.hospitalId == selectedHospitalId,
            orElse: () => cubit.hospitals[0])
        .hospitalName;

    return Container(
      width: 0.4.sw,
      padding: EdgeInsets.only(left: 10.w, top: 3.h, bottom: 3.h),
      decoration: BoxDecoration(
        color: ColorsManager.primaryColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedHospitalName,
          icon: Icon(
            Icons.arrow_drop_down_rounded,
            color: Colors.white,
            size: 40.sp,
          ),
          dropdownColor: ColorsManager.primaryColor,
          style: TextStyles.appBarTexts.copyWith(fontSize: 14.sp),
          items: cubit.hospitals
              .map((hospital) => DropdownMenuItem<String>(
                    value: hospital.hospitalName,
                    child: Center(
                      child: Text(
                        hospital.hospitalName,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ))
              .toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              final selectedHospital = cubit.hospitals
                  .firstWhere((hospital) => hospital.hospitalName == newValue);
              cubit.changeHospital(selectedHospital.hospitalId);
              setState(() {}); // Trigger rebuild to update selection
            }
          },
        ),
      ),
    );
  }
}
