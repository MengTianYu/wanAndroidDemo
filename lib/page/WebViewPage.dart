import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/bean/WebBean.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  String Url;
  String title;

  @override
  Widget build(BuildContext context) {
    WebBean wb = ModalRoute.of(context).settings.arguments;
    title = wb.title;
    Url = wb.Url;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: WebView(
        initialUrl: Url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
