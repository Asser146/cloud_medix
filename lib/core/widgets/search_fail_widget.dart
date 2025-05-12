import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SearchFailWidget extends StatelessWidget {
  const SearchFailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/search_fail.json',
        width: 200.sp, height: 200.sp);
  }
}
