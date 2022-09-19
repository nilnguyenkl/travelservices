import 'package:flutter/material.dart';
import 'package:travelservices/screens/pages/route_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData().copyWith(
      //   scaffoldBackgroundColor: Colors.white,
      //   colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.green.shade400)
      // ),
      debugShowCheckedModeBanner: false,
      home: const RoutePage()
    );    
  }
}