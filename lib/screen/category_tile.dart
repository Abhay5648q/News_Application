import 'package:flutter/material.dart';
import 'package:news_app/screen/category_news.dart';

class CategoryTile extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final image, catrgoryname;
  const CategoryTile({super.key, this.image, this.catrgoryname});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>CategoryNews(title: catrgoryname))),
      child: Container(
        margin: EdgeInsets.only(right: 8),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                height: 95,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black26,
                ),
      
                alignment: Alignment.center,
                child: Text(
                  catrgoryname,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14,
                    shadows: [Shadow(blurRadius: 3, offset: Offset(1, 1))],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
