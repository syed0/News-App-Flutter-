
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:news_app/app_constants.dart';
import 'package:news_app/news_api_call.dart';
import 'package:news_app/news_modal.dart';
import 'package:news_app/webView.dart';
import 'package:provider/provider.dart';

import 'home_page_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: AppConstants.instance.appThemeColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Provider(create: (context) => HomePageBloc(),
      child:  MyHomePage()),
     builder: EasyLoading.init()
     ,);
  }
}

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(AppConstants.instance.appName)),),
      body: NewsPageView(),
    );
  }

}

class NewsPageView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final homePageBloc = Provider.of<HomePageBloc>(context, listen: false) ;
    homePageBloc.apiCall(HttpRequest.Getdata);
    EasyLoading.show(status: "Loading");

    return StreamBuilder(
      stream: homePageBloc.newsStream ,
      builder: (context, snapshot){
        EasyLoading.dismiss(animation: true);
        if (snapshot.hasError){
          return Center(child: Text("${snapshot.error}"),);
        }else{
          if (snapshot.hasData){

            return Container(
              color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: PageView.builder(itemBuilder: (context, position){
                  print(snapshot.data);
                  return _pageViewCell(index: position, data: snapshot.data, context: context);
                },
                  itemCount: snapshot.data.length,
                  scrollDirection: Axis.vertical,),
              ),
            ) ;
          }else{
            return Container();
          }
        }
      },
    );
  }

}

Widget _pageViewCell({int index, List<NewsData> data, BuildContext context}){
  return Column(children: [
    SizedBox(height: 20,
    ),
    Text(data[index].title,
    style: TextStyle(fontWeight: FontWeight.bold,
    fontSize: 24)
    ),
    SizedBox(height: 20,
    ),
    _setImage(url: data[index].urlToImage),
    SizedBox(height: 20,
    ),
    Text(data[index].dis,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.w400,
            fontSize: 20,
        fontStyle: FontStyle.italic)
    ),
    SizedBox(height: 20,
    ),
    FlatButton(key: Key(AppConstants.instance.showMoreBtnKey),
        onPressed: () => {
    Navigator.push(context, MaterialPageRoute(builder: (context) => NewsWebView(url: data[index].webViewUrl, key: Key(AppConstants.instance.webViewKey))))
  },
        child: Text("Show more",
      style: TextStyle(fontWeight: FontWeight.bold,
      fontSize: 18)
    )
    ),
  ],) ;
}

Widget _setImage({String url}){
  if (url != null) {
    return Image.network(url,
    height: 150,);
  }else {
    return Image.asset("assets/error_loading_image.jpg",
    height: 150,);
  }
}
