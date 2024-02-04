import 'package:emotion_chat/auth/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:emotion_chat/screens/home.dart';

// 빠른 개발을 위한 관리자 전용 화면 (임시)
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const Home()));
                },
                child: const Text('To Home'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AuthGate()));
                },
                child: const Text('To Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
