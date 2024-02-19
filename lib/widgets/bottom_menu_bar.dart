import 'package:emotion_chat/screens/main/home_tap/home.dart';
import 'package:emotion_chat/screens/main/profile_tap/profile.dart';
import 'package:emotion_chat/screens/main/chat_tap/user_list.dart';
import 'package:flutter/material.dart';

class BottonMenuBar extends StatefulWidget {
  final int? currentIndex;

  const BottonMenuBar({
    super.key,
    this.currentIndex,
  });

  @override
  State<BottonMenuBar> createState() => _BottonMenuBarState();
}

class _BottonMenuBarState extends State<BottonMenuBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex ?? 0;
  }

  void _onTab(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (_currentIndex == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const Home(),
        ),
      );
    } else if (_currentIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UserList(),
        ),
      );
    } else if (_currentIndex == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const Profile(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.blue,
      selectedItemColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _currentIndex,
      onTap: _onTab,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_rounded,
            size: 48,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat_rounded,
            size: 44,
          ),
          label: 'ChatList',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_rounded,
            size: 48,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
