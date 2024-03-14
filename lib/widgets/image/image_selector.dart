import 'dart:io';
import 'package:flutter/material.dart';

class ImageSelector extends StatelessWidget {
  final VoidCallback onSelectImage; // VoidCallback은 매개변수 없이 호출되는 함수
  final File? image;

  const ImageSelector(
      {super.key, required this.onSelectImage, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          (image != null)
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: FileImage(
                      File(image!.path),
                    ),
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  width: 200,
                  height: 200,
                ),
          Positioned(
            bottom: -20,
            right: -20,
            child: IconButton(
              onPressed: onSelectImage,
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
                foregroundColor: MaterialStatePropertyAll(Colors.white),
              ),
              icon: const Icon(Icons.camera_alt_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
