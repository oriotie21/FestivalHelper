import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
//import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'QrPage.dart';

class ShowQRWidget extends StatefulWidget {
  const ShowQRWidget({Key? key}) : super(key: key);

  @override
  _ShowQRWidgetState createState() => _ShowQRWidgetState();
}

class _ShowQRWidgetState extends State<ShowQRWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My QR Code',
          style: FlutterFlowTheme.of(context).title2,
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 100,
                height: 500,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child : QrGeneratorForm()
              ),
              /*Padding(
                padding: EdgeInsetsDirectional.fromSTEB(130, 50, 130, 0),
                child: FFButtonWidget(
                  text: 'Refresh',
                  onPressed: () => {},
                  options: FFButtonOptions(
                    width: 130,
                    height: 40,
                    color: Color(0xFFC30E2E),
                    textStyle: FlutterFlowTheme.of(context).subtitle1,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
