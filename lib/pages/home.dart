

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:application_vfm_new/pages/infoapp.dart';
import 'package:application_vfm_new/pages/info_dati_usati.dart';
import 'package:application_vfm_new/pages/profile.dart';
import 'package:application_vfm_new/pages/login.dart';

import 'package:application_vfm_new/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                  leading: const Icon(MdiIcons.bookInformationVariant,
                  size: 30,
                  color: Color.fromARGB(255, 215, 137, 27),),
                  title: const Text('App Information 1',
                  style: TextStyle(fontSize: 20,fontStyle: FontStyle.normal,color: Color.fromARGB(255, 25, 25, 25)),),
                  onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => InfoApp(),
                        ))
                      }),
              ListTile(
                  leading: const Icon(MdiIcons.bookHeart,size: 30,
                  color: Color.fromARGB(255, 215, 137, 27),),
                  title: const Text('Information about using data',
                  style: TextStyle(fontSize: 20,)),
                  onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => info_dati_usati(),
                        ))
                      }),
              const Padding(padding: 
              EdgeInsets.all(280.0)
              ),

              ListTile(
                  leading: const Icon(MdiIcons.logout,
                  size: 40,),
                  title: const Text('Logout', 
                  style: TextStyle(fontSize: 30),
                  ),
                  onTap: () => {
                    _toLoginPage(context),
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
   void _toLoginPage(BuildContext context) async{
    //Unset the 'username' filed in SharedPreference 
    final sp = await SharedPreferences.getInstance();
    sp.remove('username');

    //Pop the drawer first 
    Navigator.pop(context);
    //Then pop the HomePage
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }//_toCalendarPage

} //HomePage

