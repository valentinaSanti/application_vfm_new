import 'package:flutter/material.dart';
import 'package:application_vfm_new/pages/home.dart';
import 'package:application_vfm_new/pages/login.dart';
import 'package:application_vfm_new/pages/onboarding/impact_ob.dart';
import 'package:application_vfm_new/services/impact.dart'; //rimettere poi quello giusto
import 'package:application_vfm_new/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget {
  static const route = '/splash/';
  static const routeDisplayName = 'SplashPage';

  const Splash({Key? key}) : super(key: key);

  // Method for navigation SplashPage -> LoginPage
  void _toLoginPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => LoginPage())));
  } //_toLoginPage

  // Method for navigation SplashPage -> HomePage
  void _toHomePage(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: ((context) => Home())));
  } //_toHomePage

  // Method for navigation SplashPage -> Impact
  void _toImpactPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => ImpactOnboarding())));
  }

  void _checkAuth(BuildContext context) async {
    var prefs = Provider.of<Preferences>(context, listen: false);
    String? username = prefs.username;
    String? password = prefs.password;

    // no user logged in the app
    if (username == null || password == null) {
      Future.delayed(const Duration(seconds: 1), () => _toLoginPage(context));
    } else {
      ImpactService service =
          Provider.of<ImpactService>(context, listen: false);
      bool responseAccessToken = await service.checkSavedToken();
      bool refreshAccessToken = await service.checkSavedToken(refresh: true);

      // if we have a valid token for impact, proceed
      if (responseAccessToken || refreshAccessToken) {
        //if (prefs. != null) {
        //     Future.delayed(
        //         const Duration(seconds: 1), () => _toHomePage(context));
        //   } else {
        //     Future.delayed(const Duration(seconds: 1), () => _toPurpleAirPage(context));
        //   }
        // } else {
        Future.delayed(
            const Duration(seconds: 1), () => _toImpactPage(context));
      }
    }
  }
  //prende preferences con provider e verifica se sono logato se sono già loggato verifica che le preferences siano corrette
  //se uno dei 2 token è valido, allora verifico che anche purpol chiave salvata vado a homepage

  @override
  Widget build(BuildContext context) {
    //Future.delayed(const Duration(seconds: 5), () => _toLoginPage(context));
    Future.delayed(const Duration(seconds: 1), () => _checkAuth(context));
    return Material(
      child: Container(
        color: const Color(0xFF83AA99),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget>[
            Text(
              'Applicatio VFM',
              style: TextStyle(
                  color: Color(0xFFE4DFD4),
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            Center(
              child: CircularProgressIndicator(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF89453C)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//mostra il caricamento
//metto le condizioni dell'app che devono essere verificate
//ad esmpio verificare accesso ad app o bluetoth, potrei mettere ad esempio
//verifica connessione internet o se il server dei funziona