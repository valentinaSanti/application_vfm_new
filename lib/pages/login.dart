import 'package:flutter/material.dart';

class Login extends StatelessWidget {
   Login({Key? key}) : super(key: key);

  static const route = '/login/';
  static const routename = 'Login';

  final _formKey = GlobalKey<FormState>();

  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFE4DFD4),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFE4DFD4),
          iconTheme: const IconThemeData(color: Color(0xFF89453C)),
          title:
              const Text('Profile', style: TextStyle(color: Colors.black)),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Center(
                child: CircleAvatar(
                    radius: 70, child: Image.asset('assets/profile.png'))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(width: 10),
                        const Text('Gender',
                            style: TextStyle(
                                color: Color(0xFF89453C), fontSize: 17)),
                        Radio(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xFF89453C)),
                          value: 1,
                          groupValue: 1,
                          onChanged: (val) {},
                        ),
                        const Text(
                          'MALE',
                          style: TextStyle(fontSize: 17.0),
                        ),
                        Radio(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => const Color(0xFF89453C)),
                            value: 2,
                            groupValue: 1,
                            onChanged: (val) {}),
                        const Text(
                          'FEMALE',
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
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
