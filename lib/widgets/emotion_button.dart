import 'package:flutter/material.dart';

class EmotionButton extends StatelessWidget {
  final Image image;

  const EmotionButton({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      child: SizedBox(
        height: 100,
        width: 100,
        child: image,
      ),
    );
  }
}
