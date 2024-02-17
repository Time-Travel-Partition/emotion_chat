import 'package:emotion_chat/widgets/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:emotion_chat/widgets/emotion_button.dart';
import 'package:emotion_chat/widgets/bottom_menu_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
        ),
        drawer: const HomeDrawer(),
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
                      emotion: 0,
                      image: Image.asset('images/happy.png'),
                    ),
                    EmotionButton(
                      emotion: 1,
                      image: Image.asset('images/anxious.png'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EmotionButton(
                      emotion: 2,
                      image: Image.asset('images/angry.png'),
                    ),
                    EmotionButton(
                      emotion: 3,
                      image: Image.asset('images/depressed.png'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: const BottonMenuBar(
          currentIndex: 0,
        ),
      ),
    );
  }
}
