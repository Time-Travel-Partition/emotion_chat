import 'dart:io';
import 'package:flutter/material.dart';

class ImageSelector extends StatefulWidget {
  final VoidCallback onSelectImage; // VoidCallback은 매개변수 없이 호출되는 함수
  final File? image;

  const ImageSelector(
      {super.key, required this.onSelectImage, required this.image});

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  File? pickedImage;

  @override
  void initState() {
    super.initState();
    pickedImage = widget.image;
  }

  @override
  void didUpdateWidget(ImageSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("이미지는 정상적으로 저장되나 재빌드시 위젯을 다시 그리지 않는 버그");
    if (widget.image != oldWidget.image) {
      setState(() {
        pickedImage = widget.image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70, bottom: 30),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          (pickedImage != null)
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: FileImage(
                      File(pickedImage!.path),
                    ),
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue),
                  ),
                  width: 200,
                  height: 200,
                ),
          Positioned(
            bottom: -20,
            right: -20,
            child: IconButton(
              onPressed: widget.onSelectImage,
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
                foregroundColor: MaterialStatePropertyAll(Colors.white),
                side: MaterialStatePropertyAll(
                  BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              icon: const Icon(Icons.camera_alt_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
