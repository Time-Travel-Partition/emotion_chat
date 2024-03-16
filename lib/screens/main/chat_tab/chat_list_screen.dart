import 'package:emotion_chat/services/chat/chat_service.dart';
import 'package:emotion_chat/widgets/navigation/bottom_menu_bar.dart';
import 'package:emotion_chat/widgets/navigation/side_drawer.dart';
import 'package:emotion_chat/widgets/navigation/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:emotion_chat/widgets/list_item/user_tile.dart';
import 'package:emotion_chat/screens/main/chat_tab/chat_screen.dart';

// HomePage -> UserList
class ChatListScreen extends StatelessWidget {
  ChatListScreen({super.key});

  // chat & auth service
  final ChatService _chatService = ChatService();

  getEmotionString(int index) {
    if (index == 0) return '기쁨';
    if (index == 1) return '화남';
    if (index == 2) return '불안';
    if (index == 3) return '우울';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: TopAppBar(titleText: 'Chat'),
      ),
      drawer: const SideDrawer(),
      body: _buildUserList(),
      bottomNavigationBar: const BottonMenuBar(
        currentIndex: 1,
      ),
    );
  }

  // build a list of users
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getChatRoomsStream(),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Text('Error');
        }
        //loading ..
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading..');
        }
        //return list view
        return snapshot.data!.isNotEmpty
            ? ListView(
                children: snapshot.data!
                    .map<Widget>((chatRoomsData) =>
                        _buildUserListItem(chatRoomsData, context))
                    .toList(),
              )
            : const Center(
                child: Text(
                  '현재 채팅방이 존재하지 않습니다 🥲',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> chatRoomsData, BuildContext context) {
    return UserTile(
      text: getEmotionString(chatRoomsData['emotion']),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              emotion: chatRoomsData['emotion'],
            ),
          ),
        );
      },
    );
  }
}
