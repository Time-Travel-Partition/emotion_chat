import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;

  final void Function()? onTap;

  const UserTile({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    //print('userData: $text'); // 유저데이터의 텍스트 출력
    return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
            // color: Theme.of(context).colorScheme.secondary,
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.grey),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 40,
          ),
          child: Row(
            children: [
              // icon
              SizedBox(
                height: 40,
                width: 40,
                child: Image.asset('images/chat_icon.png'), // 임시
              ),
              const SizedBox(
                width: 20,
              ),
              // user name
              Text(text), // ---Text(text)
            ],
          ),
        ));
  }
}
