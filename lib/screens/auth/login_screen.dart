import 'package:emotion_chat/services/auth/auth_service.dart';
import 'package:emotion_chat/widgets/button/auth_button.dart';
import 'package:emotion_chat/widgets/textfield/auth_textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  // email and pw text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  // tap to go to register page
  final void Function()? onTap;

  LoginScreen({super.key, required this.onTap});

  void login(BuildContext context) async {
    // auth service
    final authService = AuthService();
    //final authService = Provider.of<AuthService>(context, listen: false);

    // try login
    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _pwController.text);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }

    // catch any errors
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(
            height: 50,
          ),

          // welcom back message
          Text(
            '환영합니다 감정 챗봇과 자유롭게 대화해요',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 25),

          // email textfield
          AuthTextField(
            hintText: '이메일',
            obscureText: false,
            controller: _emailController,
          ),
          const SizedBox(height: 10),

          // pw textfield
          AuthTextField(
            hintText: '비밀번호',
            obscureText: true,
            controller: _pwController,
          ),
          const SizedBox(height: 25),

          // login button
          AuthButton(
            text: '로그인',
            onTap: () => login(context),
          ),
          const SizedBox(height: 25),

          // register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '아직 회원이 아니신가요? ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  '회원가입',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
