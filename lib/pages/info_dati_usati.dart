import 'package:flutter/material.dart';

class info_dati_usati extends StatelessWidget {
  const info_dati_usati({Key? key}) : super(key: key);

  static const route = '/info_dati_usati/';
  static const routename = 'info_dati_usati';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(34, 45, 32, 23),
      appBar: AppBar(title: const Text('About')),
    );
  }
}
