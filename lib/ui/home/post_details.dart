import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_project/ui/home/home_model.dart';

class PostDetails extends StatefulWidget {
  PostDetails({required this.unsplashImage, super.key});

  final UnsplashImage unsplashImage;

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 300.h,
            width: 450.w,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Hero(
                tag: '${widget.unsplashImage.urls?.regular}',
                child: Image.network(
                  '${widget.unsplashImage.urls?.regular}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${widget.unsplashImage.user?.instagramUsername}',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.favorite_border_outlined, color: Colors.black),
                  8.horizontalSpace,
                  Text(
                    '${widget.unsplashImage.likes}',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          10.verticalSpace,
          Padding(
            padding: EdgeInsets.only(left: 8.w, right: 8.w),
            child: Text(
              '${widget.unsplashImage.description}',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
