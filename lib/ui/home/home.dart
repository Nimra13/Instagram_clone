import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_project/ui/home/home_model.dart';
import 'package:instagram_project/ui/home/home_services.dart';
import 'package:instagram_project/ui/home/post_details.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UnsplashImage> futureImages = [];
  UnsplashImageServices unsplashImageServices = UnsplashImageServices();

  @override
  void initState() {
    getImages();
    super.initState();
  }

  getImages() async {
    futureImages = await unsplashImageServices.fetchImages();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            40.verticalSpace,
            Row(
              children: [
                Image.asset(
                  'images/logo.png',
                  color: Colors.white,
                  width: 150.w,
                ),
                140.horizontalSpace,
                Icon(Icons.favorite_border_outlined, color: Colors.white),
                20.horizontalSpace,
                Icon(Icons.messenger, color: Colors.white),
              ],
            ),
            Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(backgroundColor: Colors.grey, radius: 50.r),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(Icons.add, size: 35.sp, color: Colors.black),
                    ),
                  ],
                ),
                6.verticalSpace,
                Text(
                  textAlign: TextAlign.center,
                  'Your Story',
                  style: TextStyle(
                    color: Color(0xffAEA9A9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            25.verticalSpace,
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: futureImages.length,
                itemBuilder: (context, index) {
                  return CustomColumnWidget(image: futureImages[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomColumnWidget extends StatefulWidget {
  const CustomColumnWidget({required this.image, super.key});
  final UnsplashImage image;

  @override
  State<CustomColumnWidget> createState() => _CustomColumnWidgetState();
}

class _CustomColumnWidgetState extends State<CustomColumnWidget> {
  bool ispressed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 25.r,
              backgroundImage: NetworkImage('${widget.image.urls?.regular}'),
            ),
            6.horizontalSpace,
            Text(
              '${widget.image.user?.instagramUsername}',
              style: TextStyle(
                color: Colors.amber[50],
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        10.verticalSpace,
        Container(
          height: 300.h,
          width: 400.w,
          color: Colors.blueGrey,
          child: GestureDetector(
            onTap: () {
              Get.to(() => PostDetails(unsplashImage: widget.image));
            },
            child: Hero(
              tag: '${widget.image.urls?.regular}',
              child: Image.network(
                '${widget.image.urls?.regular}',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        10.verticalSpace,
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  ispressed = !ispressed;
                });
              },
              child:
                  ispressed
                      ? Icon(Icons.favorite, color: Colors.red, size: 30.sp)
                      : Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.white,
                        size: 30.sp,
                      ),
            ),
            20.horizontalSpace,
            Icon(Icons.comment_outlined, color: Colors.white, size: 30.sp),
            20.horizontalSpace,
            Icon(Icons.ios_share_outlined, color: Colors.white, size: 30.sp),
          ],
        ),
        40.verticalSpace,
      ],
    );
  }
}
