import 'package:flutter/material.dart';

class ConfirmOrCancelAlert extends StatelessWidget {
  final String message;
  final VoidCallback onPressedConfirm;

  const ConfirmOrCancelAlert({
    super.key,
    required this.message,
    required this.onPressedConfirm,
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
      content: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: ElevatedButton(
                onPressed: onPressedConfirm,
                style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.background),
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.primary),
                  elevation: const MaterialStatePropertyAll(0),
                ),
                child: const Text(
                  '네',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.background),
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.primary),
                  elevation: const MaterialStatePropertyAll(0),
                ),
                child: const Text(
                  '아니오',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
