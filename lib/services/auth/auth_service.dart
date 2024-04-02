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
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set({'uid': userCredential.user!.uid, 'email': email});

      return userCredential;
    }
    // catch any errors
    on FirebaseAuthException catch (error) {
      print('Error code: ${error.code}'); // 에러 코드 로깅
      // 예외에 따른 에러 코드 할당
      String errorMessage;

      switch (error.code) {
        case 'user-not-found':
          errorMessage = '가입되지 않은 이메일입니다.';
          break;
        case 'wrong-password':
          errorMessage = '잘못된 비밀번호입니다.';
          break;
        case 'network-request-failed':
          errorMessage = '네트워크 연결에 실패하였습니다.';
          break;
        case 'invalid-email':
          errorMessage = '잘못된 이메일 형식입니다.';
          break;
        case 'internal-error':
          errorMessage = '잘못된 요청입니다.';
          break;
        default:
          errorMessage = '로그인에 실패하였습니다.';
      }
      // 예외 메시지를 포함해 예외를 다시 던짐
      throw FirebaseAuthException(code: error.code, message: errorMessage);
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
      _firestore.collection('Users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      return userCredential;
    } on FirebaseAuthException catch (error) {
      print('Error code: ${error.code}'); // 에러 코드 로깅
      // 예외에 따른 에러 코드 할당
      String errorMessage;

      switch (error.code) {
        case 'email-already-in-use':
          errorMessage = '이미 사용 중인 이메일입니다.';
        case 'weak-password':
          errorMessage = '비밀번호는 6글자 이상이어야 합니다.';
        case 'network-request-failed':
          errorMessage = '네트워크 연결에 실패하였습니다.';
        case 'invalid-email':
          errorMessage = '잘못된 이메일 형식입니다.';
        case 'internal-error':
          errorMessage = '잘못된 요청입니다.';
        default:
          errorMessage = '회원가입 중 오류가 발생했습니다.';
      }
      throw FirebaseAuthException(code: error.code, message: errorMessage);
    }
  }

  // sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }
  // errors
}
