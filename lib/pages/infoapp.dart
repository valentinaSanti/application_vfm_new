import 'package:flutter/material.dart';
import 'package:application_vfm_new/app_general_theme.dart';

import 'package:flutter/material.dart';

class InfoApp extends StatelessWidget {
  const InfoApp({Key? key}) : super(key: key);

  static const route = '/infoapp/';
  static const routename = 'InfoApp';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Discover our app',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppTheme.titles,
              fontFamily: 'San Francisco',
            ),
          ),
          iconTheme: const IconThemeData(color: AppTheme.icone),
          backgroundColor: AppTheme.backcolor),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.backcolor, AppTheme.iconcolor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                'EcoDriveMeter allows you to visualise the amount of carbon dioxide that has not been emitted as a result of choosing to move in a sustainable manner. From the data collected on the distance travelled on foot, the amount of carbon dioxide saved can be identified using the following calculation:',
                style: TextStyle(
                  fontSize: 20,
                  color: AppTheme.darkText,
                  fontFamily: 'San Francisco',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Carbon_Footprint = miles_coveres * 0.22143',
                style: TextStyle(
                  fontSize: 20,
                  color: AppTheme.darkText,
                  fontFamily: 'San Francisco',
                ),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/icons8-carbon-64.png',
                  width: 100,
                  height: 100,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
