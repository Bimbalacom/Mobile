import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WikipediaExplorer extends StatefulWidget {
  @override
  _WikipediaExplorerState createState() => _WikipediaExplorerState();
}

class _WikipediaExplorerState extends State<WikipediaExplorer> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  final Set<String> _favorites = Set<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: WebView(
        initialUrl: 'https://en.wikipedia.org/wiki/Kraken',
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }

  bookmarkButton() {
    return FutureBuilder<WebViewController>(
      future: _controller.future,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        if (controller.hasData) {
          return FloatingActionButton(
            onPressed: () async {
              var url = await controller.data!.currentUrl();
              _favorites.add(url!);
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('Added to WorkSpaces.')),
              );
            },
            child: Icon(Icons.favorite),
          );
        }
        return Container();
      },
    );
  }
}
