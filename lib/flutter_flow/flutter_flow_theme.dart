// TODO Implement this library.

import 'package:flutter/material.dart';
import 'package:flutter_custom_theme/flutter_custom_theme.dart';

class OverridableTextStyle extends TextStyle{
  FontWeight? fontWeight;
  double? fontSize;
  String? fontFamily;
  Color? color;
  TextStyle override({String? fontFamily,FontWeight? fontWeight, Color? color, double? fontSize }){
    this.fontFamily = fontFamily;
    this.fontSize = fontSize;
    this.fontWeight = fontWeight;
    this.color = color;
    return this;
  }
  OverridableTextStyle({
    this.fontWeight,
    this.fontSize,
    this.fontFamily,
    this.color,
  })  :
        super(
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: fontFamily,
        color: color,
      );


}
class FlutterFlowTheme extends CustomThemeData {
  static FlutterFlowTheme of(BuildContext context) =>
      CustomThemes.safeOf(context, mainDefault: FlutterFlowTheme());



  static String mainFont = 'Outfit';
  static String messageFont = 'NanumGodic';
  Color primaryBackground = Color(0xffffffff);
  Color primaryBlack = Color(0xff131619);
  Color primaryColor = Color(0xff42Bea5);
  Color primaryText = Color(0xff1a1f24);
  Color tertiaryColor = Color(0xFFE86969);
  Color white = Colors.white;
  Color secondaryBackground = Color(0xFFFFFFFF);
  Color alternateColor = Color(0xFF262D34);
  Color darkBG = Color(0xff1a1f24);
  Color lineColor = Color(0xFFdbe2a7);
  OverridableTextStyle? title1 = OverridableTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 34,
    fontFamily: mainFont,
  );
  OverridableTextStyle? title2 = OverridableTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    fontFamily: mainFont,
  );
  OverridableTextStyle? title3 = OverridableTextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    fontFamily: mainFont,
  );
  OverridableTextStyle? subtitle1 = OverridableTextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 18,
      fontFamily: mainFont);
  OverridableTextStyle? subtitle2 = OverridableTextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      fontFamily: mainFont);
  OverridableTextStyle? bodyText1 = OverridableTextStyle(
      fontWeight: FontWeight.normal,
      fontSize : 14,
      fontFamily : mainFont);

}
