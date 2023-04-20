import 'dart:io';

import 'package:flutter/material.dart';

class InfoApp extends StatelessWidget {
  const InfoApp({Key? key}) : super(key: key);

  static const route = '/infoapp/';
  static const routename = 'InfoApp';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.green,
        appBar: AppBar(
          title: const Text('About')
    ),
  }

}
