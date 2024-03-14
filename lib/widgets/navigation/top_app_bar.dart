import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget {
  final String titleText;
  final String? buttonText;
  final void Function()? onTap;

  const TopAppBar({
    Key? key,
    required this.titleText,
    this.buttonText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        titleText,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      foregroundColor: Theme.of(context).colorScheme.background,
      backgroundColor: Theme.of(context).colorScheme.primary,
      actions: [
        if (buttonText != null && onTap != null)
          TextButton(
            onPressed: onTap,
            child: Text(
              buttonText!,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
      ],
    );
  }
}
