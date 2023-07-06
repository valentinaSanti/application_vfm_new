import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color backcolor = Color.fromARGB(255, 199, 237, 163);
  static const Color spacer = Colors.transparent;
  static const String fontName = 'WorkSans';
  static const Color iconcolor = Color.fromARGB(255, 120, 158, 85);
  static const Color backhome = Color.fromARGB(255, 171, 235, 167);
  static const Color graficvalue = Color.fromARGB(255, 215, 137, 27);
  static const Color writegeneral = Colors.orange;
  static const Color titles = Color.fromARGB(255, 215, 137, 27);
  static const Color widgetcolor = Color.fromRGBO(233, 233, 233, 0.6);
  static const Color widgetbasecolor = Color(0xFF253840);
  static const Color icone = Color.fromARGB(255, 19, 106, 1);

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkText,
  );

  static const TextStyle impacttext =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  static const TextStyle impacthidentext =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black);
}
