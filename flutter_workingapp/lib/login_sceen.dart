import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'firebase_options.dart';
import 'home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const login_App());
}

class login_App extends StatelessWidget {
  const login_App({Key? key}) : super(key: key);

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
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
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
        Container(
          width: 200,
          height: 55,
          margin: const EdgeInsets.only(top: 120),
          child: ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.authStateChanges().listen((User? user) {
                  if (user == null) {
                    // 유저 정보가 없으면 로그인 시도
                    print("유저정보없음");
                    // signInWithGoogle();
                  } else {
                    // 있으면 다음 화면으로 이동
                    print("유저정보있음");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  primary: Colors.blue.shade100),
              child: const Text("구글 아이디로 로그인하기",
                  style: TextStyle(color: Colors.black87))),
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
