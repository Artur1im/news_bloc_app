import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_bloc_app/bloc/news_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NewsBloc newsBloc = NewsBloc();

  @override
  void initState() {
    newsBloc.add(NewsListFetchInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      child: SingleChildScrollView(
        child: BlocBuilder<NewsBloc, NewsState>(
          bloc: newsBloc,
          builder: (context, state) {
            if (state is NewsFetchingLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else if (state is NewsFetchingSuccessfulState) {
              return SizedBox(
                  child: ListView.builder(
                itemCount: newsBloc.newsModel.length,
                itemBuilder: (context, index) {
                  final user = state.newsModel[index];
                  return Card();
                },
              ));
            } else {
              return const Center(
                child: Text("Error"),
              );
            }
          },
        ),
      ),
    ));
  }
}
