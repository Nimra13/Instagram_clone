import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_project/ui/auth/login.dart';

class AddPost extends StatelessWidget {
  AddPost({super.key});

  final postController = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.ref('Posts');

  String id = DateTime.now().microsecondsSinceEpoch.toString();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'Add Post',
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
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'What is in your mind?',
                hintStyle: TextStyle(fontWeight: FontWeight.w600),
                border: OutlineInputBorder(),
              ),
            ),
            20.verticalSpace,
            CustomElevatedButton(
              text: 'Add',
              onPressed: () {
                databaseRef
                    .child(id)
                    .set({'title': postController.text.toString(), 'id': id})
                    .then((value) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("Success!!!")));
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



// CustomElevatedButton(
//               text: 'Add',
//               onPressed: () {
//                 databaseRef
//                     .child(DateTime.now().microsecondsSinceEpoch.toString())
//                     .set({
//                       'title': postController.text.toString(),
//                       'id': DateTime.now().microsecondsSinceEpoch.toString(),
//                     })
//                     .then((value) {
//                       ScaffoldMessenger.of(
//                         context,
//                       ).showSnackBar(SnackBar(content: Text("Success!!!")));
//                     })
//                     .onError((error, stackTrace) {
//                       print("object: $error");
//                       print(stackTrace);
//                     });
//               },
//               color: Colors.black,
//               textcolor: Colors.white,
//             ),