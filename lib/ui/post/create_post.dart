import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_project/ui/home/home.dart';
import 'package:instagram_project/ui/post/post_view_model.dart';
import 'package:provider/provider.dart';

class CreatePost extends StatelessWidget {
  CreatePost({this.pickImage, super.key});

  final TextEditingController _textEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  XFile? pickImage;
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileViewModel>(
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
                mainAxisAlignment: MainAxisAlignment.start,
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
                  SizedBox(
                    child:
                        model.pickedImage != null
                            ? Column(
                              children: [
                                Image.file(
                                  File(model.pickedImage!.path),
                                  fit: BoxFit.cover,
                                  height: 203.h,
                                  width: 1.sw,
                                ),
                                10.verticalSpace,
                                Form(
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: _textEditingController,
                                        style: TextStyle(color: Colors.white),
                                        maxLines: 5,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'Add a caption',
                                          labelStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        onChanged: (newValue) {
                                          _textEditingController.text =
                                              newValue;
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Add a caption';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      200.verticalSpace,
                                      ElevatedButton(
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            formKey.currentState!.save();
                                            if (model.pickedImage?.path !=
                                                null) {
                                              model.addPost(
                                                imagePath:
                                                    model.pickedImage!.path,
                                                caption:
                                                    _textEditingController.text,
                                              );
                                            }
                                          }
                                          _textEditingController.clear();
                                          FocusScope.of(context).unfocus();
                                        },
                                        child: Text(
                                          'Post',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                            : Text(
                              "No image selectled",
                              style: TextStyle(color: Colors.white),
                            ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
