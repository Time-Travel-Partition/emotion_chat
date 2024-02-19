import 'package:emotion_chat/service/chat/chat_service.dart';
import 'package:emotion_chat/widgets/bottom_menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:emotion_chat/widgets/user_tile.dart';
import '../../../service/auth/auth_service.dart';
import 'package:emotion_chat/screens/main/chat_tab/chat_page.dart';

// HomePage -> UserList
class UserList extends StatelessWidget {
  UserList({super.key});

  // chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("User List")),
        // drawer: const HomeDrawer(),
        body: _buildUserList(),
        bottomNavigationBar: const BottonMenuBar(
          currentIndex: 1,
        ),
      ),
    );
  }

  // build a list of users
  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return const Text("Error");
          }

          //loading ..
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading..");
          }
          //return list view
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  // build individual list tile for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //display all users except current user
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
                receiverID: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
