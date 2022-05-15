import 'package:chat_app/GlobalColors.dart';
import 'package:chat_app/screens/ChatScreen.dart';
import 'package:chat_app/widgets/my_button.dart';
import 'package:chat_app/widgets/my_textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  static const String screenRoute = 'loginScreen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late final _email = TextEditingController();
  late final _password = TextEditingController();

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: GlobalColors.lightgreen,
        child: Column(
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
                MyTextField(
                  // onChange: (value) {
                  //   email = value;
                  // },
                  controller: _email,
                  hintText: "Enter your e-mail",
                  hidden: false,
                  // icon: const Icon(Icons.email),
                  autofill: AutofillHints.email,
                ),
                SizedBox(
                  height: 1.h,
                ),
                MyTextField(
                  // onChange: (value) {
                  //   password = value;
                  // },
                  controller: _password,
                  hintText: "Enter your password",
                  hidden: true,
                  // icon: const Icon(Icons.lock,color: Colors.grey,),
                  autofill: AutofillHints.password,
                ),
                SizedBox(
                  height: 2.h,
                ),
                MyButton(
                  title: "Login",
                  color: GlobalColors.main,
                  borderColor: Colors.white,
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: _email.text.trim(), password: _password.text.trim());
                      if (user != null) {
                        Navigator.pushNamed(context, ChatScreen.screenRoute);
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    } catch (e) {
                      Fluttertoast.showToast(
                          msg: "$e",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 11.sp);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
