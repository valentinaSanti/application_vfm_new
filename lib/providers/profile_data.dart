import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  List<String> _userData = ['Matteo','Carraro'];

  String get name => _userData[0];
  String get surname => _userData[1];
  String get gender => _userData[2];

  void addData(String data){
    _userData.add(data);
    notifyListeners();
  }

}