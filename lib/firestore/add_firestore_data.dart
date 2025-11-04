import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_project/ui/auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFirestoreData extends StatelessWidget {
  AddFirestoreData({super.key});

  final postController = TextEditingController();
  final _postController = TextEditingController();

  final fireStore = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'Add a Note',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          children: [
            20.verticalSpace,
            TextFormField(
              controller: postController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'Add your today task',
                hintStyle: TextStyle(fontWeight: FontWeight.w600),
                border: OutlineInputBorder(),
              ),
            ),
            20.verticalSpace,
            Expanded(
              child: TextFormField(
                controller: _postController,
                maxLines: 20,
                decoration: InputDecoration(
                  hintText: 'What is in your mind?',
                  hintStyle: TextStyle(fontWeight: FontWeight.w600),
                  border: InputBorder.none,
                  // enabledBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.transparent),
                  // ),
                ),
              ),
            ),
            20.verticalSpace,
            CustomElevatedButton(
              text: 'Add',
              onPressed: () {
                String id = DateTime.now().millisecondsSinceEpoch.toString();

                fireStore
                    .doc(id)
                    .set({
                      'title': postController.text.toString(),
                      'id': id,
                      'subtitle': _postController.text.toString(),
                    })
                    .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Successfully Added")),
                      );
                    })
                    .onError((error, stackTrace) {
                      print("object: $error");
                      print(stackTrace);
                    });
              },

              color: Colors.black,
              textcolor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
