import 'package:emotion_chat/services/auth/auth_gate.dart';
import 'package:emotion_chat/services/auth/auth_service.dart';
import 'package:emotion_chat/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  //firestore 초기화
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // dev/jaeho : App => ChangeNotifierProvider()
  runApp(ChangeNotifierProvider(
    create: (context) => AuthService(),
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 바깥을 터치하면 키보드 닫음
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        theme: lightMode,
        debugShowCheckedModeBanner: false, // dev/jaeho => 추가
        home: const AuthGate(),
      ),
    );
  }
}
