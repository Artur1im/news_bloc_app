part of 'news_bloc.dart';

sealed class NewsEvent {}

class NewsListFetchInitial extends NewsEvent {}

class NewsLoadMore extends NewsEvent {}
