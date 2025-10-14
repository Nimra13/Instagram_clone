import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_project/ui/post/post_view_model.dart';
import 'package:provider/provider.dart';

class MyPost extends StatelessWidget {
  const MyPost({this.description, super.key});

  final String? description;
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileViewModel>(
      builder:
          (context, model, child) => Scaffold(
            backgroundColor: Colors.black,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('images/face.png'),
                        radius: 30.r,
                      ),
                      10.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'butterfly_abc.pk',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '@shehzaddev.20',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 221, 219, 219),
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  40.verticalSpace,
                  GridView.builder(
                    itemCount: model.userPosts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // number of items in each row
                      mainAxisSpacing: 8.0, // spacing between rows
                      crossAxisSpacing: 8.0, // spacing between columns
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap:
                            () => showDialog(
                              context: context,
                              builder:
                                  (BuildContext context) => AlertDialog(
                                    insetPadding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.r),
                                      ),
                                    ),

                                    content: Container(
                                      height: 0.5.sh,
                                      width: 1.sw - 40.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                              10.r,
                                            ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.white.withOpacity(
                                              0.3,
                                            ),
                                            blurRadius: 5.r,
                                            spreadRadius: 5.r,
                                          ),
                                        ],
                                      ),

                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              Image.file(
                                                File(
                                                  model.userPosts[index].postPath,
                                                ),
                                                fit: BoxFit.cover,
                                                height: 203.h,
                                                width: 1.sw,
                                              ),
                                              Positioned(
                                                right: 8.w,
                                                top: 8.h,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Icon(
                                                    Icons.cancel_rounded,
                                                    color: Colors.white,
                                                    size: 30.sp,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          10.verticalSpace,
                                          Text(
                                            " ${model.userPosts[index].caption}",
                                            style: TextStyle(fontSize: 30.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            ),
                        child: Image.file(
                          File(model.userPosts[index].postPath),
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    shrinkWrap: true,
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
