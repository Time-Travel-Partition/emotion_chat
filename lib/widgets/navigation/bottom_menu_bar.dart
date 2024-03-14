import 'package:emotion_chat/screens/main/home_tab/home_screen.dart';
import 'package:emotion_chat/screens/main/profile_tab/profile_screen.dart';
import 'package:emotion_chat/screens/main/chat_tab/chat_list_screen.dart';
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
          builder: (_) => const HomeScreen(),
        ),
      );
    } else if (_currentIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChatListScreen(),
        ),
      );
    } else if (_currentIndex == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      selectedItemColor: Theme.of(context).colorScheme.background,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _currentIndex,
      onTap: _onTab,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_rounded,
            size: 44,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat_rounded,
            size: 40,
          ),
          label: 'ChatList',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_rounded,
            size: 44,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
