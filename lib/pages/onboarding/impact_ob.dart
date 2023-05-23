import 'package:flutter/material.dart';
import 'package:application_vfm_new/pages/home.dart';
import 'package:application_vfm_new/utils/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:application_vfm_new/services/impact.dart';//poi da modificare
import 'package:application_vfm_new/app_general_theme.dart';


class ImpactOnboarding extends StatefulWidget {
  static const route = '/impact/';
  static const routeDisplayName = 'ImpactOnboardingPage';

  ImpactOnboarding({Key? key}) : super(key: key);

  @override
  State<ImpactOnboarding> createState() => _ImpactOnboardingState();
}

class _ImpactOnboardingState extends State<ImpactOnboarding> {
  static bool _passwordVisible = false;
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _showPassword() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  Future<bool> _loginImpact(
      String name, String password, BuildContext context) async {
    ImpactService service = Provider.of<ImpactService>(context, listen: false);
    bool logged = await service.getTokens(name, password);//da modificare
    return logged;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backcolor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Image.asset('assets/impact_logo.png'),
              const Text('Please authorize to use our app',
                  style: TextStyle(
                    fontSize: 16,
                  )),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text('Username',
                    style:
                      AppTheme.impacttext),
              ),
              const SizedBox(
                height: 7,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is required';
                  }
                  return null;
                },
                controller: userController,
                cursorColor: const Color(0xFF83AA99),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: AppTheme.iconcolor,
                    ),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: AppTheme.iconcolor,
                  ),
                  hintText: 'Username',
                  hintStyle: AppTheme.impacthidentext,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text('Password',
                    style:
                        AppTheme.impacttext),
              ),
              const SizedBox(
                height: 7,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
                controller: passwordController,
                cursorColor: const Color(0xFF83AA99),
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: AppTheme.iconcolor,
                    ),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: AppTheme.iconcolor,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      _showPassword();
                    },
                  ),
                  hintText: 'Password',
                  hintStyle: AppTheme.impacthidentext,
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      bool? validation = await _loginImpact(userController.text,
                          passwordController.text, context);
                          //prende servizio e fa getToken da truefalse se c'è stato login
                          //se non valido mi dice che è sbagliato qualcosa altrimenti mi dice che le credenziali siano giuste
                      if (!validation) {
                        // if not correct show message
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(8),
                          content: Text('Wrong Credentials'),
                          duration: Duration(seconds: 2),
                        ));
                      } else{
                        await Provider.of<ImpactService>(context, listen: false)
                            .getPatient();
                        Future.delayed(
                              const Duration(milliseconds: 300),
                              () => Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const Home())));
                      }
                    },
                    style: ButtonStyle(
                        //maximumSize: const MaterialStatePropertyAll(Size(50, 20)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        elevation: MaterialStateProperty.all(0),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 12)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                           AppTheme.iconcolor)),
                    child: const Text('Authorize'),
                    
                    
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//servono per fare chiamate