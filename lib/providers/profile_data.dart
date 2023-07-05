import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  List<String> _userData = [
    'Cristina',
    'Rossi',
    '50',
    'cristina.rossi@gmail.com',
    //Padova
    'maRioroSsi',
    'Male'
  ];

  String get name => _userData[0];
  String get surname => _userData[1];
  String get age => _userData[2];
  String get email => _userData[3];
  String get password => _userData[4];
  String get gender => _userData[5];

  void addData(int n, String data) {
    _userData.insert(n, data);
    notifyListeners();
  }

  void addData_(String data) {
    _userData.add(data);
    notifyListeners();
  }
}
