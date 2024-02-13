import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ProfileImagePicker extends StatefulWidget {
  const ProfileImagePicker({
    super.key,
  });

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  final ImagePicker _picker = ImagePicker();

  XFile? _profile;

  void _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profile = pickedFile;
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
          (_profile != null)
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: FileImage(
                      File(_profile!.path),
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
              onPressed: _pickImage,
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
