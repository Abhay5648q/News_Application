import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/show_category.dart';

class ShowCategoryNews {
  
  List<ShowCategoryModel>categories = [];
  Future<void> getcategoriesnewsdata(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=0aed23c9c848420994f2a5b24610d832";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) { 
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 'ok') {
        jsonData['articles'].forEach((element) {
          if (element['urlToImage'] != null &&
              element["urlToImage"].toString().isNotEmpty &&
              element['description'] != null) {
            ShowCategoryModel showCategoryModel = ShowCategoryModel(
              author: element['author'] ?? "",
              url: element['url'] ?? "",
              urlToImage: element["urlToImage"] ?? "",
              title: element["title"] ?? "",
              description: element["description"] ?? "",
              content: element["content"] ?? "",
            );
            categories.add(showCategoryModel);
          }
        });
      }
    }
  }
}