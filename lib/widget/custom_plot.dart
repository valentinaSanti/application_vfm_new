import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

class CustomPlot extends StatelessWidget {
  const CustomPlot({
    Key? key,
    required this.data,
  }) : super(key: key);
  final List<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260, //da sistemare in base alle dimensioni dell'altro grafico
      height: 150, //vedi dimensioni resto della pagina
      child: Chart(
        rebuild: true,
        data: data,
        variables: {
          'time': Variable(
            accessor: (Map map) => map['date'] as String,
            scale: OrdinalScale(tickCount: 5),
          ),
          'points': Variable(
            accessor: (Map map) => map['points'] as num,
          ),
        },
        elements: [ IntervalElement(
            position: Varset('time') * Varset('points'),
            size: SizeAttr(value: 2),
            color: ColorAttr (value: const Color(0xFF83AA99)),

        )],
        // <GeomElement<Shape>>[
        //   LineElement(
        //     position: Varset('time') * Varset('points'),
        //     shape: ShapeAttr(value: BasicLineShape(smooth: true)),
        //     size: SizeAttr(value: 2),
        //     color: ColorAttr(value: const Color(0xFF83AA99)),
        //   )
        // ],
        axes: [
          Defaults.horizontalAxis,
          Defaults.verticalAxis,
        ],
        selections: {'tap': PointSelection(dim: Dim.x)},
        tooltip: TooltipGuide(),
        crosshair: CrosshairGuide(),
      ),
    );
  }
}
