import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Home extends StatefulWidget {
  static const route = '/home/';
  static const routeDisplayName = 'HomePage';

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
