import 'package:emotion_chat/widgets/navigation/side_drawer.dart';
import 'package:emotion_chat/widgets/navigation/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:emotion_chat/widgets/emotion_button.dart';
import 'package:emotion_chat/widgets/navigation/bottom_menu_bar.dart';

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
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: TopAppBar(titleText: 'Home'),
        ),
        drawer: const SideDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Choose your feelings 🙂',
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
                        emotion: 1,
                        image: Image.asset('images/anxious.png'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
        ),
        bottomNavigationBar: const BottonMenuBar(
          currentIndex: 0,
        ),
      ),
    );
  }
}
