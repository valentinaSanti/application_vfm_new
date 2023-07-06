import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_general_theme.dart';
import '../pages/login.dart';

class DialogLog extends StatelessWidget {
  const DialogLog({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppTheme.icone),
              ),
            ),
            TextButton(
              onPressed: () => _toLoginPage(context),
              child: const Text(
                'Yes',
                style: TextStyle(color: AppTheme.icone),
              ),
            ),
          ],
        ),
      ),
      child: ListTile(
        leading: const Icon(MdiIcons.logout, size: 30, color: AppTheme.icone),
        title: const Text(
          'Logout',
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }

  void _toLoginPage(BuildContext context) async {
    //Unset the 'username' filed in SharedPreference
    final sp = await SharedPreferences.getInstance();
    sp.remove('username');

    //Pop the drawer first
    Navigator.pop(context);
    //Then pop the HomePage
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
