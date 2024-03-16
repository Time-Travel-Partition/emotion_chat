import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_chat/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  // get instance of firestore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getChatRoomsStream() {
    final String currentUserID = _auth.currentUser!.uid;

    return _firestore
        .collection('ChatRooms')
        .where(FieldPath.documentId,
            isGreaterThanOrEqualTo: '${currentUserID}_0')
        .where(FieldPath.documentId, isLessThanOrEqualTo: '${currentUserID}_3')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final chatRooms = doc.data();
        return chatRooms;
      }).toList();
    });
  }

  Future<void> sendMessage(int emotion, String content, bool isBot) async {
    final String currentUserID = _auth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
      uid: currentUserID,
      emotion: emotion,
      content: content,
      isBot: isBot,
      timestamp: timestamp,
    );

    String chatRoomID = '${currentUserID}_$emotion';

    await _firestore
        .collection('ChatRooms')
        .doc(chatRoomID)
        .collection('Messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(int emotion) {
    final String currentUserID = _auth.currentUser!.uid;

    String chatRoomID = '${currentUserID}_$emotion';

    return _firestore
        .collection('ChatRooms')
        .doc(chatRoomID)
        .collection('Messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
