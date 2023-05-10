import 'package:flutter/material.dart';

class InfoApp extends StatelessWidget {
  const InfoApp({Key? key}) : super(key: key);

  static const route = '/infoapp/';
  static const routename = 'InfoApp';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(34, 45, 32, 23),
      appBar: AppBar(
          title: const Text(
        'infoapp',
        style: TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.normal,
            color: Color.fromARGB(255, 25, 25, 25)),
      )),
    );
  }
}
