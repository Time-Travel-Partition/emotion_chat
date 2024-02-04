import 'package:emotion_chat/auth/login_or_register.dart';
import 'package:emotion_chat/main.dart';
import 'package:emotion_chat/pages/Logout_Page.dart';
import 'package:emotion_chat/screens/landing.dart';
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
            return const LogoutPage();
          }

          // user is not logged in
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
