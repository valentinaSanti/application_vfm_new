import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:application_vfm_new/models/db.dart';

import '../providers/home_provider.dart';
import '../widget/score_circular.dart';

class footprint extends StatelessWidget {
  const footprint({Key? key}) : super(key: key);

  static const route = '/footprint/';
  static const routename = 'footprint';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(34, 45, 32, 23),
      appBar: AppBar(
        title: const Text(
          'Carbon Footprint',
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
      body: 
      Consumer<HomeProvider>(builder: (context, provider, child) {
        provider.sommaCFP(DateTime.now().subtract(Duration(days: 1)));
        final scoreValue = provider.cfp; 
        final scoreDistanceTot=provider.distanceTot;//._distanceTot mi da errore
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
                          ' You did a good job, walking these kilometres prevented your use of transport from having this carbon footprint. You helped the planet',
                          style: TextStyle(fontSize: 16),
                        )
                        //scrivere la distanza totale percorsa ottenuta dall'analisi 
                        
                      ]),
                ))),
          ),
          
        )
        
        );
      }),
    );
  }
}
