import 'package:emotion_chat/screens/main/chat_tab/chat_page.dart';
import 'package:emotion_chat/services/auth/auth_service.dart';
import 'package:emotion_chat/widgets/textfield/emotion_textfield.dart';
import 'package:emotion_chat/widgets/modal/incomplete_input_alert.dart';
import 'package:emotion_chat/widgets/navigation/side_drawer.dart';
import 'package:emotion_chat/widgets/navigation/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:emotion_chat/widgets/navigation/bottom_menu_bar.dart';
import 'package:emotion_chat/widgets/button/emotion_toggle_buttons.dart';
import 'package:provider/provider.dart';
import 'package:emotion_chat/services/chat/emotion_details_service.dart';

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
  bool isLoading = false;
  late List<bool> _selectedEmotionBtn;
  final TextEditingController _textEditingController = TextEditingController();
  final EmotionDetailsService emotionDetailsService = EmotionDetailsService();

  onSubmit() async {
    if (showSubmitBtn) {
      setState(() {
        isLoading = true;
      });
      await emotionDetailsService.addEmotionDetails(
          emotion!, period!, knowCause!, background);
      setState(() {
        isLoading = false;
      });
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) =>
            const IncompleteInputAlert(message: '현재 감정 상태를 입력해주세요!'),
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
      background = text;
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

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _textEditingController.dispose();
    super.dispose();
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
        preferredSize: const Size.fromHeight(60),
        child: TopAppBar(
            titleText: 'Before Consultation',
            buttonText: '제출',
            onTap: onSubmit),
      ),
      drawer: const SideDrawer(),
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
                  ],
                ),
              ),
      ),
      bottomNavigationBar: const BottonMenuBar(),
    );
  }
}
