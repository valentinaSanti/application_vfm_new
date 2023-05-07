import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:application_vfm_new/providers/profile_data.dart';
import 'package:provider/provider.dart';

List<String> option = ['MALE', 'FEMALE', 'NON SPECIFICATO'];

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  static const route = '/login/';
  static const routename = 'Login';
  String currentOption = option[1];

  final _formKey = GlobalKey<FormState>();

  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 197, 233, 152),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 197, 233, 152),
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 218, 162, 21)),
          title: const Text(
            'Profile',
            style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.normal,
                color: Color.fromARGB(255, 25, 25, 25)),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            ListTile(
              leading:ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                child: Image.asset('assets/profile.png'),
              ),
                title: Text('${context.watch<UserData>().name} ${context.watch<UserData>().surname}',
                  style: TextStyle(
                    color: Color.fromARGB(255, 218, 162, 21),
                    fontSize: 17,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(width: 10),
                        const Text('Gender:',
                            style: TextStyle(
                                color: Color.fromARGB(255, 218, 162, 21),
                                fontSize: 17)),
                        //Radio(
                        //  fillColor: MaterialStateColor.resolveWith(
                        //      (states) => const Color(0xFF89453C)),
                        //  value: 0,
                        //  groupValue: 1,
                        //  onChanged: (val) {},
                        //),
                        ListTile(
                            title: const Text('MALE',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 218, 162, 21),
                                    fontSize: 17)),
                            leading: Radio(
                              value: option[0],
                              groupValue: currentOption,
                              onChanged: (value) {
                                setState(() {
                                  currentOption = value.toString();
                                  context.read<UserData>().addData(currentOption);
                                });
                              },
                            )),
                        //const Text(
                        //  'MALE',
                        //  style: TextStyle(fontSize: 17.0),
                        //),
                        //Radio(
                        //    fillColor: MaterialStateColor.resolveWith(
                        //        (states) => const Color(0xFF89453C)),
                        //    value: 2,
                        //    groupValue: 1,
                        //    onChanged: (val) {}
                        //),
                        ListTile(
                            title: const Text('FEMALE',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 218, 162, 21),
                                    fontSize: 17)),
                            leading: Radio(
                              value: option[1],
                              groupValue: currentOption,
                              onChanged: (value) {
                                setState(() {
                                  currentOption = value.toString();
                                });
                              },
                            )),
                        ListTile(
                            title: const Text('NON SPECIFICATO',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 218, 162, 21),
                                    fontSize: 17)),
                            leading: Radio(
                              value: option[2],
                              groupValue: currentOption,
                              onChanged: (value) {
                                setState(() {
                                  currentOption = value.toString();
                                });
                              },
                            )),
                        //const Text(
                        //  'FEMALE',
                        //  style: TextStyle(
                        //    fontSize: 17.0,
                        //  ),
                        //),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your age';
                            } else if (int.tryParse(value) == null) {
                              return 'Please enter an integer valid number';
                            }
                            return null;
                          },
                          controller: ageController,
                          enabled: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFF89453C))),
                              labelText: 'Age',
                              labelStyle: TextStyle(color: Color(0xFF89453C)))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {}
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF83AA99),
                                shape: const CircleBorder()),
                            child: const Icon(Icons.check)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        )));
  } //build
}