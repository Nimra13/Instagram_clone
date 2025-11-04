import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_project/firestore/add_firestore_data.dart';
import 'package:intl/intl.dart';

class FirestoreScreen extends StatefulWidget {
  const FirestoreScreen({super.key});


  @override
  State<FirestoreScreen> createState() => _FirestoreScreenState();
}

class _FirestoreScreenState extends State<FirestoreScreen> {
  // final TextEditingController _searchcontroller = TextEditingController();
  TextEditingController _editcontroller = TextEditingController();
  TextEditingController editcontroller = TextEditingController();

  final fireStore = FirebaseFirestore.instance.collection('users').snapshots();

  CollectionReference ref = FirebaseFirestore.instance.collection('users');

  // List<dynamic> list = [];

  String searchfilter = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'My Notepad',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Get.to(() => AddFirestoreData());
        },
        child: Icon(Icons.edit, color: Colors.white),
      ),
      body: Column(
        children: [
          20.verticalSpace,
          StreamBuilder<QuerySnapshot>(
            stream: fireStore,
            builder: (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting)
                CircularProgressIndicator();

              if (snapshot.hasError) return Text('Error occured');

              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 10.h,
                      ),
                      child: Card(
                        child: ListTile(
                          tileColor: const Color.fromARGB(255, 204, 247, 155),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            side: BorderSide(color: Colors.deepOrange),
                          ),

                          title: Text(
                            // snapshot.data!.docs[index].data().toString(),
                            snapshot.data!.docs[index]['title'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.docs[index]['subtitle']
                                    .toString(),
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Align(
                                alignment: AlignmentGeometry.bottomRight,
                                child: Text(
                                  convertToData(
                                    snapshot.data!.docs[index]['id'].toString(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          trailing: PopupMenuButton(
                            icon: Icon(Icons.more_vert),
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  onTap: () {
                                    try {
                                      showMyDialog(
                                        snapshot.data!.docs[index]['title']
                                            .toString(),
                                        snapshot.data!.docs[index]['subtitle']
                                            .toString(),
                                        snapshot.data!.docs[index]['id']
                                            .toString(),
                                      );
                                    } catch (e, s) {
                                      print('error: $e');
                                      print('stacktrace: $s');
                                    }
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
                                      ref
                                          .doc(
                                            snapshot.data!.docs[index]['id']
                                                .toString(),
                                          )
                                          .delete();
                                    },
                                    leading: Icon(Icons.delete),
                                    title: Text('Delete'),
                                  ),
                                ),
                              ];
                            },
                          ),
                          isThreeLine: true,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> showMyDialog(String title, String subtitle, String id) async {
    _editcontroller.text = title;
    editcontroller.text = subtitle;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update'),
          content: SizedBox(
            height: 200.h,
            width: 300.w,
            child: Column(
              children: [
                TextFormField(
                  controller: _editcontroller,
                  decoration: InputDecoration(hintText: 'Edit'),
                ),
                TextFormField(
                  controller: editcontroller,
                  decoration: InputDecoration(hintText: 'Edit subtitle'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Get.off(context);
                Get.back();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ref
                    .doc(id)
                    .update({
                      'title': _editcontroller.text,
                      'subtitle': editcontroller.text,
                    })
                    .then((value) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('updated')));
                    })
                    .onError((error, stackTrace) {
                      print("error: $error");
                      print('stackTrace: $stackTrace');
                    });
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  convertToData(String timeInString) {
    int millis = int.parse(timeInString);
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millis);
    String formattedDate = DateFormat('MM/dd/yyyy, hh:mm a').format(dateTime);

    return formattedDate;
  }
}
