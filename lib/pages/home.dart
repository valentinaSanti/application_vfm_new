import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
                  leading: const Icon(MdiIcons.imageFilterDrama),
                  title: const Text('App Information 1'),
                  onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Inf(),
                        ))
                      }),
              ListTile(
                  leading: const Icon(MdiIcons.dotsHexagon),
                  title: const Text('App Information 2'),
                  onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => InfoExposure(),
                        ))
                      }),
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0xFF89453C)),
          elevation: 0,
          backgroundColor: const Color(0xFFE4DFD4),
          actions: [
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
                    color: Color(0xFF89453C),
                  )),
            )
          ],
        ),
        body: _selectPage(index: _selIdx),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFF83AA99),
          selectedItemColor: const Color(0xFF89453C),
          items: navBarItems,
          currentIndex: _selIdx,
          onTap: _onItemTapped,
        ));
  }
}
