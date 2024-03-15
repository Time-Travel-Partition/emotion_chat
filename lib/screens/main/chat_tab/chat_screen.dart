import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_chat/services/auth/auth_service.dart';
import 'package:emotion_chat/services/chat/chat_service.dart';
import 'package:emotion_chat/services/openai/openai_service.dart';
import 'package:emotion_chat/widgets/list_item/chat_bubble.dart';
import 'package:emotion_chat/widgets/textfield/auth_textfield.dart';
import 'package:emotion_chat/widgets/navigation/top_app_bar.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;

  ChatScreen({
    super.key,
    this.receiverEmail = 'EmotionBot@gmail.com', // 기본값 설정
    this.receiverID = 'tnc3JRtbstPJTclrHLrN9kzWfeg2', // 임시
  });

  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  final openAIService = OpenAIService();

  //send message
  void sendMessage() async {
    // if there is something inside the textfield
    if (_messageController.text.isNotEmpty) {
      // send the message
      await _chatService.sendMessage(receiverID, _messageController.text);
      // 🚨 상대측이 아닌 내가 보낸 메시지가 됨 (나중에 해결)
      receiveMessage();
      // clear text controller
      _messageController.clear();
    }
  }

  //send message
  void receiveMessage() async {
    final message = await openAIService.createModel(_messageController.text);
    await _chatService.sendMessage(receiverID, message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: TopAppBar(titleText: receiverEmail),
      ),
      body: Column(
        children: [
          //display all messages
          Expanded(child: _buildMessageList()),

          //user input
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Text('errors');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading');
        }
        // 메시지 전송시 자동으로 스크롤 최하단으로 내리는 것 필요
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  // build message Item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    // 현재 로그인한 유저와 동일여부 파악
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    // 현재 로그인한 유저의 메시지는 오른쪽으로 정렬 아니면 왼쪽정렬.
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data['message'], isCurrentUser: isCurrentUser),
        ],
      ),
    );
  }

  // build message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 40.0),
      child: Row(
        children: [
          //텍스트 필드가 대부분의 공간을 차지하도록 설정
          Expanded(
            child: AuthTextField(
              controller: _messageController,
              hintText: 'Type a message',
              obscureText: false,
            ),
          ),

          //send button
          Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
