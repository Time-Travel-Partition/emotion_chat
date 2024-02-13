import 'package:emotion_chat/screens/home.dart';
import 'package:emotion_chat/screens/profile.dart';
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
            Icons.person_rounded,
            size: 48,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
