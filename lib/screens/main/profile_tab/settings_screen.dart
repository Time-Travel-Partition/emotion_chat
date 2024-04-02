import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          foregroundColor: Theme.of(context).colorScheme.background,
          backgroundColor: Theme.of(context).colorScheme.primary,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
        ),
      ),
    );
  }
}
