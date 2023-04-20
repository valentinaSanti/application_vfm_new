import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  static const route = '/login/';
  static const routename = 'Login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(34, 45, 32, 23),
      appBar: AppBar(title: const Text('About')),
    );
  }
}
