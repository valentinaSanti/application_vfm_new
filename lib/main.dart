import 'package:application_vfm_new/pages/home.dart';
import 'package:application_vfm_new/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:application_vfm_new/app_general_theme.dart';
import 'package:application_vfm_new/pages/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: LoginPage(),
    );
  }
}
