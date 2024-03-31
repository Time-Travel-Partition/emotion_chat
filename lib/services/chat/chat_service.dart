import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_chat/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  // get instance of firestore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final String currentUserID;
  final Timestamp timestamp = Timestamp.now();

  ChatService() {
    currentUserID = _auth.currentUser!.uid;
  }

  Stream<List<Map<String, dynamic>>> getChatRoomsStream() {
    // final String currentUserID = _auth.currentUser!.uid; // 초기버전

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
    // final String currentUserID = _auth.currentUser!.uid;

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

  Future<void> backupChatHistory(int emotion) async {
    String chatRoomID = '${currentUserID}_$emotion';
    final chatRoomRef = _firestore.collection('ChatRooms').doc(chatRoomID);
    final messagesSnapshot = await chatRoomRef.collection('Messages').get();

    // 새로운 컬렉션에 메시지 복사
    for (var msg in messagesSnapshot.docs) {
      await _firestore
          .collection('ChatHistory')
          .doc(chatRoomID)
          .collection('Messages')
          .add(msg.data());
    }
  }
}
