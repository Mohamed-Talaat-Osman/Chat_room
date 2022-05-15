import 'package:chat_app/GlobalColors.dart';
import 'package:chat_app/screens/ChatScreen.dart';
import 'package:chat_app/widgets/my_button.dart';
import 'package:chat_app/widgets/my_textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatefulWidget {
  static const String screenRoute = 'registerScreen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  late final _email = TextEditingController();
  late final _password = TextEditingController();
  late final _userName = TextEditingController();

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
                  //   userName = value;
                  // },
                  controller: _userName,
                  hintText: "Enter your Name",
                  hidden: false,
                  //icon: const Icon(Icons.person),
                  autofill: AutofillHints.name,
                ),
                SizedBox(
                  height: 1.h,
                ),
                MyTextField(
                  controller: _email,
                  // onChange: (value) {
                  //   email = value;
                  // },
                  hintText: "Enter your e-mail",
                  hidden: false,
                  //icon: const Icon(Icons.email),
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
                  //icon: const Icon(Icons.lock),
                  autofill: AutofillHints.password,
                ),
                SizedBox(
                  height: 2.h,
                ),
                MyButton(
                  title: "Register",
                  color: GlobalColors.main,
                  borderColor: Colors.white,
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: _email.text.trim(), password: _password.text.trim());
                      Navigator.pushNamed(context, ChatScreen.screenRoute);
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      setState(() {
                        showSpinner = false;
                      });
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
