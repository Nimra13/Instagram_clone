import 'package:instagram_project/ui/home/home_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UnsplashImageServices {
  List<UnsplashImage> images = [];

  Future<List<UnsplashImage>> fetchImages() async {
    print("@fetchImages");
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

        // for (int i = 0; i < images.length; i++) {
        //   print("@fetchImages [$i] IMAGE SRC: ${images[i].urls?.regular}");
        // }
        return images;
      } else {
        print("@fetchImages: No Data");
        return images;
      }
    } else {
      print("@fetchImages FAILURE");

      throw Exception('failed to load');
    }
  }
}
