import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:emotion_chat/widgets/emotion_button.dart';

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

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Time Travel',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 0, // 여백을 위해 임시 삽입
            ),
            const Text(
              'Choose your feelings 🙂',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EmotionButton(
                      image: Image.asset('images/happy.png'),
                    ),
                    EmotionButton(
                      image: Image.asset('images/anxious.png'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EmotionButton(
                      image: Image.asset('images/angry.png'),
                    ),
                    EmotionButton(
                      image: Image.asset('images/depressed.png'),
                    ),
                  ],
                ),
              ],
            ),
            BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_rounded,
                    size: 48,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_rounded,
                    size: 48,
                  ),
                  label: 'Profile',
                ),
              ],
              backgroundColor: Colors.blue,
              selectedItemColor: Colors.white,
              showSelectedLabels: false,
              showUnselectedLabels: false,
            ),
          ],
        ),
      ),
    );
  }
}
