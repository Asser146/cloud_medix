import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({super.key, required this.title, required this.isPass});
  final String title;
  final bool isPass;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Container(
        width: 300,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          obscureText: isPass ? true : false,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: title,
            hintStyle: const TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
