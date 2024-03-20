import 'package:news_bloc_app/api/api.dart';
import 'package:news_bloc_app/api/api_error.dart';
import 'package:news_bloc_app/model/news_model.dart';

class NewsApi extends Api {
  Future<List<NewsModel>> newsModel({
    required int count,
    required int page,
    required String query,
  }) async {
    try {
      Map<String, dynamic> data = await get('everything', params: {
        'q': query,
        'pageSize': count.toString(),
        'page': page.toString(),
      });

      return NewsModel.fromJsonToList(data);
    } on ApiError catch (_) {
      return [];
    }
  }
}
