import 'package:emotion_chat/screens/main/chat_tab/chat_screen.dart';
import 'package:emotion_chat/services/auth/auth_service.dart';
import 'package:emotion_chat/widgets/textfield/emotion_textfield.dart';
import 'package:emotion_chat/widgets/modal/confirm_alert.dart';
import 'package:emotion_chat/widgets/navigation/side_drawer.dart';
import 'package:emotion_chat/widgets/navigation/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:emotion_chat/widgets/navigation/bottom_menu_bar.dart';
import 'package:emotion_chat/widgets/button/emotion_toggle_buttons.dart';
import 'package:provider/provider.dart';
import 'package:emotion_chat/services/chat/emotion_details_service.dart';

class BeforeConsultationScreen extends StatefulWidget {
  final int emotion;

  const BeforeConsultationScreen({
    super.key,
    required this.emotion,
  });

  @override
  State<BeforeConsultationScreen> createState() =>
      _BeforeConsultationScreenState();
}

class _BeforeConsultationScreenState extends State<BeforeConsultationScreen> {
  late int emotion;
  String? period;
  bool? knowCause;
  String background = '';

  bool canSubmit = false;
  bool isLoading = false;

  final TextEditingController _textEditingController = TextEditingController();
  final EmotionDetailsService _emotionDetailsService = EmotionDetailsService();

  @override
  void initState() {
    super.initState();
    emotion = widget.emotion;
    _textEditingController.addListener(() {
      setBackground(_textEditingController.text);
    });
  }

  onSubmit() async {
    if (canSubmit) {
      setState(() {
        isLoading = true;
      });

      await _emotionDetailsService.addEmotionDetails(
          emotion, period!, knowCause!, background);

      setState(() {
        isLoading = false;
      });

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(emotion: emotion),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const ConfirmAlert(message: '현재 감정 상태를 입력해주세요!'),
      );
    }
  }

  setEmotion(int index) {
    setState(() {
      emotion = index;
    });
  }

  setPeriod(int index) {
    setState(() {
      if (index == 0) {
        period = '1시간';
      } else if (index == 1) {
        period = '1일';
      } else if (index == 2) {
        period = '2주';
      } else if (index == 3) {
        period = '1달 이상';
      }
      setShowSubmitBtn();
    });
  }

  setKnowCause(int index) {
    setState(() {
      if (index == 0) {
        knowCause = true;
      } else if (index == 1) {
        knowCause = false;
      }
      setShowSubmitBtn();
    });
  }

  setBackground(String text) {
    setState(() {
      background = text;
      setShowSubmitBtn();
    });
  }

  setShowSubmitBtn() {
    setState(() {
      canSubmit = (period != null && knowCause == false) ||
          (period != null && knowCause == true && background.isNotEmpty);
    });
  }

  void signOut() {
    // get auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: const Text(
            'Before Consultation',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          foregroundColor: Theme.of(context).colorScheme.background,
          backgroundColor: Theme.of(context).colorScheme.primary,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          actions: [
            TextButton(
              onPressed: onSubmit,
              child: const Text(
                '제출',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const SideDrawer(),
      bottomNavigationBar: const BottonMenuBar(),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    EmotionToggleButtons(
                      question: '현재 느끼는 감정을 알려주세요!',
                      answers: const ['기쁨', '화남', '불안', '우울'],
                      selectedBorderColor:
                          Theme.of(context).colorScheme.secondary,
                      fillColor: Theme.of(context).colorScheme.tertiary,
                      color: Theme.of(context).colorScheme.primary,
                      initialIndex: emotion,
                      onPressed: setEmotion,
                    ),
                    EmotionToggleButtons(
                      question: '그러한 감정이 얼마나 지속됐나요?',
                      answers: const ['1시간', '1일', '2주', '1달 이상'],
                      selectedBorderColor: Colors.green.shade700,
                      fillColor: Colors.green.shade200,
                      color: Colors.green.shade400,
                      onPressed: setPeriod,
                    ),
                    EmotionToggleButtons(
                      question: '감정이 일어난 원인을 아시나요?',
                      answers: const ['네', '아니오'],
                      selectedBorderColor: Colors.red.shade700,
                      fillColor: Colors.red.shade200,
                      color: Colors.red.shade400,
                      onPressed: setKnowCause,
                    ),
                    EmotionTextField(
                      question: '감정이 일어나게 된 상황에 대해 알려주세요!',
                      hintText: '구체적으로 작성하면 상담에 도움이 됩니다 :)',
                      controller: _textEditingController,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
