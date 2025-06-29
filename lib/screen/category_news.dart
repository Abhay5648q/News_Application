import 'package:flutter/material.dart';
import 'package:news_app/models/show_category.dart';
import 'package:news_app/screen/show_category.dart';
import 'package:news_app/services/show_category_news.dart';

class CategoryNews extends StatefulWidget {
  final String? title;
  const CategoryNews({super.key, required this.title});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories = [];
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    getnews();
  }

  getnews() async {
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    await showCategoryNews.getcategoriesnewsdata(
      widget.title?.toLowerCase() ?? '',
    );
    categories = showCategoryNews.categories;
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        title: Text(widget.title ?? '', style: TextStyle(color: Colors.blue)),
        elevation: 0.0,
        centerTitle: true,
      ),
      body:
          _loading
              ? Center(child: CircularProgressIndicator(color: Colors.blue))
              : categories.isEmpty
              ? Center(child: Text('No news found'))
              : ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return ShowCategory(
                    image: categories[index].urlToImage ?? '',
                    desc: categories[index].description ?? '',
                    title: categories[index].title ?? '',
                    url: categories[index].url??'',
                  );
                },
              ),
    );
  }
}
