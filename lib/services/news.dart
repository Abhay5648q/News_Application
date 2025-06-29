import 'dart:convert';
import 'package:news_app/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];
  Future<void> getnews() async {
    String url = "https://newsapi.org/v2/everything?q=apple&from=2025-06-28&to=2025-06-28&sortBy=popularity&apiKey=0aed23c9c848420994f2a5b24610d832";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 'ok') {
        jsonData['articles'].forEach((element) {
          if (element['url'] != null && element['title'] != null) {
            ArticleModel articleModel = ArticleModel(
              title: element['title'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content'],
            );
            news.add(articleModel);
          }
        });
      }
    }
  }
}