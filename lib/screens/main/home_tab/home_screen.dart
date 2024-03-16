import 'package:emotion_chat/widgets/navigation/side_drawer.dart';
import 'package:emotion_chat/widgets/navigation/top_app_bar.dart';
import 'package:emotion_chat/widgets/navigation/bottom_menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:emotion_chat/widgets/button/emotion_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: TopAppBar(titleText: 'Home'),
      ),
      drawer: const SideDrawer(),
      bottomNavigationBar: const BottonMenuBar(
        currentIndex: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              '현재의 감정을 선택하세요 🙂',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    EmotionButton(
                      emotion: 0,
                      image: Image.asset('images/happy.png'),
                    ),
                    EmotionButton(
                      emotion: 2,
                      image: Image.asset('images/anxious.png'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    EmotionButton(
                      emotion: 1,
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
      ),
    );
  }
}
