import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyButton extends StatelessWidget {
  MyButton({
    required this.title,
    required this.color,
    required this.borderColor,
    required this.onPressed,
  });

  final Color color;
  final Color borderColor;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 6.h,
        width: 71.w,
        decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(10),
            color: color),
        child: Text(
          title,
          style: TextStyle(
              color: borderColor, fontSize: 12.sp, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}