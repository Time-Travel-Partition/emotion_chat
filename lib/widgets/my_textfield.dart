import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText; // final var은 반드시 초기화 되어야함
  final bool obscureText;
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              // color: Theme.of(context).colorScheme.primary
              color: Colors.grey.shade500,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              // color: Theme.of(context).colorScheme.primary
              color: Colors.grey.shade500,
            ),
          ),
          // fillColor: Theme.of(context).colorScheme.secondary,
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            // color: Theme.of(context).colorScheme.primary
            color: Colors.grey.shade500,
          ),
        ),
      ),
    );
  }
}
