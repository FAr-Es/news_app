part of 'news_cubit.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}
final class NewsLoading extends NewsState {
  
}
final class NewsSuccess extends NewsState {
  final NewsModel data;
  NewsSuccess(this.data);
}
final class NewsFailed extends NewsState {
  final String message;
  NewsFailed(this.message);
}
