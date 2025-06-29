import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/slider_model.dart';
import 'package:news_app/screen/article_view.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/services/slider_data.dart';

class AllNews extends StatefulWidget {
  final String news;
  const AllNews({super.key, required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  void initState() {
    super.initState();

    Future.wait([getslider(), getnews()]).then((_) {
      setState(() => _loading = false);
    });
  }

  List<SliderModel> sliders = [];
  List<ArticleModel> articles = [];
  bool _loading = true;
  Future<void> getnews() async {
    News newsClass = News();
    await newsClass.getnews();
    articles = newsClass.news;
    setState(() {
      
    });
  }

  Future<void> getslider() async {
    Sliders slidersc = Sliders();
    await slidersc.getsliderdata();
    sliders = slidersc.slidelist;
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(backgroundColor: Colors.white,
        title: Text(widget.news, style: TextStyle(color: Colors.blue)),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: _loading
              ? Center(child: CircularProgressIndicator(color: Colors.blue))
              : articles.isEmpty
              ? Center(child: Text('No news found'))
              : ListView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: widget.news=='Breaking'?sliders.length: articles.length,
                itemBuilder: (context, index) {
                  return AllNewsSection(
                    image: widget.news=='Breaking'?sliders[index].urlToImage!: articles[index].urlToImage!,
                    desc: widget.news=='Breaking'?sliders[index].description!: articles[index].description!,
                    title:  widget.news=='Breaking'?sliders[index].title!: articles[index].title!,
                    url:  widget.news=='Breaking'?sliders[index].url!: articles[index].url!,
                  );
                },
              ),);
  }
}

class AllNewsSection extends StatelessWidget {
  final String image, desc, title, url;
  const AllNewsSection({
    super.key,
    required this.image,
    required this.desc,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)),
          ),
      child: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              title,
              maxLines: 2,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(desc),
          ],
        ),
      ),
    );
  }
}
