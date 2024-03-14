import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  // instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // sign user in
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      // user sign in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // save user info if it doesn't already exist
      _firestore
          .collection("Users")
          .doc(userCredential.user!.uid)
          .set({'uid': userCredential.user!.uid, 'email': email});

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
      // create user
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // save user info in a seperate doc
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code); // 미해결 : 이메일 중복, weak password (예시 pw: test3)
    }
  }

//update user password
  Future<void> updateUserPassword(String newPassword) async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        await user.updatePassword(newPassword);
      } on FirebaseAuthException catch (e) {
        throw Exception(e.code); // 에러 핸들링
      }
    } else {
      throw Exception('No user logged in');
    }
  }

  //send Email verify
  Future<void> signUpTemporaryAndSendEmail(String email) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: "temp-password",
      );
      await userCredential.user!.sendEmailVerification();

      if (userCredential.user != null) {
        // emailVerified : false
      }
    } on FirebaseAuthException catch (error) {
      String? errorCode;
      switch (error.code) {
        case "email-already-in-use":
          errorCode = error.code;
          break;
        case "invalid-email":
          errorCode = error.code;
          break;
        case "weak-password":
          errorCode = error.code;
          break;
        case "operation-not-allowed":
          errorCode = error.code;
          break;
        default:
          errorCode = null;
      }
    }
  }

  // sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }
  // errors
}
