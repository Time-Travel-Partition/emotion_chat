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
          decoration: BoxDecoration(
            // color: Theme.of(context).colorScheme.secondary,
            color: Colors.grey.shade500,
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              // icon
              const Icon(Icons.person),
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
