import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/api_services.dart';
part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  Future<void> fetchArticles() async {
    emit(NewsLoading());
    try {
      final data = await ApiServices().fetchArticles();
      emit(NewsSuccess(data));
    } catch (e) {
      emit(NewsFailed(e.toString()));
    }
  }
}