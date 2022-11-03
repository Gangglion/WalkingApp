import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_workingapp/class/login_class.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'widget/outline_circle_button.dart';
import 'home_page.dart';
import 'package:flutter_workingapp/login_platform.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  runApp(const AppStart());
}

class AppStart extends StatelessWidget {
  const AppStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 로그인한 플랫폼 저장 enum
  LoginPlatform loginPlatform = LoginPlatform.none;
  // 로그인 관련 클래스 생성
  LoginClass loginObj = LoginClass();
  @override
  void initState() {
    super.initState();
    loginObj.auth(loginPlatform);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          width: 1000,
          margin: const EdgeInsets.only(left: 40, top: 100),
          child: Text("Let's Walk!",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 45,
                  color: Colors.teal.shade800,
                  fontWeight: FontWeight.bold)),
        ),
        Container(
          width: 1000,
          margin: const EdgeInsets.only(top: 20, right: 60),
          child: Text("함께 산책해요!!",
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 30, color: Colors.teal.shade800)),
        ),
        Container(
            margin: const EdgeInsets.only(top: 80),
            child: Text("로그인 하고 활동을 기록하세요!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.teal.shade600))),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 150, right: 20),
              child: OutlineCircleButton(
                  radius: 60.0,
                  borderSize: 0.5,
                  onTap: () async {
                    print("구글 로그인");
                    loginObj.signInWithGoogle();
                    setState(() {
                      loginPlatform = LoginPlatform.google;
                    });
                  },
                  child: Image.asset("images/icon/google.png")),
            ),
            Container(
              margin: const EdgeInsets.only(top: 150, right: 20),
              child: OutlineCircleButton(
                  radius: 60.0,
                  borderSize: 0.5,
                  onTap: () async {
                    print("네이버 로그인");
                    loginObj.signInWithNaver();
                    setState(() {
                      loginPlatform = LoginPlatform.naver;
                    });
                  },
                  child: Image.asset("images/icon/naver.png")),
            ),
            Container(
              margin: const EdgeInsets.only(top: 150),
              child: OutlineCircleButton(
                  radius: 60.0,
                  borderSize: 0.5,
                  onTap: () async {
                    print("카카오 로그인");
                  },
                  child: Image.asset("images/icon/kakao.png")),
            ),
          ],
        ),
        Container(
          width: 200,
          height: 55,
          margin: const EdgeInsets.only(top: 30),
          child: ElevatedButton(
            onPressed: () {
              // 메인 화면으로 넘어감
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                primary: Colors.blue.shade100),
            child: const Text("로그인 없이 바로 시작하기!",
                style: TextStyle(color: Colors.black87)),
          ),
        ),
      ],
    ));
  }
}
