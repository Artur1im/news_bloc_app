class NewsModel {
  String? author;
  String title;
  String? description;
  String? url;
  String? urlToImage;
  String publishedAt;
  String content;

  NewsModel.fromJson(Map<String, dynamic> data)
      : author = data['author'],
        title = data['title'],
        description = data['description'],
        url = data['url'],
        urlToImage = data['urlToImage'],
        publishedAt = data['publishedAt'],
        content = data['content'];

  static List<NewsModel> fromJsonToList(Map<String, dynamic> data) {
    List<NewsModel> response = [];
    for (Map<String, dynamic> item in data['articles']) {
      response.add(NewsModel.fromJson(item));
    }

    return response;
  }
}
