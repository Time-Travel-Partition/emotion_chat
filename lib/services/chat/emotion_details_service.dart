import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_chat/models/emotion_details.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmotionDetailsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Firestore에 저장
  Future<void> addEmotionDetails(
      int emotion, String period, bool knowCause, String background) async {
    final String currentUserID = _auth.currentUser!.uid;

    EmotionDetails newEmotionDetails = EmotionDetails(
      uid: currentUserID,
      emotion: emotion,
      period: period,
      knowCause: knowCause,
      background: background,
      timestamp: Timestamp.now(),
    );

    List<String> ids = [currentUserID, 'tnc3JRtbstPJTclrHLrN9kzWfeg2']; // 임시
    ids.sort();
    String chatRoomID = ids.join('_');

    await _firestore
        .collection('ChatRooms')
        .doc(chatRoomID)
        .collection('EmotionDetails')
        .doc()
        .set(newEmotionDetails.toMap());
  }
}
