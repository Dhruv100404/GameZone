import 'package:flutterlogin_signup/pages/game2/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget{
 // const MyApp(appUrl, {super.key});
  Widget build(BuildContext context){
    return MaterialApp(
          debugShowCheckedModeBanner: false,
          home:HomeScreen(),
    );
  }
}