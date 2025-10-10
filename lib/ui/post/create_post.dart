import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_project/ui/home/home.dart';
import 'package:instagram_project/ui/post/post_view_model.dart';
import 'package:provider/provider.dart';

class CreatePost extends StatelessWidget {
  CreatePost({this.pickImage, super.key});

  XFile? pickImage;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostViewModel(),
      child: Consumer<PostViewModel>(
        builder:
            (context, model, child) => Scaffold(
              backgroundColor: Colors.black,
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  model.pickImage();
                },
                child: Icon(Icons.add, color: Colors.black),
              ),
              bottomNavigationBar: CustomBottomBar(),
              body: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Create Post',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Center(
                      child:
                          model.pickedImage != null
                              ? Image.file(File(model.pickedImage!.path))
                              : Text(
                                "No image selectled",
                                style: TextStyle(color: Colors.white),
                              ),
                    ),

                    // Center(child: model.displayImage(pickedFile)),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
