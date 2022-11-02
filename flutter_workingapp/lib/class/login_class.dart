import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_workingapp/login_platform.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginClass {
  bool checkLogin = false;

  LoginClass();

  // 구글 로그인 관련
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

  // 네이버 로그인 처리하는 함수
  void signInWithNaver() async {
    final NaverLoginResult result = await FlutterNaverLogin.logIn();
    if (result.status == NaverLoginStatus.loggedIn) {
      print('accessToken = ${result.accessToken}');
      print('id = ${result.account.id}');
      print('email = ${result.account.email}');
      print('name = ${result.account.name}');
    }
  }

  // 로그인 상태 체크
  auth(LoginPlatform loginPlatform) {
    // 사용자 인증정보 확인. 딜레이를 두어 확인
    Future.delayed(const Duration(milliseconds: 100), () {
      switch (loginPlatform) {
        case LoginPlatform.google:

          // 구글 로그인 확인 후 리턴
          break;
        case LoginPlatform.naver:
          // 네이버 로그인 확인 후 리턴
          break;
        case LoginPlatform.kakao:
          // 카카오 로그인 확인 후 리턴
          break;
        case LoginPlatform.none:
          // 로그인 하라는 토스트 같은 메시지 띄우기

          break;
      }
      // if (FirebaseAuth.instance.currentUser == null) {
      //   Get.off(() => const LoginPage());
      // } else {
      //   Get.off(() => const MarketPage());
      // }
    });
  }
}
