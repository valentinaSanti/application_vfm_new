import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:application_vfm_new/pages/infoapp.dart';
import 'package:application_vfm_new/pages/info_dati_usati.dart';
import 'package:application_vfm_new/pages/profile.dart';
import 'package:application_vfm_new/pages/login.dart';

import 'package:application_vfm_new/providers/home_provider.dart';
import 'package:provider/provider.dart';

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
              ListTile(
                  leading: const Icon(MdiIcons.logout),
                  title: const Text('Logout'),
                  onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => LoginPage()))
                      }),
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
            IconButton(
                padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                onPressed: () async {
                  Provider.of<HomeProvider>(context, listen: false);
                },
                icon: const Icon(
                  MdiIcons.download,
                  size: 40,
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
                  icon: const Icon(
                    MdiIcons.accountCircle,
                    size: 40,
                    color: Color.fromARGB(255, 235, 147, 24),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
