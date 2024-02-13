import 'package:emotion_chat/widgets/bottom_menu_bar.dart';
import 'package:emotion_chat/widgets/home_drawer.dart';
import 'package:flutter/material.dart';
import '../widgets/profile_image_picker.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Profile',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
        ),
        drawer: const HomeDrawer(),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileImagePicker(),
              // Text('이름'),
              // Text('이메일'),
              // Text('비밀번호 변경'),
            ],
          ),
        ),
        bottomNavigationBar: const BottonMenuBar(
          currentIndex: 1,
        ),
      ),
    );
  }
}
