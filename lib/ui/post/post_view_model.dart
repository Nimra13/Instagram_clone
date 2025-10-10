import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostViewModel extends ChangeNotifier {
  XFile? pickedImage;

  pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // print("@pickImage ${pickedFile.path}");
      pickedImage = pickedFile;
    }
    notifyListeners();
  }
}
