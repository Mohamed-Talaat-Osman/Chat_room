import 'package:chat_app/GlobalColors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyTextField extends StatelessWidget {
  MyTextField({
    required this.controller,
    //required this.onChange,
    required this.hintText,
    required this.hidden,
    //required this.icon,
    required this.autofill,
  });

  //final Function onChange;
  final TextEditingController controller;
  final String hintText;
  final bool hidden;
  //final Icon icon;
  final String autofill;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: TextField(
        controller: controller,
        autofillHints: [autofill],
        obscureText: hidden,
        //onChanged: (v) => onChange,
        decoration: InputDecoration(
          hintText: hintText,
          //prefix: icon,
          contentPadding: EdgeInsets.symmetric(
            //vertical: 0.5.h,
            horizontal: 3.w,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: GlobalColors.main,
              width: 2,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
