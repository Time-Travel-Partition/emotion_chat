import 'package:emotion_chat/screens/main/chat_tap/chat_page.dart';
import 'package:emotion_chat/service/auth/auth_service.dart';
import 'package:emotion_chat/widgets/emotion_textfield.dart';
import 'package:flutter/material.dart';
import 'package:emotion_chat/widgets/bottom_menu_bar.dart';
import 'package:emotion_chat/widgets/emotion_toggle_buttons.dart';
import 'package:provider/provider.dart';
import 'package:emotion_chat/service/chat/emotion_details_service.dart';

class EmotionDetails extends StatefulWidget {
  final int emotion;

  const EmotionDetails({
    super.key,
    required this.emotion,
  });

  @override
  State<EmotionDetails> createState() => _EmotionDetailsState();
}

class _EmotionDetailsState extends State<EmotionDetails> {
  int? emotion;
  String? period;
  bool? knowCause;
  String background = '';
  bool showTextField = false;
  bool showSubmitBtn = false;
  late List<bool> _selectedEmotionBtn;
  final TextEditingController _textEditingController = TextEditingController();
  final EmotionDetailsService emotionDetailsService = EmotionDetailsService();

  onSubmit() async {
    if (showSubmitBtn) {
      await emotionDetailsService.addEmotionDetails(
          emotion!, period!, knowCause!, background);

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(),
          ),
        );
      }
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
        showTextField = true;
      } else if (index == 1) {
        knowCause = false;
        showTextField = false;
      }
      setShowSubmitBtn();
    });
  }

  setBackground(String text) {
    setState(() {
      background = _textEditingController.text;
      setShowSubmitBtn();
    });
  }

  setShowSubmitBtn() {
    setState(() {
      showSubmitBtn = (period != null && knowCause == false) ||
          (period != null && knowCause == true && background.isNotEmpty);
    });
  }

  @override
  void initState() {
    super.initState();
    emotion = widget.emotion;
    _selectedEmotionBtn =
        List<bool>.generate(4, (index) => index == widget.emotion);
    _textEditingController.addListener(() {
      setBackground(_textEditingController.text);
    });
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
            'Before Consultation',
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
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                EmotionToggleButtons(
                  question: '현재 느끼는 감정을 알려주세요!',
                  answers: const ['기쁨', '화남', '불안', '우울'],
                  selectedBorderColor: Colors.blue[700],
                  fillColor: Colors.blue[200],
                  color: Colors.blue[400],
                  selectedBtn: _selectedEmotionBtn,
                  onPressed: setEmotion,
                ),
                EmotionToggleButtons(
                  question: '그러한 감정이 얼마나 지속됐나요?',
                  answers: const ['1시간', '1일', '2주', '1달 이상'],
                  selectedBorderColor: Colors.green[700],
                  fillColor: Colors.green[200],
                  color: Colors.green[400],
                  onPressed: setPeriod,
                ),
                EmotionToggleButtons(
                  question: '감정이 일어난 원인을 아시나요?',
                  answers: const ['네', '아니오'],
                  selectedBorderColor: Colors.red[700],
                  fillColor: Colors.red[200],
                  color: Colors.red[400],
                  onPressed: setKnowCause,
                ),
                EmotionTextField(
                  question: '감정이 일어나게 된 상황에 대해 알려주세요!',
                  hintText: '구체적으로 작성하면 상담에 도움이 됩니다 :)',
                  controller: _textEditingController,
                ),
                // if (showSubmitBtn)
                ElevatedButton(
                  onPressed: onSubmit,
                  style: ButtonStyle(
                    foregroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      if (showSubmitBtn) {
                        return Colors.blue;
                      } else {
                        return Colors.grey;
                      }
                    }),
                    elevation: const MaterialStatePropertyAll(0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      '제출',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottonMenuBar(),
      ),
    );
  }
}
