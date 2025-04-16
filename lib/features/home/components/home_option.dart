import 'package:cloud_medix/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeOption extends StatelessWidget {
  const HomeOption({
    super.key,
    required this.text,
    required this.path,
  });
  final String text, path;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Card(
        elevation: 4,
        shadowColor: Colors.black,
        child: Container(
          height: 80.h,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12.sp))),
          child: Row(
            children: [
              const Spacer(),
              Text(
                text,
                style: TextStyles.cyanTexts,
              ),
              const Spacer(),
              Container(
                margin: EdgeInsets.all(5.w),
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: SvgPicture.asset(
                    height: 55.h,
                    path,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
