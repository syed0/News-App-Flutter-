
import 'dart:async';
import 'package:news_app/news_api_call.dart';

enum HttpRequest{ Getdata, PostData}

class HomePageBloc{
  StreamController newsStreamController = StreamController();
  Stream get newsStream => newsStreamController.stream;
  StreamSink get newsSink => newsStreamController.sink;
  void apiCall(HttpRequest httpRequest){
    NewsBlock newsBlock = NewsBlock();
    if (httpRequest == HttpRequest.Getdata){
        newsBlock.getData().then((value) =>  newsSink.add(value));

    }
  }

}