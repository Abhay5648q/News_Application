import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/models/slider_model.dart';
import 'package:news_app/screen/all_news.dart';
import 'package:news_app/screen/blog_tile.dart';
import 'package:news_app/screen/category_tile.dart';
import 'package:news_app/services/category_data.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/services/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<SliderModel> sliders = [];
  List<ArticleModel> articles = [];
  bool _loading = true;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    categories = getCategory();
    Future.wait([getslider(), getnews()]).then((_) {
      setState(() => _loading = false);
    });
  }

  Future<void> getnews() async {
    News newsClass = News();
    await newsClass.getnews();
    articles = newsClass.news;
  }

  Future<void> getslider() async {
    Sliders slidersc = Sliders();
    await slidersc.getsliderdata();
    sliders = slidersc.slidelist;
  }

  Widget buildIndicator(context) {
    return AnimatedSmoothIndicator(
      effect: SlideEffect(
        dotWidth: 10,
        dotHeight: 10,
        activeDotColor: Colors.blue,
      ),
      activeIndex: activeIndex,
      count: sliders.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final validArticles = articles
        .where(
          (a) =>
              a.url != null &&
              a.url!.isNotEmpty &&
              Uri.tryParse(a.url!) != null,
        )
        .toList();
    return Scaffold(
      appBar: _appBar(),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            )
          : ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  height: 95,
                  child: listview(),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Breaking News",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>AllNews(news: 'Breaking'))),
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
               
                  carouselSlider(),
                
                  const SizedBox(height: 10),
             
                  Center(child: buildIndicator(context)),
                const SizedBox(height: 10),
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Trending News",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>AllNews(news: 'Trending'))),
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ...validArticles.map(
                (article) => BlogTile(
                  url: article.url,
                  imageUrl: article.urlToImage,
                  title: article.title,
                  description: article.description,
                ),
              )
              ],
            ),
    );
  }

  CarouselSlider carouselSlider() {
    return CarouselSlider.builder(
      itemCount: sliders.length,
      itemBuilder: (context, index, realIndex) {
        final image = sliders[index].urlToImage;
        final name = sliders[index].title;

        return buildImage(image, name);
      },
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayInterval: const Duration(seconds: 3),
        onPageChanged: (index, reason) => setState(() => activeIndex = index),
      ),
    );
  }

  Widget buildImage(String? image, String? name) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: image ?? "",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[300],
                height: 120,
                width: 120,
                child: Center(child: CircularProgressIndicator(color: Colors.blue,)),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
                height: 120,
                width: 120,
                child: Icon(
                  Icons.broken_image,
                  color: Colors.grey,
                  size: 48,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Text(
                name ?? "",
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listview() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return CategoryTile(
          image: categories[index].image,
          catrgoryname: categories[index].categoryName,
        );
      },
    );
  }

  AppBar _appBar() => AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ECHO', style: TextStyle(color: Colors.black)),
            Text(
              'NOW',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        elevation: 0.0,
        centerTitle: true,
      );
}