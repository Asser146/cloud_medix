import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InternetConnectionMessage extends StatelessWidget {
  const InternetConnectionMessage({
    super.key,
    required this.showBanner,
  });

  final bool showBanner;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedSlide(
        offset: showBanner ? Offset(0, 0) : Offset(0, -1),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        child: AnimatedOpacity(
          opacity: showBanner ? 1 : 0,
          duration: const Duration(milliseconds: 400),
          child: Container(
            width: double.infinity,
            color: Colors.grey,
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off, color: Colors.white),
                SizedBox(width: 8.w),
                Text(
                  "No internet connection",
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
