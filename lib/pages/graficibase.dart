import 'package:application_vfm_new/models/entities/distance.dart';
import 'package:application_vfm_new/widget/custom_plot.dart';
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
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: const BoxDecoration(
                color: AppTheme.widgetbasecolor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(68.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: AppTheme.widgetcolor,
                      offset: Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Consumer<HomeProvider>(
                builder: (context, provider, child) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 16, left: 16, right: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                            icon: const Icon(
                                                Icons.navigate_before),
                                            color: AppTheme.writegeneral,
                                            onPressed: () {
                                              DateTime day =
                                                  Provider.of<HomeProvider>(
                                                          context,
                                                          listen: false)
                                                      .showDate;
                                              Provider.of<HomeProvider>(context,
                                                      listen: false)
                                                  .getDataOfDay(day.subtract(
                                                      const Duration(days: 1)));
                                            }),
                                        Consumer<HomeProvider>(
                                            builder: (context, value, child) =>
                                                Text(
                                                  DateFormat('dd MMMM yyyy')
                                                      .format(value.showDate),
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppTheme.writegeneral,
                                                    fontFamily: 'San Francisco',
                                                  ),
                                                )),
                                        IconButton(
                                            icon:
                                                const Icon(Icons.navigate_next),
                                            color: AppTheme.writegeneral,
                                            onPressed: () {
                                              DateTime day =
                                                  Provider.of<HomeProvider>(
                                                          context,
                                                          listen: false)
                                                      .showDate;
                                              Provider.of<HomeProvider>(context,
                                                      listen: false)
                                                  .getDataOfDay(day.add(
                                                      const Duration(days: 1)));
                                            })
                                      ]),
                                ]),
                            const Padding(
                                padding: EdgeInsets.only(
                                    left: 4, bottom: 8, top: 16),
                                child: Text('Day-by-day Steps',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.writegeneral,
                                      fontFamily: 'San Francisco',
                                    ))),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 4, bottom: 3),
                                      child: Text(
                                        '${provider.footstepTot}', // implementiamo questo grafico per la distanza totale e usiamo un istogramma per i passi
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            //fontFamily: FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 32,
                                            color: AppTheme.writegeneral),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 8, bottom: 8),
                                      child: Text(
                                        'Steps',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            //fontFamily: FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            letterSpacing: -0.2,
                                            color: AppTheme.writegeneral),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Container(
                                height: 10,
                                width: 350,
                                decoration: BoxDecoration(
                                  color: AppTheme.graficvalue.withOpacity(0.4),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4.0)),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: (provider.footstepTot / 100),
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color: AppTheme.graficvalue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                              child: Text(
                                'Goal: 34000 steps',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: AppTheme.graficvalue),
                              ),
                            ),

                            //const Padding(
                            //padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            Consumer<HomeProvider>(
                                builder: (context, value, child) => CustomPlot(
                                    data: _parseData(value.distance)))
                          ],
                        ),
                      ),
                    ]),
              ))),
    );
  }

  List<Map<String, dynamic>> _parseData(List<Distance> data) {
    int divisore = 100000;
    return data
        .map(
          (e) => {
            'date': DateFormat('HH:mm').format(e.dateTime),
            'points': e.value! / divisore,
          },
        )
        .toList();
  }
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
