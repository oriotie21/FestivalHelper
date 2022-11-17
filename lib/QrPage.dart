import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:qr_flutter/qr_flutter.dart';

bool _wrongEmail = false;
bool _wrongPassword = false;
class TimerDisplay extends StatefulWidget{
  @override
  createState() => _TimerDisplay();


}
class _TimerDisplay extends State<TimerDisplay>{
  @override
  Widget build(BuildContext context){
    return Padding(padding:
    EdgeInsets.symmetric(vertical: 20),
      child: Text(
        "20 초 동안 유효합니다",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
class LargeTitle extends StatelessWidget {
  String title = "";

  LargeTitle(String s) {
    title = s;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(top: 0, bottom: 40, left: 20, right: 20),
      child: Text(
        title,
        style: TextStyle(fontSize: 50.0),
      ),
    );
  }
}
/*
- 허용할 기기는 여러대지만 정해져 있다.
- 개인키가 사용자 아무도 노출되면 안된다. 다른 기기에서 사용하는걸 방지하기 위함

1. 개인키를 기기마다 다르게 준다. 그리고 시스템폴더에 저장
2. qr코드 인증할때 기기 고유 id까지 인증하면 될듯
 */
class QrGeneratorForm extends StatefulWidget {
  State<QrGeneratorForm> createState() => _QrGeneratorForm();
}

class _QrGeneratorForm extends State<QrGeneratorForm> {
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          QrImage(
            data: '123456',
            size: 260,
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
                        QrGeneratorForm(),
                        TimerDisplay(),
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
