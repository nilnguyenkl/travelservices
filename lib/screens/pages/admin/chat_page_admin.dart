import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChatPageAdmin extends StatefulWidget {
  const ChatPageAdmin({Key? key}) : super(key: key);

  @override
  State<ChatPageAdmin> createState() => _ChatPageAdminState();
}

class _ChatPageAdminState extends State<ChatPageAdmin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Text("asdasdas"),
      )
    );
  }
}