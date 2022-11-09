import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travelservices/routes.dart';

class ManagePageAdmin extends StatefulWidget {
  const ManagePageAdmin({Key? key}) : super(key: key);

  @override
  State<ManagePageAdmin> createState() => _ManagePageAdminState();
}

class _ManagePageAdminState extends State<ManagePageAdmin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: TextButton(
          onPressed: (){
            Navigator.pushNamed(context, Routes.createProductAdmin);
          }, 
          child: Text("asdsadsad")
        ),
      )
    );   
  }
}