import 'package:flutter/material.dart';

class EmotionTextField extends StatelessWidget {
  final String question;
  final String hintText;

  const EmotionTextField({
    super.key,
    required this.question,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          question,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            maxLines: 5,
            maxLength: 200,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(color: Colors.blue),
              ),
              hintText: hintText,
            ),
          ),
        ),
      ],
    );
  }
}
