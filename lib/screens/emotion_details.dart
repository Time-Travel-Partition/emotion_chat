import 'package:emotion_chat/service/auth/auth_service.dart';
import 'package:emotion_chat/widgets/emotion_textfield.dart';
import 'package:flutter/material.dart';
import 'package:emotion_chat/widgets/bottom_menu_bar.dart';
import 'package:emotion_chat/widgets/emotion_toggle_buttons.dart';
import 'package:provider/provider.dart';

class EmotionDetails extends StatefulWidget {
  final String emotion;

  const EmotionDetails({
    super.key,
    required this.emotion,
  });

  @override
  State<EmotionDetails> createState() => _EmotionDetailsState();
}

class _EmotionDetailsState extends State<EmotionDetails> {
  late List<bool> _selectedEmotion;

  @override
  void initState() {
    super.initState();

    if (widget.emotion == 'happy') {
      _selectedEmotion = [true, false, false, false];
    } else if (widget.emotion == 'angry') {
      _selectedEmotion = [false, true, false, false];
    } else if (widget.emotion == 'anxious') {
      _selectedEmotion = [false, false, true, false];
    } else if (widget.emotion == 'depressed') {
      _selectedEmotion = [false, false, false, true];
    } else {
      _selectedEmotion = [false, false, false, false];
    }
  }

  void signOut() {
    // get auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
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
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          actions: [
            IconButton(
              onPressed: signOut,
              icon: const Icon(Icons.logout),
            ),
          ],
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EmotionToggleButtons(
                question: '현재 어떤 감정인가요?',
                answers: const ['기쁨', '화남', '불안', '우울'],
                selectedBorderColor: Colors.blue[700],
                fillColor: Colors.blue[200],
                color: Colors.blue[400],
                selectedBtn: _selectedEmotion,
              ),
              EmotionToggleButtons(
                question: '그러한 감정이 얼마나 지속됐나요?',
                answers: const ['1시간', '1일', '2주', '1달 이상'],
                selectedBorderColor: Colors.green[700],
                fillColor: Colors.green[200],
                color: Colors.green[400],
              ),
              EmotionToggleButtons(
                question: '감정의 원인을 아시나요?',
                answers: const ['네', '아니오'],
                selectedBorderColor: Colors.red[700],
                fillColor: Colors.red[200],
                color: Colors.red[400],
              ),
              const EmotionTextField(
                  question: '감정이 일어나게 된 상황에 대해 알려주세요!',
                  hintText: '구체적으로 작성하면 상담에 도움이 됩니다 :)'),
              ElevatedButton(
                onPressed: () {},
                style: const ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.white),
                  backgroundColor: MaterialStatePropertyAll(Colors.blue),
                  elevation: MaterialStatePropertyAll(0),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    '제출',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: const BottonMenuBar(),
      ),
    );
  }
}
