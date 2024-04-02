import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:emotion_chat/services/auth/auth_service.dart';
import 'package:emotion_chat/widgets/button/auth_button.dart';
import 'package:emotion_chat/widgets/textfield/auth_textfield.dart';
import 'package:emotion_chat/widgets/modal/confirm_alert.dart';

import '../../widgets/modal/input_alert.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onTap;

  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  // email and pw text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final AuthService _authService = AuthService();

  void login(BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
      });

      await _authService.signInWithEmailPassword(
          _emailController.text, _pwController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      // 로그인 실패 시 AlertDialog 띄우기
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ConfirmAlert(message: e.message ?? '로그인 실패');
          },
        );
      }
    }
  }

  onResetPassword(String email) async {
    try {
      await _authService.resetPassword(email);
      if (mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ConfirmAlert(message: '비밀번호 재설정 메일이 전송되었습니다.');
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ConfirmAlert(message: e.message ?? '비밀번호 재설정 실패');
          },
        );
      }
    }
  }

  onTapChangePassword() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InputAlert(
          message: '이메일을 입력해주세요.',
          onPressedConfirm: (String email) {
            onResetPassword(email);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        '회원가입',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    Text(
                      ' 혹은 ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: onTapChangePassword,
                      child: Text(
                        '비밀번호 찾기',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
    );
  }
}
