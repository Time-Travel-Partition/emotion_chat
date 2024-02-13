import 'package:flutter/material.dart';

class EmotionToggleButtons extends StatefulWidget {
  final String question;
  final List<String> answers;
  final Color? selectedBorderColor;
  final Color? fillColor;
  final Color? color;

  const EmotionToggleButtons(
      {super.key,
      required this.question,
      required this.answers,
      required this.selectedBorderColor,
      required this.fillColor,
      required this.color});

  @override
  State<EmotionToggleButtons> createState() => _EmotionToggleButtonsState();
}

class _EmotionToggleButtonsState extends State<EmotionToggleButtons> {
  late List<bool> _selectedBtn;

  @override
  void initState() {
    super.initState();
    _selectedBtn = List<bool>.generate(widget.answers.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.question,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 20, // 여백
        ),
        ToggleButtons(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          selectedBorderColor: widget.selectedBorderColor,
          selectedColor: Colors.white,
          fillColor: widget.fillColor,
          color: widget.color,
          constraints: const BoxConstraints(
            minHeight: 40.0,
            minWidth: 80.0,
          ),
          onPressed: (int index) {
            setState(() {
              for (int i = 0; i < _selectedBtn.length; i++) {
                _selectedBtn[i] = i == index;
              }
            });
          },
          isSelected: _selectedBtn,
          children: [
            for (String answer in widget.answers)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  answer,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
          ],
        ),
        const SizedBox(
          height: 20, // 여백
        ),
      ],
    );
  }
}
