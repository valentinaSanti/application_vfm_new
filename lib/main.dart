import 'package:application_vfm_new/pages/home.dart';
import 'package:application_vfm_new/pages/login.dart';
import 'package:application_vfm_new/providers/profile_data.dart';
import 'package:flutter/material.dart';
import 'package:application_vfm_new/app_general_theme.dart';
import 'package:application_vfm_new/pages/profile.dart';
import 'package:provider/provider.dart';
import 'package:application_vfm_new/utils/shared_preferences.dart';
import 'package:application_vfm_new/services/impact.dart'; //poi da modificare
import 'package:application_vfm_new/pages/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Preferences>(
          //dire che provider stiamo creando
          create: (context) => Preferences()..init(),
          // This creates the preferences when the provider is creater. With lazy = true (default), the preferences would be initialized when first accessed, but we need them for the other services
          lazy: false,
        ),
        Provider(
            create: (context) => ImpactService(
                  // We pass the newly created preferences to the service
                  Provider.of<Preferences>(context, listen: false),
                )),
        //in questo modo faccio unico servizio, uso metodo create solo quando l'oggetto viene chiamato prima volta voglio preferences inizializzate la prima
        //volta con lazy chiedo nche vengano inizializzate subito
        ChangeNotifierProvider(create: (_) => UserData())
      ],
      //c'è chiave nell'header specifico per questo
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Splash(),
      ),
    );
  }
}
