import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_project/ui/home/add_post.dart';

class PostDatabase extends StatefulWidget {
  PostDatabase({super.key});

  @override
  State<PostDatabase> createState() => _PostDatabaseState();
}

class _PostDatabaseState extends State<PostDatabase> {
  final ref = FirebaseDatabase.instance.ref('Posts');

  final TextEditingController _searchcontroller = TextEditingController();
  final TextEditingController _editcontroller = TextEditingController();
  List<dynamic> list = [];

  String searchfilter = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'Post',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddPost());
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          20.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: TextFormField(
              controller: _searchcontroller,
              decoration: InputDecoration(
                hintText: 'search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchfilter = value;
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: ref.onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  Map<dynamic, dynamic> map =
                      snapshot.data!.snapshot.value as dynamic;

                  list.clear();
                  list = map.values.toList();

                  if (searchfilter.isNotEmpty) {
                    list =
                        list
                            .where(
                              (element) =>
                                  element['title'].contains(searchfilter),
                            )
                            .toList();
                  }

                  return ListView.builder(
                    itemCount:
                        searchfilter.isNotEmpty
                            ? list.length
                            : snapshot.data!.snapshot.children.length,
                    itemBuilder: (context, index) {
                      final title = list[index]['title'];

                      return ListTile(
                        title: Text(list[index]['title']),
                        subtitle: Text(list[index]['id']),
                        trailing: PopupMenuButton(
                          icon: Icon(Icons.more_vert),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                onTap: () {
                                  showMyDialog(title, list[index]['id']);
                                },
                                value: 1,
                                child: ListTile(
                                  leading: Icon(Icons.edit),
                                  title: Text('Edit'),
                                ),
                              ),
                              PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  onTap: () {
                                    Get.back();
                                    ref.child(list[index]['id']).remove();
                                  },
                                  leading: Icon(Icons.delete),
                                  title: Text('Delete'),
                                ),
                              ),
                            ];
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    _editcontroller.text = title;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update'),
          content: TextFormField(
            controller: _editcontroller,
            decoration: InputDecoration(hintText: 'Edit'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ref
                    .child(id)
                    .update({'title': _editcontroller.text})
                    .then((value) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("post updated")));
                    })
                    .onError((error, stackTrace) {
                      print("object: $error");
                      print(stackTrace);
                    });
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}


// Expanded(
//             child: StreamBuilder(
//               stream: ref.onValue,
//               builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
//                 if (!snapshot.hasData) {
//                   return CircularProgressIndicator();
//                 } else {
//                   Map<dynamic, dynamic> map =
//                       snapshot.data!.snapshot.value as dynamic;
//                   List<dynamic> list = [];
//                   list.clear();
//                   list = map.values.toList();

//                   return ListView.builder(
//                     itemCount: snapshot.data!.snapshot.children.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(list[index]['title']),
//                         subtitle: Text(list[index]['id']),
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           ),



 // Expanded(
          //   // FirebaseAnimatedList is a widget while stream is not.
          //   child: FirebaseAnimatedList(
          //     query: ref,
          //     itemBuilder: (context, snapshot, animation, index) {
          //       return ListTile(
          //         title: Text(snapshot.child('title').value.toString()),
          //         subtitle: Text(snapshot.child('id').value.toString()),
          //       );
          //     },
          //   ),
          // ),