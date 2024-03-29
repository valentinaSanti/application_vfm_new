import 'package:application_vfm_new/app_general_theme.dart';
import 'package:application_vfm_new/pages/home.dart';
import 'package:application_vfm_new/pages/onboarding/impact_ob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const route = '/login/';
  static const routeDisplayName = 'LoginPage';

  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    //Check if the user is already logged in before rendering the login page
    _checkLogin();
  } //initState

  void _checkLogin() async {
    //Get the SharedPreference instance and check if the value of the 'username' filed is set or not
    final sp = await SharedPreferences.getInstance();
    if (sp.getString('username') != null) {
      //If 'username is set, push the HomePage
      _toHomePage(context);
    } //if
  } //_checkLogin

  Future<String> _loginUser(LoginData data) async {
    if (data.name == 'bug@expert.com' && data.password == 'password34') {
      final sp = await SharedPreferences.getInstance();
      sp.setString('username', data.name);

      return '';
    } else {
      return 'Wrong credentials';
    }
  }

  // _loginUser
  Future<String> _signUpUser(SignupData data) async {
    return 'To be implemented';
  }

  // _signUpUser
  Future<String> _recoverPassword(String email) async {
    return 'Recover password functionality needs to be implemented';
  }

  // _recoverPassword
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      
      title: 'EcoDriveMeter',
      theme: LoginTheme(
          primaryColor: AppTheme.backcolor,
          accentColor: AppTheme.iconcolor,
          buttonStyle: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.black,
          )),
      onLogin: _loginUser,
      onSignup: _signUpUser,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () async {
        _toHomePage(context);
      },
    );
  } // build

  void _toHomePage(BuildContext context) {
    //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ImpactOnboarding()));
  } //_toHomePage
} // LoginScreen
