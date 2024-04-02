import 'package:flutter/material.dart';

class InputAlert extends StatefulWidget {
  final String message;
  final Function(String) onPressedConfirm;

  const InputAlert({
    Key? key,
    required this.message,
    required this.onPressedConfirm,
  }) : super(key: key);

  @override
  State<InputAlert> createState() => _InputAlertState();
}

class _InputAlertState extends State<InputAlert> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            widget.message,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _textEditingController,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6, top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onPressedConfirm(_textEditingController.text);
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.background),
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.primary),
                      elevation: const MaterialStatePropertyAll(0),
                    ),
                    child: const Text(
                      '확인',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6, top: 20),
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
                      '취소',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
