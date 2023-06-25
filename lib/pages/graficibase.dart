import 'package:flutter/material.dart';
import 'package:application_vfm_new/app_general_theme.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';
import '../widget/score_linear.dart';

class GraficiApp extends StatelessWidget {

  static const route = '/graficiBase/';
  static const routename = 'GraficiBase';

  GraficiApp({Key? key}) : super(key: key);
  DateTime day = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( //A box in which a single widget can be scrolled
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<HomeProvider>(
          builder: (context, provider, child)=>Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Today Distance',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  fontFamily: 'San Francisco',
                ),
              ),
              Align(alignment: Alignment.center,
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: CustomPaint(
                    painter: ScoreLinearProgress(
                      backColor: Color.fromARGB(255, 147, 146, 146).withOpacity(0.4),
                      frontColor: Color.fromARGB(255, 54, 192, 89),
                      strokeWidth: 20,
                      value: provider.distanceTot/ 100,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top:40.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${provider.distanceTot}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color(0)),
                                ),
                          ]),
                          ),
                      ),
                    ),
                  ),
                ),   
              ),
              const Text(
                'Today Step evolution',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  fontFamily: 'San Francisco',
                ),
              ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: const Icon(Icons.navigate_before),
                      onPressed: () {
                        DateTime day =
                            Provider.of<HomeProvider>(context, listen: false)
                                .showDate;
                        Provider.of<HomeProvider>(context, listen: false)
                            .getDataOfDay(
                                day.subtract(const Duration(days: 1)));
                      }),
                  Consumer<HomeProvider>(
                      builder: (context, value, child) => Text(
                          DateFormat('dd MMMM yyyy').format(value.showDate))),
                  IconButton(
                      icon: const Icon(Icons.navigate_next),
                      onPressed: () {
                        DateTime day =
                            Provider.of<HomeProvider>(context, listen: false)
                                .showDate;
                        Provider.of<HomeProvider>(context, listen: false)
                            .getDataOfDay(day.add(const Duration(days: 1)));
                      })
                ],
              ), 
              //inserire un grafico che fa l'evoluzione degli step come quello di cui abbiamo parlato
              //da implementare all'interno di  widget come nuova pagina e poi da inseririre qui
            ],
          ),
        ),
      ),
    );
  }
  //inserire eventuale codice che mappa i valori in base alla data creando una  lista vedi tutorato riga 154
  // di pollutants.dart
}
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text(
    //       'Today Distance',
    //       style: TextStyle(
    //         fontSize: 18,
    //         fontWeight: FontWeight.bold,
    //         color: Colors.orange,
    //         fontFamily: 'San Francisco',
    //       ),
    //     ),
    //     iconTheme: const IconThemeData(color: Colors.orange),
    //     elevation: 0,
    //     backgroundColor: Colors.transparent,
    //   ),
    //   //da sostituire una volta implementata query DitanceTot con sommafootstep
    //   body: Consumer<HomeProvider>(builder: (context, provider, child) {
    //     provider.distanceTOT(DateTime.now().subtract(Duration(days: 1)));
    //     final scoreValue = provider.distanceTot; //._distanceTot mi da errore
    //     Align(
    //     alignment: Alignment.center,
    //             child: SizedBox(
    //               width: 150,
    //               height: 150,
    //               child: CustomPaint(
    //                 painter: ScoreLinearProgress(
    //                   backColor: Color.fromARGB(255, 147, 146, 146).withOpacity(0.4),
    //                   frontColor: Color.fromARGB(255, 54, 192, 89),
    //                   strokeWidth: 20,
    //                   value: scoreValue/ 100,
    //                 ),
    //                 child: Align(
    //                   alignment: Alignment.center,
    //                     child: Center(
    //                         child: Padding(
    //                       padding: const EdgeInsets.only(top: 40.0),
    //                       child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.start,
    //                           children: [
    //                             Text(
    //                               '${provider.distanceTOT}',
    //                               style: const TextStyle(
    //                                   fontWeight: FontWeight.bold,
    //                                   fontSize: 20,
    //                                   color: Color.fromARGB(255, 9, 9, 9)),
    //                             ),])
    //                 ))),


    //   ),),);
    //   })
    //   // Consumer<HomeProvider>(builder: (context, provider, child) {
    //   //   provider.distanceTOT(DateTime.now().subtract(Duration(days: 1)));
    //   //   final scoreValue = provider.distanceTot; //._distanceTot mi da errore
    //   //   return Center(
    //   //       child: SizedBox(
    //   //     width: 150,
    //   //     height: 150,
    //   //     child: CustomPaint(
    //   //       painter: ScoreLinearProgress(
    //   //         backColor: Colors.grey,
    //   //         frontColor: Colors.green,
    //   //         strokeWidth: 20,
    //   //         value: scoreValue / 20000,
    //   // ),),),); })
    // );
  

