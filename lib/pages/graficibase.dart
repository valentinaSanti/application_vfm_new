import 'package:flutter/material.dart';
import 'package:application_vfm_new/app_general_theme.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';
import '../widget/score_linear.dart';

class GraficiApp extends StatelessWidget {
  const GraficiApp({Key? key}) : super(key: key);

  static const route = '/infoapp/';
  static const routename = 'InfoApp';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Today Distance',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
            fontFamily: 'San Francisco',
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.orange),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      //da sostituire una volta implementata query DitanceTot con sommafootstep
      body: Consumer<HomeProvider>(builder: (context, provider, child) {
        provider.distanceTOT(DateTime.now().subtract(Duration(days: 1)));
        final scoreValue = provider.distanceTot; //._distanceTot mi da errore
        return Center(
            child: SizedBox(
          width: 150,
          height: 150,
          child: CustomPaint(
            painter: ScoreLinearProgress(
              backColor: Colors.grey,
              frontColor: Colors.green,
              strokeWidth: 20,
              value: scoreValue / 20000,
      ),),),); })
    );
  }
}
