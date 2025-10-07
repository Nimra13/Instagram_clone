import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:instagram_project/ui/home/home_model.dart';
import 'package:http/http.dart' as http;

class HomeViewModel extends ChangeNotifier {
  List<UnsplashImage> images = [];

  bool isloading = false;
 

  HomeViewModel() {
    print("@homeViewModel constructor call!");
    fetchImages();
  }

  fetchImages() async {
    print("@fetchImages");

    isloading = true;
    notifyListeners();

    final response = await http.get(
      Uri.parse(
        'https://api.unsplash.com/photos/?client_id=og1m6ycDo2L-57o-8RWn6H0pcBlEdruM2Au957bqk2s',
      ),
    );

    // print("@fetchImages response: ${response.body.toString()}");

    if (response.statusCode == 200) {
      print("@fetchImages SUCCESS");
      if (response.body != null) {
        List<dynamic> myJson = json.decode(response.body);
        images =
            myJson
                .map<UnsplashImage>((j) => UnsplashImage.fromJson(j))
                .toList();
      }
    } else {
      print("@fetchImages FAILURE");

      throw Exception('failed to load');
    }

    isloading = false;
    notifyListeners();
  }

  void toggleliked({required int index}){
    images[index].isliked =! (images[index].isliked ?? false);
    notifyListeners();
  }
}
