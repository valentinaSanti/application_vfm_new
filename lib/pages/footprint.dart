import 'package:application_vfm_new/app_general_theme.dart';
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
    
    return SingleChildScrollView ( //A box in which a single widget can be scrolled
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF253840),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topRight: Radius.circular(68.0)
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color.fromRGBO(233, 233, 233, 0.6),
                offset: Offset(1.1, 1.1),
                blurRadius: 10.0
              ),
            ],
          ),
        child: Consumer<HomeProvider>(
          builder: (context, provider, child)=>Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(left: 140, bottom: 8, top: 16),
                      child: Text(
                        'Carbon footprint',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontFamily: 'San Francisco',
                        )
                      )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 4, bottom: 3),
                              child: Text(
                                '${provider.cfp.toStringAsFixed(3)}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  //fontFamily: FitnessAppTheme.fontName,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                  color: Colors.orange
                                ),
                              ),
                            ),
                          const Padding( 
                            padding: EdgeInsets.only(left: 8, bottom: 8),
                              child: Text(
                                '[kgCO2e]',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  //fontFamily: FitnessAppTheme.fontName,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: -0.2,
                                  color: Colors.orange
                                ),
                              ),
                          ),
                        ],
                      )],
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 100.0),
                    child: SizedBox(
                        width: 200,
                        height: 200,
                        child: CustomPaint(
                          painter: ScoreCircularProgress(
                            backColor: Color.fromARGB(255, 190, 235, 170),
                            frontColor: Color.fromARGB(255, 186, 110, 4),
                            strokeWidth: 20,
                            value: provider.cfp,
                          ),
                        )
                    ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20, right: 20),
                child: Text(
                  'You did a good job, walking these kilometres prevented your use of transport from having this carbon footprint. You helped the planet',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color.fromARGB(255, 215, 137, 27)),
                ),
              ),
            //]
              //inserire un grafico che fa l'evoluzione degli step come quello di cui abbiamo parlato
              //da implementare all'interno di  widget come nuova pagina e poi da inseririre qui
            ],
           ),
         ),
       ),
    )
  );
  }
}
