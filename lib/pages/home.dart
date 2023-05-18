import 'package:application_vfm_new/pages/create_profile.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:application_vfm_new/pages/infoapp.dart';
import 'package:application_vfm_new/pages/info_dati_usati.dart';
import 'package:application_vfm_new/pages/profile.dart';
import 'package:application_vfm_new/pages/login.dart';

import 'package:application_vfm_new/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  static const route = '/home/';
  static const routeDisplayName = 'HomePage';

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<BottomNavigationBarItem> navBarItems = [
    const BottomNavigationBarItem(icon: Icon(MdiIcons.imageFilterDrama)),
  ];

  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider(),
      builder: (context, child) => Scaffold(
        backgroundColor: Color.fromARGB(255, 197, 233, 152),
        drawer: Drawer(
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
              ),
              ListTile(
                  leading: const Icon(
                    MdiIcons.bookInformationVariant,
                    size: 30,
                    color: Color.fromARGB(255, 215, 137, 27),
                  ),
                  title: const Text(
                    'Discover',
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        color: Color.fromARGB(255, 25, 25, 25)),
                  ),
                  onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => InfoApp(),
                        ))
                      }),
              ListTile(
                  leading: const Icon(
                    MdiIcons.bookHeart,
                    size: 30,
                    color: Color.fromARGB(255, 215, 137, 27),
                  ),
                  title: const Text('Information about using data',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => info_dati_usati(),
                        ))
                      }),
              ListTile(
                  leading: const Icon(
                    MdiIcons.plusLockOpen,
                    size: 30,
                    color: Color.fromARGB(255, 215, 137, 27),
                  ),
                  title: const Text('Are you new here?',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => create_profile(),
                        ))
                      }),
              const Padding(padding: EdgeInsets.all(250.0)),
              ListTile(
                  leading: const Icon(
                    MdiIcons.logout,
                    size: 35,
                  ),
                  title: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 25),
                  ),
                  onTap: () => {
                        _toLoginPage(context),
                      }),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(
            'Application VFM',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: [Colors.orange.shade300, Colors.orange.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0,
                    70.0)), // Aggiunge il gradiente come sfondo del testo del titolo
            ),
          ),
          centerTitle: true,
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 218, 162, 21)),
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 199, 237, 163),
          actions: [
            IconButton(
                padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                onPressed: () async {
                  Provider.of<HomeProvider>(context, listen: false);
                },
                icon: const Icon(
                  MdiIcons.download,
                  size: 30,
                  color: Color.fromARGB(255, 218, 148, 18),
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => Profile()));
                    },
                    icon: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(40.0)),
                      child: Image.asset('assets/profile.png'),
                      //iconSize: 40,
                      //color: Color.fromARGB(255, 235, 147, 24),
                    ))),
          ],
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
  } //_toCalendarPage
} //HomePage
