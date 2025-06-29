import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ArticleView extends StatelessWidget {
  final String blogUrl;
  const ArticleView({super.key, required this.blogUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ECHO', style: TextStyle(color: Colors.black)),
            Text(
              'NOW',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(blogUrl)),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            useShouldOverrideUrlLoading: true,
            javaScriptEnabled: true,
          ),
        ),
      ),
    );
  }
}