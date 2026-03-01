import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/controller/cubit/news_cubit.dart';
import 'package:news_app/news_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  void initState() {
    super.initState();
    context.read<NewsCubit>().fetchArticles();
  }

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

      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
          if (state is NewsSuccess) {
            final data = state.data;
            return ListView.separated(
              padding: EdgeInsets.only(top: 24),
              itemCount: data.articles!.length,

              itemBuilder: (context, index) {
                final model = data.articles![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return NewsDetails(article: model);
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
                                model.title.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                model.description ?? "...",
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
                          child: Image.network(
                            model.urlToImage ??
                                "https://placehold.co/112x80.png",
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
            );
          }
          if(state is NewsFailed){
            return Center(child: Text(state.message));
          }
            return Center(child: Text("No Data"));
          
        },
      ),
    );
  }
}
