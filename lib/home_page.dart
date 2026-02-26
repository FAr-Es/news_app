import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/news_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<NewsModel> newsItem = NewsModel.newsItem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Color.fromARGB(255, 233, 238, 250),
        title: Padding(
          padding: const EdgeInsets.only(left: 32, top: 12 + 59, bottom: 16),
          child: Text(
            'News',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
          ),
        ),
        toolbarHeight: 127,
      ),

      body: ListView.separated(
        padding: EdgeInsets.only(top: 24),
        itemCount: newsItem.length,
        itemBuilder: (context, index) {
          final NewsModel news = newsItem[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return NewsDetails(newsModel: news);
                  },
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          news.subtitle,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color.fromARGB(255, 148, 141, 142),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 16),

                Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      news.image,
                      width: 112,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 24);
        },
      ),
    );
  }
}
