import 'package:flutter/material.dart';

class ConfirmAlert extends StatelessWidget {
  final String message;

  const ConfirmAlert({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            message,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
      content: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(
              Theme.of(context).colorScheme.background),
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
          elevation: const MaterialStatePropertyAll(0),
        ),
        child: const Text(
          '확인',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
