import 'package:flutter/material.dart';

import 'package:emotion_chat/components/my_button.dart';
import 'package:emotion_chat/components/my_textfield.dart';
import 'package:emotion_chat/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:emotion_chat/widgets/emotion_button.dart';

class RegisterPage extends StatelessWidget {
  // email and pw text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  //register method
  void login() {}

  void register() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: lightMode,
        home: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                Icon(Icons.message,
                    size: 60, color: Theme.of(context).colorScheme.primary),

                const SizedBox(
                  height: 50,
                ),

                // welcom back message
                Text(
                  "이메일과 비밀번호를 입력해주세요",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),
                // email textfield
                MyTextField(
                  hintText: "이메일",
                  obscureText: false,
                  controller: _emailController,
                ),
                const SizedBox(height: 10),

                // pw textfield
                MyTextField(
                  hintText: "비밀번호",
                  obscureText: true,
                  controller: _pwController,
                ),

                const SizedBox(height: 10),

                // confirm pw textfield
                MyTextField(
                  hintText: "비밀번호 확인",
                  obscureText: true,
                  controller: _confirmPwController,
                ),

                const SizedBox(height: 25),

                // register button
                MyButton(text: "회원가입", onTap: register),

                const SizedBox(height: 25),

                // register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "이미 계정이 있으신가요? ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Text(
                        "로그인하기",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    )
                  ],
                )
              ],
            )));
  }
}
