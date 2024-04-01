part of 'news_bloc.dart';

sealed class NewsState {}

class NewsFetchingListInitial extends NewsState {}

class NewsFetchingLoadingState extends NewsState {}

class NewsFetchingErrorState extends NewsState {}

class NewsFetchingSuccessfulState extends NewsState {
  final List<NewsModel> newsModel;

  NewsFetchingSuccessfulState({required this.newsModel});
}
