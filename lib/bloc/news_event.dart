part of 'news_bloc.dart';

@immutable
sealed class NewsEvent {}

class NewsListFetchInitial extends NewsEvent {}

class NewsLoadMore extends NewsEvent {}
