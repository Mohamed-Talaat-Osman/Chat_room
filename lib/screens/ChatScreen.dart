import 'package:chat_app/GlobalColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';

final _fireStore = FirebaseFirestore.instance;
late User signedInUser;

class ChatScreen extends StatefulWidget {
  static const String screenRoute = 'chatScreen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  late final _massage = TextEditingController();

  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.main,
        title: Row(
          children: [
            Image.asset(
              'assets/images/talk.png',
              width: 9.w,
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(
              "Chat Room",
              style: TextStyle(
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: GlobalColors.lightgreen,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MassageStreamBuilder(),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: GlobalColors.main,
                      width: 3,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _massage,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 1.h,
                              horizontal: 3.w,
                            ),
                            hintText: "write your massage here..."),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _fireStore.collection('massages').add({
                          'text': _massage.text,
                          'sender': signedInUser.email,
                          'time': FieldValue.serverTimestamp(),
                        });
                        _massage.clear();
                      },
                      child: Text(
                        "Send",
                        style: TextStyle(
                            color: GlobalColors.main,
                            fontWeight: FontWeight.bold,
                            fontSize: 11.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MassageStreamBuilder extends StatelessWidget {
  const MassageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('massages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<MassageLine> massageWidgets = [];
        if (!snapshot.hasData) {
          // Add spinner
        }
        final massages = snapshot.data!.docs;
        for (var massage in massages) {
          final massageText = massage.get('text');
          final massageSender = massage.get('sender');
          final currentUser = signedInUser.email;

          final massageWidget = MassageLine(
            text: massageText,
            sender: massageSender,
            isMe: currentUser == massageSender,
          );
          massageWidgets.add(massageWidget);
        }

        return Expanded(
          child: ListView(
            reverse: false,
            padding: EdgeInsets.symmetric(
              horizontal: 3.w,
              vertical: 2.h,
            ),
            children: massageWidgets,
          ),
        );
      },
    );
  }
}

class MassageLine extends StatelessWidget {
  MassageLine({
    this.text,
    this.sender,
    required this.isMe,
  });

  final String? text;
  final String? sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          "$sender",
          style: TextStyle(
            fontSize: 10.sp,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 3.w,
            vertical: 1.h,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 0.8.h,
          ),
          decoration: BoxDecoration(
            color: isMe ? GlobalColors.main : Colors.grey,
            borderRadius: BorderRadius.only(
              topLeft:
                  isMe ? const Radius.circular(20) : const Radius.circular(0),
              bottomLeft: const Radius.circular(20),
              bottomRight: const Radius.circular(20),
              topRight:
                  isMe ? const Radius.circular(0) : const Radius.circular(20),
            ),
          ),
          child: Text(
            '$text',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
