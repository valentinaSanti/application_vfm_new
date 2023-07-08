import 'package:application_vfm_new/app_general_theme.dart';
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
      width: 350, 
      height: 300,
      child: Chart(
        rebuild: true,
        data: data,
        variables: {
          'time': Variable(
            accessor: (Map map) => map['date'] as String,
            scale: OrdinalScale(tickCount: 5),
          ),
          'distance': Variable(
            accessor: (Map map) => map['points'] as num,
          ),
        },
        elements: [
          IntervalElement(
            position: Varset('time') * Varset('distance'),
            size: SizeAttr(value: 2),
            color: ColorAttr(value: AppTheme.writegeneral),
          )
        ],
       
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
