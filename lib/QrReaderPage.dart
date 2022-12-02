import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:enterancemanager/ServerInfo.dart';
import 'package:enterancemanager/UserManager.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:otp/otp.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'MainWidget.dart';

bool _wrongEmail = false;
bool _wrongPassword = false;

class ExampleQrView extends StatefulWidget {
  State<ExampleQrView> createState() => _ExampleQrView();
}

class _ExampleQrView extends State<ExampleQrView> {
  Barcode? result;
  QRViewController? controller;
  String? msg;
  final qrKey = GlobalKey(debugLabel: "QR");

  Widget build(BuildContext context) {

    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery
        .of(context)
        .size
        .width < 400 ||
        MediaQuery
            .of(context)
            .size
            .height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Column(children: [
      SizedBox(
        width: 200,
        height: 200,
        child: QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: scanArea),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),
      ),
    ]);
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      UserCredential user = UserCredential();
      setState(() {
        result = scanData;
      });
      //코드 인증 받아서 0은 실패, 1~는 일반인, 재학생, 이런 순서대로 진행할것
      String? name = await user.getUsername();
      http.Response response = await http.post(
          Uri.parse(ServerInfo.addr+"/otp/auth"),
          headers: {"Content-Type": "application/json"},
          body: json.encode({
        //session : key
        "username": name,
        "otppass": result?.code.toString(),
      }));
      Map<String, dynamic> content = jsonDecode(response.body);
      Logger().v(response.body);
      int id = content["response"];
      setState(() {
        msg = UserCredential.rank.elementAt(id).toString();
      });
    }
    );
  }

void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
  if (!p) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('no Permission')),
    );
  }
}

@override
void dispose() {
  controller?.dispose();
  super.dispose();
}
}

// ignore: must_be_immutable
class QrReaderPage extends StatefulWidget {
  static String id = '/LoginPage';

  @override
  State<QrReaderPage> createState() => _QrReaderPageState();
}

class _QrReaderPageState extends State<QrReaderPage> {
  String email = "";
  String password = "";

  bool _showSpinner = false;

  String emailText = 'Email doesn\'t match';
  String passwordText = 'Password doesn\'t match';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        color: Colors.blueAccent,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset('assets/images/background.png'),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 60.0, bottom: 20.0, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  LargeTitle("입장 티켓"),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //TimerDisplay(),
                        SizedBox(
                          width: 300,
                          height: 300,
                          child: ExampleQrView(),
                        ),
                      ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
