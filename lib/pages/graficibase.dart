import 'package:flutter/material.dart';
import 'package:application_vfm_new/app_general_theme.dart';

import 'package:flutter/material.dart';

class GraficiApp extends StatelessWidget {
  const GraficiApp({Key? key}) : super(key: key);

  static const route = '/infoapp/';
  static const routename = 'InfoApp';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Today Distance',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
            fontFamily: 'San Francisco',
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.orange),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
