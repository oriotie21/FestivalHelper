import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'app_theme.dart';

class LargeTitle extends StatelessWidget{
  String title = "";
  LargeTitle(String t){
    title = t;
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      alignment : Alignment.centerLeft,
      child:
        Padding(
            padding: EdgeInsets.only(left: 30, right: 30, top: 80, bottom: 80),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline2,
            )
        ),
    );
  }

}
class NormalButton extends StatelessWidget{
  String title = "";
  Color backgroundColor = Colors.white;
  NormalButton(String t, Color c){
    title = t;
    backgroundColor = c;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Center(
        child: Container(
          width: 300,
          height: 50,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius:
            const BorderRadius.all(Radius.circular(4.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  offset: const Offset(4, 4),
                  blurRadius: 8.0),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
class NormalInputForm extends StatefulWidget{
  String title = "";
  NormalInputForm(String t){
    title = t;
  }
  createState () => _NormalInputForm();
}

class _NormalInputForm extends State<NormalInputForm>{
  @override
  Widget build(BuildContext context) {
    return
    Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 4),
      child : Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              offset: const Offset(4, 4),
              blurRadius: 4),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          padding: const EdgeInsets.all(4.0),
          constraints: const BoxConstraints(minHeight: 60, maxHeight: 60),
          color: AppTheme.white,
          child: SingleChildScrollView(
            padding:
            const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
            child: TextField(
              maxLines: null,
              onChanged: (String txt) {},
              style: TextStyle(
                fontFamily: AppTheme.fontName,
                fontSize: 20,
                color: AppTheme.dark_grey,
              ),
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.title),
            ),
          ),
        ),
      ),
    ),
    );

  }

}
class LoginForm extends StatefulWidget{
  createState() => _LoginForm();
}
class _LoginForm extends State<LoginForm>{
  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Padding(
          padding: EdgeInsets.only(top: 40, bottom: 40),
          child : Column(
          children : [
            NormalInputForm("학번"),
            NormalInputForm("비밀번호"),
          ],
          )
        ),

        NormalButton("로그인", Colors.blue),
        NormalButton("회원가입", Colors.blue)
      ],
    );

  }


}
class LoginPage2 extends StatelessWidget{

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("로그인"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LargeTitle("로그인"),
            LoginForm(),
          ],
        ),

    ),

    );
  }

}