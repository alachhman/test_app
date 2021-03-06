import 'package:flutter/material.dart';
import 'package:jfinalproject/TeamScreen.dart';
import 'MainScreen.dart';
import 'LoginScreen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
        theme: new ThemeData(
          primaryColor: Color(0xFF4B3F72),
        )
    );
  }
}