import 'package:flutter/material.dart';

class FlutterFlowIconButton extends StatelessWidget {
  Color? borderColor;
  int? borderRadius;
  int? borderWidth;
  int? buttonSize;
  Icon? icon;
  void Function()? onPressed;
  FlutterFlowIconButton({
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.icon,
    this.buttonSize,
    required void Function()? this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: borderColor,
      onPressed: onPressed,
      child: icon,

    );
    throw UnimplementedError();
  }
}
