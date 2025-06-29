import 'package:news_app/models/category_model.dart';

 List<CategoryModel> getCategory() {
  List<CategoryModel> category = [];

  category.add(
    CategoryModel(
      image: 'assets/images/business.jpg',
      categoryName: 'Business',
    ),
  );
  category.add(
    CategoryModel(
      image: 'assets/images/entertainment.jpg',
      categoryName: 'Entertainment',
    ),
  );
  category.add(
    CategoryModel(image: 'assets/images/health.jpg', categoryName: 'Health'),
  );
  category.add(
    CategoryModel(image: 'assets/images/football.jpg', categoryName: 'Sports'),
  );
  category.add(
    CategoryModel(image: 'assets/images/general.jpg', categoryName: 'General'),
  );
  return category;
}
