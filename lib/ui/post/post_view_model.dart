import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_project/ui/post/post_model.dart';

class UserProfileViewModel extends ChangeNotifier {
  XFile? pickedImage;
  List<Post> userPosts = [];

  pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // print("@pickImage ${pickedFile.path}");
      pickedImage = pickedFile;
    }
    notifyListeners();
  }

  addPost({required String imagePath, required String caption}) {
    userPosts.add(Post(postPath: imagePath, caption: caption));
    // print('@addPost $imagePath');
    notifyListeners();
  }
}

