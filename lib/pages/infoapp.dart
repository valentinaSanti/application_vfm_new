import 'package:flutter/material.dart';

class InfoApp extends StatelessWidget {
  const InfoApp({Key? key}) : super(key: key);

  static const route = '/infoapp/';
  static const routename = 'InfoApp';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(34, 45, 32, 23),
        appBar: AppBar(
            title: const Text(
          'Discover your Carbon Footprint',
          style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.normal,
              color: Color.fromARGB(255, 25, 25, 25)),
        )),
        body: SafeArea(
            //il widget viene ritagliato per adattarsi all'area dello schermo disponibile
            child: SingleChildScrollView(
                //il widget viene posizionato all'interno di una area scorrevole
                child: Padding(
          padding: const EdgeInsets.all(
              8.0), //aggiunge uno spazio di 8 pixel su tutti i lati
          child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, //allinea lungo l'asse
              children: const [
                Text(
                    'La applicazione calcola il quantitativo di CO2 che siamo riusciti a risparmiare dalla distanza che abbiamo percorso')
              ]),
        ))));
  }
}
