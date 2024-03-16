import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String uid;
  final int emotion;
  final String content;
  final bool isBot;
  final Timestamp timestamp;

  Message({
    required this.uid,
    required this.emotion,
    required this.content,
    required this.isBot,
    required this.timestamp,
  });

  // convert to a map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'emotion': emotion,
      'content': content,
      'isBot': isBot,
      'timestamp': timestamp
    };
  }
}
