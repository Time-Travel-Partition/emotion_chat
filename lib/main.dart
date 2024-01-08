import 'package:flutter/material.dart';

void main() {
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
