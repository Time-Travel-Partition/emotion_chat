import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...

void main() async {
  //firestore 초기화
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //firestore 샘플 데이터 쓰기 (테스트용)
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  await _firestore.collection("cars").doc().set(
    {
      "brand": "Genesis",
      "name": "G80",
      "price": 7000,
    },
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Time Travel'),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
        ),
        body: const Center(
          child: Text('감정을 선택해주세요!'),
        ),
      ),
    );
  }
}
