import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

Widget NewsWebView({String url, Key key}){

    return WebView(initialUrl: url,
    key: key,);

}