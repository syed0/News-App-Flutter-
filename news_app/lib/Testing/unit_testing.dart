
import 'dart:async';
import 'package:news_app/home_page_bloc.dart';
import 'package:news_app/news_api_call.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:core';
import 'package:news_app/news_modal.dart';


void main(){
  group('Testing List', ()
  {
    test("Testing the List", () {
      final newsBlock = NewsBlock();
      newsBlock.data.add(NewsData());
      expect(newsBlock.data.length, 1);
    });
    test("Testing the list after API call", () {
      final newsBlock = NewsBlock();
      newsBlock.getData().then((value) =>
          expect(newsBlock.data.isEmpty, false));
    });
    test("Testing Bloc", () {
      final newsBlock = NewsBlock();
      HomePageBloc homePageBloc = HomePageBloc();
      newsBlock.getData().then((apiValue) {
        homePageBloc.newsSink.add(apiValue);
        homePageBloc.newsStream.listen((value) {
          expect(apiValue, value);
        });
      });
    });
  });
}