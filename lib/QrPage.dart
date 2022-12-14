import 'dart:async';
import 'dart:convert';

import 'package:enterancemanager/UserManager.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:otp/otp.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'MainWidget.dart';

bool _wrongEmail = false;
bool _wrongPassword = false;

class TestInputWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestInputWidget();
}

class _TestInputWidget extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Debug Input"),
          SizedBox(
            width: 80,
            child: TextField(
              obscureText: true,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                // password = value;
              },
              decoration: InputDecoration(
                hintText: 'Value',
                //errorText: _wrongPassword ? passwordText : null,
              ),
            ),
          ),
          SizedBox(
            width: 50,
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 20.0)),
                backgroundColor: MaterialStateProperty.all(Color(0xff447def)),
              ),
              onPressed: () => {},
              child: Text(
                'Set',
                style: TextStyle(fontSize: 10.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimerDisplay extends StatefulWidget {
  @override
  createState() => _TimerDisplay();
}

class _TimerDisplay extends State<TimerDisplay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        "?????? ?????? : 00 ???",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}



/*
- ????????? ????????? ??????????????? ????????? ??????.
- ???????????? ????????? ????????? ???????????? ?????????. ?????? ???????????? ??????????????? ???????????? ??????

1. ???????????? ???????????? ????????? ??????. ????????? ?????????????????? ??????
2. qr?????? ???????????? ?????? ?????? id?????? ???????????? ??????
 */
class QrGeneratorForm extends StatefulWidget {
  State<QrGeneratorForm> createState() => _QrGeneratorForm();
}

class _QrGeneratorForm extends State<QrGeneratorForm> {
  //List<QrImage> qrImage = [];
  int REFRESH_RATE = 30;
  int KEY_TIME = 0;
  String OTPPass = "";
  String QrData = "";
  int remainTime = 0;
  String? username = "";
  late Timer timer;
  bool isRunning = false;
  int currentMillis = 0;
  _QrGeneratorForm() {
      loadOTP();
  }

  void loadOTP() async {
    username = await UserCredential().getUsername();
    //if (timer.isActive) {
    //  timer?.cancel();
   // }
    if(isRunning){
      timer.cancel();
      isRunning = false;
    }
    currentMillis = DateTime.now().millisecondsSinceEpoch;
    remainTime = REFRESH_RATE - ((currentMillis ~/ 1000) % REFRESH_RATE); //30??? ?????? ??? ?????????
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (remainTime > 0) {
          isRunning = true;
      setState(() {
        remainTime -= 1;
      });
        } else {
          setState(() {
            timer?.cancel();
            isRunning = false;
            loadOTP(); 
          });
        }
      });
   // String name = "sejong";
   // http.Response response = await http
   //     .get(Uri.parse("http://192.168.5.130:8000/otp/key?name=" + name));
   // Map<String, dynamic> jsonData = jsonDecode(response.body);
    //????????? 5??? ??????
    KEY_TIME = currentMillis;
    final prefs = await SharedPreferences.getInstance();
    OTPPass = OTP.generateTOTPCodeString(prefs.getString("otpkey").toString(), KEY_TIME,interval: REFRESH_RATE,  algorithm: Algorithm.SHA256, isGoogle: true );
    //QR ????????? ??????
    Map<String, dynamic> qrjsonData = Map<String, dynamic>();
    qrjsonData['username'] = username;
    qrjsonData['otppass'] = OTPPass;
    setState(() {
      QrData = jsonEncode(qrjsonData);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Padding(
        //5??? ????????? ?????? ??????
        // ?????? ?????? : ???????????? ?????? ??????(qr??? ?????? ?????? ?????????????????? json?????? ?????????), ????????? ???????????? ???????????? ?????? ????????? ?????????
        //???????????? ?????? ??? otp ??? ????????? ?????? ???????????? ??????
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          QrImage(
            data: QrData,
            size: 260,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "?????? ?????? : $remainTime ???",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*
                    SizedBox(
                      width: 100,
                      height: 60,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(vertical: 20.0)),
                          backgroundColor: MaterialStateProperty.all(Color(0xff447def)),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          '????????????',
                          style: TextStyle(fontSize: 15.0, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ), // ??? ?????? ?????? ?????? ??????
                    SizedBox(
                      width: 100,
                      height: 60,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(vertical: 20.0)),
                          backgroundColor: MaterialStateProperty.all(Color(0xff447def)),
                        ),
                        onPressed: loadOTP,
                        child: Text(
                          '?????? ?????????',
                          style: TextStyle(fontSize: 15.0, color: Colors.white),
                        ),
                      ),
                    ),

                     */
                  ],
                )
            ,
          ),
        ]));
  }
}

// ignore: must_be_immutable
class QrPage extends StatefulWidget {
  static String id = '/LoginPage';

  @override
  _QrPageState createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
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
                  LargeTitle("?????? ??????"),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        QrGeneratorForm(),
                        //TimerDisplay(),
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
