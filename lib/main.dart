import 'dart:developer';

import 'package:dart_openai/dart_openai.dart';
import 'package:emotion_chat/env/env.dart';
import 'package:emotion_chat/services/auth/auth_gate.dart';
import 'package:emotion_chat/services/auth/auth_service.dart';
import 'package:emotion_chat/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  OpenAI.apiKey = Env.apiKey;

  // Assistant에게 대화의 방향성을 알려주는 메시지
  final systemMessage = OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        "You're a psychological consultant.",
      ),
    ],
    role: OpenAIChatMessageRole.system,
  );

  // 사용자가 보내는 메시지
  final userMessage = OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        '안녕? 나는 조금 우울해. :(',
      ),
    ],
    role: OpenAIChatMessageRole.user,
  );

  final requestMessages = [
    systemMessage,
    userMessage,
  ];

  OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
    model: 'gpt-3.5-turbo',
    messages: requestMessages,
    maxTokens: 250,
  );

  log(chatCompletion.choices.first.message.toString());
  log(chatCompletion.systemFingerprint.toString());
  log(chatCompletion.usage.promptTokens.toString());
  log(chatCompletion.id.toString());
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
