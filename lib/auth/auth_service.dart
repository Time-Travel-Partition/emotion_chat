import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  // instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign user in
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      // sign in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    }
    // catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign up
  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code); // 미해결 : 이메일 중복, weak password (예시 pw: test3)
    }
  }

  // sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }
  // errors
}
