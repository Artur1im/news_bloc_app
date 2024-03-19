import 'package:news_bloc_app/api/api.dart';
import 'package:news_bloc_app/api/api_error.dart';
import 'package:news_bloc_app/model/news_model.dart';

class NewsApi extends Api {
  Future<List<NewsModel>> newsModel({required int count}) async {
    try {
      Map<String, dynamic> data = await get('/', params: {
        'articles': count.toString(),
      });

      return NewsModel.fromJsonToList(data);
    } on ApiError catch (_) {
      return [];
    }
  }
}
