// TODO Implement this library.

import 'package:flutter/material.dart';
import 'package:flutter_custom_theme/flutter_custom_theme.dart';

class FlutterFlowTheme extends CustomThemeData {
  static FlutterFlowTheme of(BuildContext context) =>
      CustomThemes.safeOf(context, mainDefault: FlutterFlowTheme());

  static String mainFont = 'Outfit';
  Color primaryBackground = Color(0xFF42bea5);
  Color tertiaryColor = Color(0xFFE86969);
  Color white = Colors.white;
  Color secondaryBackground = Color(0xFFFFFFFF);
  Color lineColor = Color(0xFFdbe2a7);

  TextStyle? title2 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    fontFamily: mainFont,
  );
  TextStyle? subtitle1 = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 18,
      fontFamily: mainFont);
  TextStyle? subtitle2 = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      fontFamily: mainFont);
  TextStyle? bodyText1 = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize : 14,
      fontFamily : mainFont);

}
