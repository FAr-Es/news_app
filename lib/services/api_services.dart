import 'package:dio/dio.dart';
import 'package:news_app/models/news_model.dart';

class ApiServices {
  final dio = Dio();

  Future <NewsModel>fetchArticles() async {
    final response = await dio.get(
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=43cafb2de81b4de691d7862a8ee4ef57',
    );
    return NewsModel.fromJson(response.data);
  }
}
