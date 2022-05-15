import 'package:chat_app/screens/ChatScreen.dart';
import 'package:chat_app/screens/LoginScreen.dart';
import 'package:chat_app/screens/WelcomeScreen.dart';
import 'package:chat_app/screens/RegisterScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'BarlowSemiCondensed',
        ),
        //home: ChatScreen(),
        initialRoute: _auth.currentUser != null ? ChatScreen.screenRoute
        : WelcomeScreen.screenRoute,
        routes: {
          WelcomeScreen.screenRoute : (context) => WelcomeScreen(),
          RegisterScreen.screenRoute : (context) => RegisterScreen(),
          LoginScreen.screenRoute : (context) => LoginScreen(),
          ChatScreen.screenRoute : (context) => ChatScreen(),
        },
      );
    });
  }
}
