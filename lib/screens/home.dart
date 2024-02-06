import 'package:flutter/material.dart';
import 'package:emotion_chat/widgets/emotion_button.dart';
import 'package:emotion_chat/widgets/bottom_menu_bar.dart';
import 'package:emotion_chat/auth/auth_service.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void signOut() {
    // get auth service
    // final authService = Provider.of<AuthService>(context, listen: false);
    // authService.signOut();
    final auth = AuthService();
    auth.signOut();
  }

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
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   icon: const Icon(Icons.arrow_back_rounded),
          // ),
          actions: [
            IconButton(
              onPressed: signOut,
              icon: const Icon(Icons.logout),
            ),
          ],
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
