import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble(
      {super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.blue),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Text(
        message,
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: isCurrentUser ? Colors.white : Colors.blue,
        ),
      ),
    );
  }
}
