import 'package:flutter/material.dart';
import 'package:emotion_chat/widgets/emotion_button.dart';
import 'package:emotion_chat/widgets/bottom_menu_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Choose your feelings 🙂',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 80, // 여백
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
          ],
        ),
        bottomNavigationBar: const BottonMenuBar(),
      ),
    );
  }
}
