import 'dart:convert';

import 'package:enterancemanager/QrPage.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

bool _wrongEmail = false;
bool _wrongPassword = false;

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  static String id = '/LoginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String userID = "";
  String password = "";

  bool _showSpinner = false;

  String emailText = 'Email doesn\'t match';
  String passwordText = 'Password doesn\'t match';
  void processLogin() async{
      http.Response response = await http.get(Uri.parse("http://192.168.5.130:8000/otp/key?name="+userID));
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('otpkey', jsonData["key"]);
      Navigator.push(context, MaterialPageRoute(builder: (context) => QrPage(),),);
  }
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "로그인",
                    style: TextStyle(fontSize: 50.0),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "세종대학교 축제에",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        '오신 것을',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        '환영합니다',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          userID = value;
                        },
                        decoration: InputDecoration(
                          hintText: '아이디',
                          labelText: '아이디',
                          errorText: _wrongEmail ? emailText : null,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                          hintText: '비밀번호',
                          labelText: '비밀번호',
                          errorText: _wrongPassword ? passwordText : null,
                        ),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 10.0)),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xff447def)),
                    ),
                    onPressed: processLogin,
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          height: 1.0,
                          width: 60.0,
                          color: Colors.black87,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '아직 회원가입을',
                            style: TextStyle(fontSize: 15.0),
                          ),Text(
                            '하지 않으셨다면?',
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          height: 1.0,
                          width: 60.0,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff39bfe8)),
                      ),
                      onPressed: () async {},
                      child: Text(
                        '회원가입',
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
