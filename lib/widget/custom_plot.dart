import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

class CustomPlot extends StatelessWidget{
  const CustomPlot({
    Key? key,
    required this.data,
  }):super(key:key);
  final List<Map<String,dynamic>> data;

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: 360,//da sistemare in base alle dimensioni dell'altro grafico
      height: 250, //vedi dimensioni resto della pagina
      child: Chart(
        rebuild: true,
        data: data, 
        variables: {
          'date': Variable(
            accessor: (Map map) => map['date'] as String,
            scale: OrdinalScale(tickCount: 5),
          ),
          'points': Variable(
            accessor: (Map map) => map['distance'] as num,
          ),
        },
        elements: [IntervalElement()],
         axes: [
          Defaults.horizontalAxis,
          Defaults.verticalAxis,
        ],
      ),
    );
  }

}