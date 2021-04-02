import 'dart:convert';
import 'package:news_app/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/news_modal.dart';

class NewsBlock{
    List<NewsData> data = [];
   Future<List<NewsData>>  getData () async {
     final url = "${AppConstants.instance.newsApiUrl}?country=${AppConstants.instance.country}&apiKey=${AppConstants.instance.apiKey}";
     print(url);
     final response = await http.get(url);
     final jsonData = jsonDecode(response.body);
     final articles = jsonData['articles'];
     for (var i = 0; i < articles.length; i++) {
       var article = articles[i];
       var eachSource = article['source'];
       data.add(NewsData(json: article));
       print(data);
     }
       return data;

   }
}