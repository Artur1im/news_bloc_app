import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_bloc_app/bloc/news_bloc.dart';
import 'package:news_bloc_app/model/news_model.dart';
import 'package:news_bloc_app/pages/3d.dart';
import 'package:news_bloc_app/widgets/custom_card.dart';
import 'package:news_bloc_app/widgets/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NewsBloc _newsBloc = NewsBloc();

  @override
  void initState() {
    _newsBloc.add(NewsListFetchInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewsBloc, NewsState>(
        bloc: _newsBloc,
        builder: (context, state) {
          if (state is NewsFetchingLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (state is NewsFetchingSuccessfulState) {
            return ListView.builder(
              itemCount: state.newsModel.length,
              itemBuilder: (context, index) {
                final NewsModel newsModel = state.newsModel[index];
                final Data data = Data(
                  author: newsModel.author,
                  title: newsModel.title,
                  description: newsModel.description,
                  url: newsModel.url,
                  urlToImage: newsModel.urlToImage,
                  publishedAt: newsModel.publishedAt,
                  content: newsModel.content,
                );
                return CustomCard(data: data);
              },
            );
          } else {
            return const Center(
              child: Text("Error"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.watch),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WebViewExample()),
            );
          }),
    );
  }

  @override
  void dispose() {
    _newsBloc.close();
    super.dispose();
  }
}
