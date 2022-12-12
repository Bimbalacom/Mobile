import 'dart:async';
import 'dart:io';
import 'package:bimbala/view/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// WebViewController? _webViewController;
WebViewController? controllerGlobal;

/*

This component was created to open a full URL page
with the ability to go back to StartScreen without relying
on a user dashboard name.

*/
class WebViewUrlScreen extends StatefulWidget {
  const WebViewUrlScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  State<WebViewUrlScreen> createState() => _WebViewUrlScreenState();
}

class _WebViewUrlScreenState extends State<WebViewUrlScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  Future<bool> _onWillPop(BuildContext context) async {
    if (await _controller!.canGoBack()) {
      _controller!.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        key: _scaffoldKey,

        // ~ WebView
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: WebView(
              initialUrl: widget.url,
              // initialUrl: 'https://bimbala.com/',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controllerCompleter.future
                    .then((value) => _controller = value);
                _controllerCompleter.complete(webViewController);
              },
            ),
          ),
        ),

        // ~ Bottom Right button
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text('Current place: ${widget.url}'),
            ),
            IconButton(
              onPressed: () {},
              icon: PopupMenuButton(
                onSelected: (item) {
                  if (item == 1) {
                    openHomeScreen();
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuItem>[
                  const PopupMenuItem(
                    value: 1,
                    child: Text('Back to Home'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => StartScreen(),
      ),
    );
  }
}
