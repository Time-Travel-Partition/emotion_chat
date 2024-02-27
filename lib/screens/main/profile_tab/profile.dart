import 'dart:io';
import 'package:emotion_chat/screens/main/home_tab/home.dart';
import 'package:emotion_chat/services/image/local_storage/profile_image_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:emotion_chat/widgets/bottom_menu_bar.dart';
import 'package:emotion_chat/widgets/home_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../widgets/profile_image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String email;
  late String name;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _textEditingController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final ProfileImageService _profileImageService = ProfileImageService();

  File? image; // Nullable

  void _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  setName(String text) {
    setState(() {
      name = text;
    });
  }

  onSubmit() async {
    await _profileImageService.saveImage(image, email);

    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    email = _auth.currentUser!.email!;
    _profileImageService.loadImage(email).then((loadedImage) {
      if (loadedImage != null) {
        setState(() {
          image = loadedImage;
        });
      }
    });
    _textEditingController.addListener(() {
      setName(_textEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Profile',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          actions: [
            TextButton(
              onPressed: onSubmit,
              child: const Text(
                '확인',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
        drawer: const HomeDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProfileImagePicker(
                image: image,
                onPickImage: _pickImage,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      width: 50,
                      child: Text(
                        '이름',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: TextField(
                        controller: _textEditingController,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      width: 50,
                      child: Text(
                        '이메일',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: email,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                    backgroundColor: MaterialStatePropertyAll(Colors.blue),
                    elevation: MaterialStatePropertyAll(0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      '비밀번호 변경',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: const BottonMenuBar(
          currentIndex: 2,
        ),
      ),
    );
  }
}
