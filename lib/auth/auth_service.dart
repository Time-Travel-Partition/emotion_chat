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

  // sign out
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
  // errors
}
