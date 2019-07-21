import 'package:flutter/material.dart';
import 'package:working_group/register_page.dart';

import 'group_screen.dart';
import 'login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes:{
          "LoginPage":(context)=>LoginPage(),
          "RegisterPage":(context)=>RegisterPage(),
          "GroupScreen":(context)=>GroupScreen(),
        },
        debugShowCheckedModeBanner: false,
      home: LoginPage()
    );
  }
}
