import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:news_bloc_app/api/news_api.dart';
import 'package:news_bloc_app/model/news_model.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  List<NewsModel> newsModel = [];

  NewsBloc() : super(NewsFetchingListInitial()) {
    on<NewsListFetchInitial>(newsinitialfetchEvent);
    on<NewsLoadMore>(newsLoadMore);
  }

  Future<void> newsinitialfetchEvent(
    NewsListFetchInitial event,
    Emitter<NewsState> emit,
  ) async {
    emit(NewsFetchingLoadingState());
    await _requestAndAddNews();
    emit(NewsFetchingSuccessfulState(newsModel: newsModel));
  }

  FutureOr<void> newsLoadMore(
    NewsLoadMore event,
    Emitter<NewsState> emit,
  ) async {
    await _requestFetchMore();
    emit(NewsFetchingSuccessfulState(newsModel: newsModel));
  }

  FutureOr<void> _requestAndAddNews() async {
    newsModel.clear;

    List<NewsModel> list = await NewsApi().newsModel(
      count: 100,
      page: 1,
      query: 'Kazakhstan',
    );

    newsModel.addAll(list);
  }

  FutureOr<void> _requestFetchMore() async {
    List<NewsModel> list = await NewsApi().newsModel(
      count: 100,
      page: 1,
      query: 'Kazakhstan',
    );

    newsModel.addAll(list);
  }
}
