import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:application_vfm_new/models/db.dart';
import 'package:application_vfm_new/services/impact.dart';
import '../providers/home_provider.dart';
import '../widget/score_circular.dart';

class info_dati_usati extends StatelessWidget {
  const info_dati_usati({Key? key}) : super(key: key);

  static const route = '/info_dati_usati/';
  static const routename = 'info_dati_usati';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(34, 45, 32, 23),
      appBar: AppBar(
        title: const Text(
          'info dati usati',
          style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.normal,
              color: Color.fromARGB(255, 25, 25, 25)),
        ),
      ),
      body: Consumer<HomeProvider>(builder: (context, provider, child) {
          provider.sommaCFP(DateTime.now().subtract(Duration(days: 1)));
          final scoreValue = provider.cfp; //._distanceTot mi da errore
          return Center(
              child: SizedBox(
            width: 150,
            height: 150,
            child: CustomPaint(
              painter: ScoreCircularProgress(
                backColor: Color.fromARGB(255, 190, 235, 170),
                frontColor: Color.fromARGB(255, 186, 110, 4),
                strokeWidth: 20,
                value: scoreValue / 100,
              ),
              child: Align(
                  alignment: Alignment.center,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${scoreValue}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFF89453C)),
                          ),
                          const Text(
                            ' Not good',
                            style: TextStyle(fontSize: 16),
                          )
                        ]),
                  ))),
            ),
          ));
        }),
    );
  }
}
