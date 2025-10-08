import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_project/ui/home/comment_box.dart';
import 'package:instagram_project/ui/home/home_model.dart';
import 'package:instagram_project/ui/home/home_view_model.dart';
import 'package:instagram_project/ui/home/post_details.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder:
            (context, model, child) => Scaffold(
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
                        Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.white,
                        ),
                        20.horizontalSpace,
                        Icon(Icons.messenger, color: Colors.white),
                      ],
                    ),
                    Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 50.r,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.add,
                                size: 35.sp,
                                color: Colors.black,
                              ),
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
                    model.isloading
                        ? Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                        : Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: model.images.length,
                            itemBuilder: (context, index) {
                              return CustomColumnWidget(
                                image: model.images[index],
                                index: index,
                              );
                            },
                          ),
                        ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}

class CustomColumnWidget extends StatelessWidget {
  const CustomColumnWidget({
    required this.image,
    required this.index,
    super.key,
  });
  final UnsplashImage image;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder:
          (context, model, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.r,
                    backgroundImage: NetworkImage('${image.urls?.regular}'),
                  ),
                  6.horizontalSpace,

                  Text(
                    '${image.user?.instagramUsername}',
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
                    Get.to(() => PostDetails(unsplashImage: image));
                  },
                  child: Hero(
                    tag: '${image.urls?.regular}',
                    child: Image.network(
                      '${image.urls?.regular}',
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
                      model.toggleliked(index: index);
                    },
                    child:
                        model.images[index].isliked ?? false
                            ? Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 30.sp,
                            )
                            : Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.white,
                              size: 30.sp,
                            ),
                  ),
                  20.horizontalSpace,
                  CustomCommentBox(
                    image: image,
                    index: index,),
                  20.horizontalSpace,
                  Icon(
                    Icons.ios_share_outlined,
                    color: Colors.white,
                    size: 30.sp,
                  ),
                ],
              ),
              40.verticalSpace,
            ],
          ),
    );
  }
}


