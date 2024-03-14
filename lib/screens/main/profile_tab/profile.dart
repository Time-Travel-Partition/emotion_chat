import 'dart:io';
import 'package:emotion_chat/services/image/local_storage/profile_image_service.dart';
import 'package:emotion_chat/services/user/user_service.dart';
import 'package:emotion_chat/widgets/modal/incomplete_input_alert.dart';
import 'package:emotion_chat/widgets/navigation/bottom_menu_bar.dart';
import 'package:emotion_chat/widgets/navigation/side_drawer.dart';
import 'package:emotion_chat/widgets/navigation/top_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../utils/image_picker_utils.dart';
import '../../../widgets/image/image_selector.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String email;
  late String name;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService();
  final ProfileImageService _profileImageService = ProfileImageService();
  final TextEditingController _textEditingController = TextEditingController();
  File? image; // Nullable
  bool isLoading = false;

  setImage() async {
    File? pickedFile = await ImagePickerUtils.pickImage();
    if (pickedFile != null) {
      setState(() {
        image = pickedFile;
      });
    }
  }

  setName(String text) {
    setState(() {
      name = text;
    });
  }

  onSubmit() async {
    setState(() {
      isLoading = true;
    });
    await _profileImageService.saveImage(image, email);
    await _userService.updateUserName(name);
    setState(() {
      isLoading = false;
    });
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) =>
            const IncompleteInputAlert(message: '프로필이 수정되었습니다.'),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    email = _auth.currentUser!.email!;
    name = _auth.currentUser?.displayName ?? '';
    // 로컬에 저장된 프로필 이미지 불러와 state에 저장
    _profileImageService.loadImage(email).then((loadedImage) {
      if (loadedImage != null) {
        setState(() {
          PaintingBinding.instance.imageCache.clear();
          PaintingBinding.instance.imageCache.clearLiveImages();
          image = loadedImage;
        });
      }
    });
    _textEditingController.text = _auth.currentUser?.displayName ?? '';
    // 이름 텍스트가 편집될 때마다 state 변경
    _textEditingController.addListener(() {
      setName(_textEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child:
            TopAppBar(titleText: 'Profile', buttonText: '확인', onTap: onSubmit),
      ),
      drawer: const SideDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ImageSelector(
                      image: image,
                      onSelectImage: setImage,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
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
                          padding: const EdgeInsets.symmetric(vertical: 5),
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
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.white),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blue),
                          elevation: MaterialStatePropertyAll(0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            '비밀번호 변경',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
      bottomNavigationBar: const BottonMenuBar(
        currentIndex: 2,
      ),
    );
  }
}
