import 'package:flutter/material.dart';
import 'package:instagram_project/ui/home/home_view_model.dart';
import 'package:provider/provider.dart';

class SavedPost extends StatelessWidget {
  const SavedPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder:
          (context, model, child) => Scaffold(
            backgroundColor: Colors.black,
            body: GridView.builder(
              itemCount: model.savedPosts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // number of items in each row
                mainAxisSpacing: 8.0, // spacing between rows
                crossAxisSpacing: 8.0, // spacing between columns
              ),
              itemBuilder: (context, index) {
                return Container(
                  child: Image.network(
                    model.savedPosts[index].urls?.regular ?? '',
                  ),
                );
              },
            ),
          ),
    );
  }
}
