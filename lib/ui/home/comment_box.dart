import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_project/ui/home/home_model.dart';
import 'package:instagram_project/ui/home/home_view_model.dart';
import 'package:provider/provider.dart';

class CustomCommentBox extends StatelessWidget {
  CustomCommentBox({required this.image, required this.index, super.key});
  final TextEditingController _textEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final UnsplashImage image;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: 602.h,
                  width: 393.w,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.h,
                      vertical: 10.h,
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'Comments',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child:
                              image.commentsList != null &&
                                      image.commentsList!.isEmpty
                                  ? Center(
                                    child: Text(
                                      'No Comments',
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                  : ListView.builder(
                                    itemCount: image.commentsList?.length,
                                    itemBuilder: (context, index) {
                                      return CustomCommentsList(
                                        comment: image.commentsList![index],
                                        image: image,
                                      );
                                    },
                                  ),
                        ),
                        
                        Form(
                          key: formKey,
                          child: TextFormField(
                            controller: _textEditingController,

                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(right: 8.0.w),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    '${image.urls?.regular}',
                                  ),
                                  radius: 18.r,
                                ),
                              ),
                              labelText: 'Add a comment',
                              labelStyle: TextStyle(
                                color: const Color.fromARGB(255, 230, 222, 222),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                            onSaved: (newValue) {
                              model.addcomment(
                                comment: newValue ?? 'no comments',
                                index: index,
                              );
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'pleases add a comment';
                              } else {
                                return null;
                              }
                            },
                            onFieldSubmitted: (value) {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                              }
                              _textEditingController.clear();
                              FocusScope.of(context).unfocus();
                            },
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Icon(Icons.comment_outlined, color: Colors.white, size: 30.sp),
        );
      },
    );
  }
}

class CustomCommentsList extends StatelessWidget {
  const CustomCommentsList({
    required this.comment,
    required this.image,
    super.key,
  });

  final String comment;
  final UnsplashImage image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundImage: NetworkImage('${image.urls?.regular}'),
          ),
          10.horizontalSpace,
          Text(
            comment,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
