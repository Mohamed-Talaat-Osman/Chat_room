import 'dart:ui';

import 'package:chat_app/GlobalColors.dart';
import 'package:chat_app/screens/LoginScreen.dart';
import 'package:chat_app/screens/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../widgets/my_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String screenRoute = 'welcomeScreen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                height: 30.h,
                child: Image.asset('assets/images/talk.png'),
              ),
              Text(
                "Chat Room",
                style: TextStyle(
                    color: GlobalColors.lightgreen,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 6.h,
              ),
              MyButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.screenRoute);
                },
                title: "SignIn",
                color: GlobalColors.main,
                borderColor: Colors.white,
              ),
              SizedBox(
                height: 1.h,
              ),
              MyButton(
                title: "Register",
                color: Colors.white,
                borderColor: GlobalColors.main,
                onPressed: () {
                  Navigator.pushNamed(context, RegisterScreen.screenRoute);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}


