import 'package:flutter/material.dart';
import 'package:application_vfm_new/providers/profile_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class create_profile extends StatelessWidget {
  create_profile({Key? key}) : super(key: key);

  static const route = '/create_profile/';
  static const routename = 'create_profile';
  String _age = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 197, 233, 152),
      appBar: AppBar(
        title: const Text('Create your own profile',
        style: TextStyle(
          fontSize: 20,
          fontStyle: FontStyle.normal,
          color: Color.fromARGB(255, 25, 25, 25)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: 400,
              child: TextFormField(
                validator: (value) {
                  int _age = value as int;
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  } else if (int.tryParse(value) == null) {
                    return 'Please enter an integer valid number';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1, color: Color(0xFF89453C)
                    )
                  ),
                  labelText: 'Age',
                  labelStyle: TextStyle(color: Color(0xFF89453C))
                )
              ),
            ),
           Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    onSaved: (String value) {
                      context.read<UserData>().addData(2, value);
                      print('added age: ${value}');
                      };
                    //context.read<UserData>().addData(2, _age as String);
                    //context.read<UserData>().addData(_age);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF83AA99),
                    shape: const CircleBorder()
                  ),
                  child: const Icon(Icons.check)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
