import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ProfileImageService {
  Future<void> saveImage(image, email) async {
    final appDir = await getApplicationDocumentsDirectory();
    final localImagePath = '${appDir.path}/${email}_profile_image.png';

    if (image != null) {
      await image!.copy(localImagePath);
    }
  }

  Future<File?> loadImage(email) async {
    final appDir = await getApplicationDocumentsDirectory();
    final localImagePath = '${appDir.path}/${email}_profile_image.png';

    return File(localImagePath).existsSync() ? File(localImagePath) : null;
  }
}
