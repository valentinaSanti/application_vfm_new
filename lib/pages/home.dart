import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:application_vfm_new/pages/infoapp.dart';
import 'package:application_vfm_new/pages/info_dati_usati.dart';
import 'package:application_vfm_new/pages/login.dart';

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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 197, 233, 152),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
                leading: const Icon(MdiIcons.logout),
                title: const Text('Logout'),
                // delete all data from the database
                onTap: () => {}),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('About'),
            ),
            ListTile(
                leading: const Icon(MdiIcons.bookInformationVariant),
                title: const Text('App Information 1'),
                onTap: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => InfoApp(),
                      ))
                    }),
            ListTile(
                leading: const Icon(MdiIcons.bookHeart),
                title: const Text('Information about using data'),
                onTap: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => info_dati_usati(),
                      ))
                    }),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 218, 162, 21)),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 199, 237, 163),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => Login()));
                },
                icon: const Icon(
                  MdiIcons.accountCircle,
                  size: 40,
                  color: Color.fromARGB(255, 218, 148, 18),
                )),
          )
        ],
      ),
    );
  }
}
