import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_chat/auth/auth_gate.dart';
import 'package:emotion_chat/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  //firestore 초기화
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //firestore 샘플 데이터 쓰기 (테스트용)
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  await firestore.collection("cars").doc().set(
    {
      "brand": "Genesis",
      "name": "G80",
      "price": 7000,
    },
  );
  // dev/jaeho : App => ChangeNotifierProvider()
  runApp(ChangeNotifierProvider(
    create: (context) => AuthService(),
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, // dev/jaeho => 추가
        home: AuthGate() // main : Landing(), dev/jaeho : AuthGate()
        );
  }
}
