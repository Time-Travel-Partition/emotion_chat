import 'package:emotion_chat/screens/main/chat_tab/emotion_details.dart';
import 'package:flutter/material.dart';

class EmotionButton extends StatelessWidget {
  final int emotion;
  final Image image;

  const EmotionButton({
    super.key,
    required this.emotion,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor:
            MaterialStateColor.resolveWith((states) => Colors.transparent),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EmotionDetails(emotion: emotion),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: SizedBox(
          height: 100,
          width: 100,
          child: image,
        ),
      ),
    );
  }
}
