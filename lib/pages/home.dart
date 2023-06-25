import 'package:application_vfm_new/models/db.dart';
import 'package:application_vfm_new/pages/create_profile.dart';
import 'package:application_vfm_new/pages/graficibase.dart';
import 'package:application_vfm_new/services/impact.dart';
//import 'package:application_vfm_new/widget/score_circular.dart';
import 'package:flutter/material.dart';
//import 'package:graphic/graphic.dart' hide view;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:application_vfm_new/pages/infoapp.dart';
import 'package:application_vfm_new/pages/footprint.dart';
import 'package:application_vfm_new/pages/profile.dart';
import 'package:application_vfm_new/pages/login.dart';
import 'package:application_vfm_new/app_general_theme.dart';

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
  int _selectedIndex = 0;
  List<BottomNavigationBarItem> navBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home Page',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.forest_outlined),
      label: 'Footprint',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _selectPage({
    required int index,
  }) {
    switch (index) {
      case 0:
        return GraficiApp();
      case 1:
        return footprint();
      default:
        return GraficiApp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider(
          Provider.of<ImpactService>(context, listen: false),
          Provider.of<AppDatabase>(context, listen: false)),
      lazy: false,
      builder: (context, child) => Scaffold(
        backgroundColor: AppTheme.backhome,
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
          title: const Text(
            'Footprint Tracker',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 215, 137, 27),
              // foreground: Paint()
              //   ..shader = LinearGradient(
              //     colors: [Colors.orange.shade300, Colors.orange.shade700],
              //     begin: Alignment.topLeft,
              //     end: Alignment.bottomRight,
              //   ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0,
              //       70.0)), // Aggiunge il gradiente come sfondo del testo del titolo
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
        body: Provider.of<HomeProvider>(context).doneInit
        ? _selectPage(index: _selectedIndex)
        : const Center(
                  child: CircularProgressIndicator(),
                ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppTheme.backhome,
          items: navBarItems,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
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
