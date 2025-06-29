import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screen/article_view.dart';

class ShowCategory extends StatelessWidget {
  final String image, desc, title,url;
  const ShowCategory({
    super.key,
    required this.image,
    required this.desc,
    required this.title,
    required this.url
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticleView(blogUrl: url))),
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
            Text(title,maxLines: 2, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            Text(desc),
          ],
        ),
      ),
    );
  }
}
