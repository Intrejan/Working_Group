import 'package:flutter/material.dart';
import 'package:working_group/user/register_page.dart';
import 'package:working_group/user/login_page.dart';
import 'partners.dart';
import 'home_page.dart';
import 'message.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes:{
          "LoginPage":(context)=>LoginPage(),
          "RegisterPage":(context)=>RegisterPage(),
          "HomePage":(context)=>Homepage(),
          "MessagePage":(context)=>MessagePage(),
          "Partners":(context)=>Partners(),
        },
        debugShowCheckedModeBanner: false,
      home: LoginPage()
    );
  }
}
