
class NewsData{

  NewsData({this.json});
  final json;
  Source get source => Source(id: json['id'], name: json['name']);
  String get author => json['author'];
  String get title => json['title'];
  String get dis => json['description'];
  String get urlToImage => json['urlToImage'];
  String get webViewUrl => json['url'];
}
class Source{

  Source({this.id, this.name});
  final String id;
  final String name;
}