import 'package:flutter/material.dart';
import 'package:emotion_chat/screens/home.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

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
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const Home()));
              },
              child: const Text('To Home')),
        ),
      ),
    );
  }
}
