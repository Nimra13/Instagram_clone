import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_project/ui/auth/login.dart';
import 'dart:io';

class UploadImage extends StatefulWidget {
  UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final picker = ImagePicker();
  File? image;

  Future getImageGallery() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
      } else {
        print('no image picked');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Image')),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                getImageGallery();
              },
              child:
                  image != null
                      ? Image.file(File(image!.path))
                      : Icon(Icons.image, size: 60.sp),
            ),
          ),
          20.verticalSpace,
          CustomElevatedButton(
            text: 'upload',
            onPressed: () {},
            color: Colors.black,
            textcolor: Colors.white,
          ),
        ],
      ),
    );
  }
}
