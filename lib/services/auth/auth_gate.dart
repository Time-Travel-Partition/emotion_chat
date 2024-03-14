import 'package:emotion_chat/services/auth/login_or_register.dart';
import 'package:emotion_chat/screens/main/home_tab/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        //stream is gonna be listen to any auth changes
        //check if the user is logged in or not
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            User? user = snapshot.data; // User 객체에 대한 참조를 가져옴

            // User 객체가 존재하고, 이메일 인증이 완료되었는지 확인
            if (user != null && user.emailVerified) {
              // 이메일 인증을 완료했다면 Home으로 이동
              return const Home();
            } else {
              // 사용자가 인증버튼은 눌렀지만 이메일 인증을 완료하지 않았다면,
              // 이메일 인증 안내 화면이나 로그인/등록 화면으로 이동
              return const LoginOrRegister();
            }
          } else {
            // 사용자가 로그인하지 않았다면 로그인/등록 화면으로 이동
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
