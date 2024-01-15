import 'package:flutter/material.dart';

class EmotionButton extends StatelessWidget {
  final String text;
  final Color color;

  const EmotionButton({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(children: [
        const SizedBox(
          height: 100,
          width: 100,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 18),
        ),
      ]),
    );
  }
}
