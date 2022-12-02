//import '../auth/auth_util.dart';
import 'dart:convert';

import 'package:enterancemanager/httprequest.dart';
import 'package:logger/logger.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../flutter_flow/flutter_flow_theme.dart';

//import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';

//import '../manage_register/manage_register_widget.dart';
//import '../register/register_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ServerInfo.dart';
import 'UserManager.dart';
import 'home.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController? emailTextController;
  TextEditingController? passwordTextController;

  late bool passwordVisibility;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String userID = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController(); //유저 이름, 실제로는 이메일 아님
    passwordTextController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  void dispose() {
    emailTextController?.dispose();
    passwordTextController?.dispose();
    super.dispose();
  }

  void processLogin() async{
    //로그인 성공 여부 판단
    http.Response loginResult = await http.post(Uri.parse(ServerInfo.addr+"/api/user/login"), headers: {"Content-Type" : "application/x-www-form-urlencoded"}, body: "username="+userID+"&password="+password);
    if(loginResult.statusCode  != 200){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("로그인에 실패했습니다"))
      );
      return;
    }
    
    UserCredential user = UserCredential();
    //예외처리 필요!
    HttpRequest req = await HttpRequest();
    //otp key 저장
    http.Response resp = await req.sendGetRequest( "/api/otp/key", {"name":userID});
    Map<String, dynamic> jsonData = jsonDecode(resp.body);
    final prefs = await SharedPreferences.getInstance();
    if(resp.statusCode == 200) {
      user.setOtpKey(jsonData["key"]);
    }
    Map<String, dynamic> clientData = jsonData;
    user.setUsername(clientData["username"]);
    user.setAccessToken(clientData["access_token"]);
    user.setTokenType(clientData["token_type"]);
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageWidget(),),);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).lineColor,
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.always,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 50),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Image.asset(
                        'assets/images/sejong_transparent.png',
                        width: 150,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TextFormField(
                              controller: emailTextController,
                              obscureText: false,
                              onChanged: (value){userID = value;},
                              decoration: InputDecoration(
                                hintText: '아이디',
                                hintStyle: FlutterFlowTheme.of(context).bodyText1,

                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).tertiaryColor as Color,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).tertiaryColor as Color,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor:
                                    FlutterFlowTheme.of(context).tertiaryColor,
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: FlutterFlowTheme.of(context).lineColor,
                                ),
                              ),
                              style: FlutterFlowTheme.of(context).bodyText1,
                              keyboardType: TextInputType.name,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                              child: TextFormField(
                                controller: passwordTextController,
                                obscureText: !passwordVisibility,
                                onChanged: (value) {password = value;},
                                decoration: InputDecoration(
                                  hintText: '비밀번호',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .bodyText1,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .tertiaryColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .tertiaryColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .tertiaryColor,
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color:
                                        FlutterFlowTheme.of(context).lineColor,
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                      () => passwordVisibility =
                                          !passwordVisibility,
                                    ),
                                    focusNode: FocusNode(skipTraversal: true),
                                    child: Icon(
                                      passwordVisibility
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Color(0x80FFFFFF),
                                      size: 22,
                                    ),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                                validator: (val) {

                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                              child: FFButtonWidget(
                                onPressed: processLogin,

                                text: 'Login',
                                options: FFButtonOptions(
                                  width: 200,
                                  height: 50,
                                  color: Color(0xFFC30E2E),
                                  textStyle: FlutterFlowTheme.of(context).subtitle2,
                                  elevation: 3,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
