import 'dart:convert';

import 'package:logger/logger.dart';

import 'httprequest.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  TextEditingController? confirmPasswordTextController;

  late bool passwordVisibility2;
  TextEditingController? fullNameController;
  TextEditingController? passwordTextController;
  TextEditingController? studentNameController;
  TextEditingController? studentPasswordController;

  late bool passwordVisibility1;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool checkboxValue = false; //지인인지 아닌지

  @override
  void initState() {
    super.initState();
    confirmPasswordTextController = TextEditingController();
    passwordVisibility2 = false;
    fullNameController = TextEditingController();
    passwordTextController = TextEditingController();
    studentNameController = TextEditingController();
    studentPasswordController = TextEditingController();
    passwordVisibility1 = false;
  }

  @override
  void dispose() {
    confirmPasswordTextController?.dispose();
    fullNameController?.dispose();
    passwordTextController?.dispose();
    studentNameController?.dispose();
    studentPasswordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).lineColor,
      body: SingleChildScrollView(
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
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: Text(
                "-- 기본 정보 --",
                style: FlutterFlowTheme.of(context).title3,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 36),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextFormField(
                          controller: fullNameController,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Enter your name here...',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    FlutterFlowTheme.of(context).tertiaryColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    FlutterFlowTheme.of(context).tertiaryColor,
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
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              ?.override(
                                fontFamily: 'Outfit',
                                color: FlutterFlowTheme.of(context).lineColor,
                              ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: TextFormField(
                            controller: passwordTextController,
                            obscureText: !passwordVisibility1,
                            decoration: InputDecoration(
                              hintText: 'Enter your password here...',
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
                              fillColor:
                                  FlutterFlowTheme.of(context).tertiaryColor,
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => passwordVisibility1 =
                                      !passwordVisibility1,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  passwordVisibility1
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Color(0x80FFFFFF),
                                  size: 22,
                                ),
                              ),
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                ?.override(
                                  fontFamily: 'Outfit',
                                  color: FlutterFlowTheme.of(context).lineColor,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: TextFormField(
                            controller: confirmPasswordTextController,
                            obscureText: !passwordVisibility2,
                            decoration: InputDecoration(
                              hintText: 'Confirm password here...',
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
                              fillColor:
                                  FlutterFlowTheme.of(context).tertiaryColor,
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => passwordVisibility2 =
                                      !passwordVisibility2,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  passwordVisibility2
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Color(0x80FFFFFF),
                                  size: 22,
                                ),
                              ),
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                ?.override(
                                  fontFamily: 'Outfit',
                                  color: FlutterFlowTheme.of(context).lineColor,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Text(
                            "-- 재학생 / 지인 인증 --",
                            style: FlutterFlowTheme.of(context).title3,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: TextFormField(
                            controller: studentNameController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: '학사정보시스템 ID',
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
                              fillColor:
                                  FlutterFlowTheme.of(context).tertiaryColor,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                ?.override(
                                  fontFamily: 'Outfit',
                                  color: FlutterFlowTheme.of(context).lineColor,
                                ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: TextFormField(
                            controller: studentPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: '학사정보 시스템 비밀번호',
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
                              fillColor:
                                  FlutterFlowTheme.of(context).tertiaryColor,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                ?.override(
                                  fontFamily: 'Outfit',
                                  color: FlutterFlowTheme.of(context).lineColor,
                                ),
                            keyboardType: TextInputType.visiblePassword,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Theme(
                              data: ThemeData(
                                checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                unselectedWidgetColor: Color(0xFFF5F5F5),
                              ),
                              child: Checkbox(
                                value: checkboxValue ??= true,
                                onChanged: (newValue) async {
                                  setState(() => checkboxValue = newValue!);
                                },
                                activeColor:
                                    FlutterFlowTheme.of(context).primaryColor,
                              ),
                            ),
                            Text(
                              '재학생의 지인입니다',
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              int permission = 1;
                              if ((fullNameController?.text)!.isEmpty ||
                                  (passwordTextController?.text)!.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("기본 정보를 모두 입력해주세요")));
                                return;
                              }
                              HttpRequest req = HttpRequest();
                              if (!(studentNameController?.text?.isEmpty)! ||
                                  !(studentPasswordController
                                      ?.text?.isEmpty)!) {
                                //학사정보 시스템 인증 시도
                                Map<String, String> reqBody =
                                    Map<String, String>();
                                reqBody["student_id"] =
                                    (studentNameController?.text.toString())!;
                                reqBody["password"] = (studentPasswordController
                                    ?.text
                                    .toString())!;
                                http.Response resp = await req.sendPostRequest(
                                    "/api/user/authsejong", reqBody);
                                if(jsonDecode(resp.body)['student_id'] == null){
                                  Map<String, dynamic> msgdata =
                                      jsonDecode(resp.body);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("재학생 인증 실패")));
                                  return;
                                  }
                                //인증 성공
                                permission += 1;
                                if (checkboxValue == false) {
                                  permission += 1;
                                }
                              }
                              //가입 정보 전송ㅁㄴㅇㄹ
                              Map<String, dynamic> reqBody =
                                  Map<String, dynamic>();
                              reqBody["username"]=fullNameController?.text;
                              reqBody["password1"]=passwordTextController?.text;
                              reqBody["password2"]=passwordTextController?.text;
                              reqBody["student_id"]=studentNameController?.text;
                              //name 나중에 추가, 오류 고치면
                              reqBody["name"]=fullNameController?.text;
                              reqBody["permission"]=permission;
                              http.Response resp = await req.sendPostRequest("/api/user/", reqBody);
                              Logger().v(resp.body);

                              Navigator.pop(context);
                            },
                            text: 'Create Account',
                            options: FFButtonOptions(
                              width: 200,
                              height: 50,
                              color: Color(0xFFC30E2E),
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  ?.override(
                                    fontFamily: 'Outfit',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 6),
                            child: Text(
                              'Do you have account? ',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  ?.override(
                                    fontFamily: 'Outfit',
                                    color: FlutterFlowTheme.of(context).darkBG,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 200),
                                    reverseDuration:
                                        Duration(milliseconds: 200),
                                    child: LoginWidget(),
                                  ),
                                );
                              },
                              text: 'Login',
                              options: FFButtonOptions(
                                width: 80,
                                height: 30,
                                color: Color(0xFFC30E2E),
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    ?.override(
                                      fontFamily: 'Outfit',
                                      color: Colors.white,
                                    ),
                                elevation: 0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
