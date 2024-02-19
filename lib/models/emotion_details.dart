import 'package:cloud_firestore/cloud_firestore.dart';

class EmotionDetails {
  final String uid;
  final int emotion;
  final String period;
  final bool knowCause;
  final String background;
  final Timestamp timestamp;

  EmotionDetails({
    required this.uid,
    required this.emotion,
    required this.period,
    required this.knowCause,
    required this.background,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'emotion': emotion,
      'period': period,
      'knowCause': knowCause,
      'background': background,
      'timestamp': timestamp,
    };
  }
}
