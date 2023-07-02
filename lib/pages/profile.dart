import 'package:application_vfm_new/app_general_theme.dart';
import 'package:application_vfm_new/models/db.dart';
import 'package:application_vfm_new/providers/home_provider.dart';
import 'package:application_vfm_new/services/impact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:application_vfm_new/providers/profile_data.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:application_vfm_new/utils/shared_preferences.dart';

List<String> option = ['MALE', 'FEMALE', 'NON SPECIFICATO'];

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //necessario a fornire due provider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(
          create: (_) => HomeProvider(
            Provider.of<ImpactService>(context, listen: false),
            Provider.of<AppDatabase>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<UserData>(
          create: (_) => UserData(),
        ),
      ],
      child:
          ProfileScreen(), //profileScreen così ha l'accesso ai dati forniti dai due provider
    );
  }
}

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const route = '/login/';
  static const routename = 'Login';
  String currentOption = option[1];

  final _formKey = GlobalKey<FormState>();

  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backhome,
      appBar: AppBar(
        backgroundColor: AppTheme.backhome,
        iconTheme: const IconThemeData(color: AppTheme.icone),
        title: const Text(
          'Profile',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.titles),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Transform.scale(
                scale: 0.5,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                  child: Image.asset('assets/profile.png'),
                ),
              ),
            ),
            Text(
              '${context.watch<UserData>().name} ${context.watch<UserData>().surname}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkText,
                fontFamily: 'San Francisco',
              ),
            ),
            SizedBox(height: 40),
            Align(
                alignment: Alignment.centerLeft,
                child: Row(children: [
                  Text('   '),
                  Icon(MdiIcons.mapMarker, size: 30, color: AppTheme.icone),
                  Text('  Padova',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: AppTheme.darkText,
                        fontFamily: 'San Francisco',
                      ))
                ])),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '   Email: ${context.watch<UserData>().email}',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: AppTheme.darkText,
                  fontFamily: 'San Francisco',
                ),
              ),
            ),
            SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 5),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('   Gender:',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppTheme.darkText,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'San Francisco',
                            )),
                      ),
                      ListTile(
                          title: const Text('Male',
                              style: TextStyle(
                                  color: AppTheme.darkText, fontSize: 16)),
                          leading: Radio(
                            value: option[0],
                            groupValue: currentOption,
                            onChanged: (value) {
                              setState(() {
                                currentOption = value.toString();
                                //context.read<UserData>().addData(currentOption);
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
                          title: const Text('Female',
                              style: TextStyle(
                                  color: AppTheme.darkText, fontSize: 16)),
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
                          title: const Text('Prefer not to say',
                              style: TextStyle(
                                  color: AppTheme.darkText, fontSize: 16)),
                          leading: Radio(
                            value: option[2],
                            groupValue: currentOption,
                            onChanged: (value) {
                              setState(() {
                                currentOption = value.toString();
                              });
                            },
                          )),
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
                                    width: 1, color: AppTheme.darkText)),
                            labelText: 'Age',
                            labelStyle: TextStyle(color: AppTheme.darkText))),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              //prefs.age = ageController.text;

                              //da sistemare age nelle preferences
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.icone,
                              shape: const CircleBorder()),
                          child: const Icon(Icons.check)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
