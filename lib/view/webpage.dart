import 'dart:async';
import 'dart:io';
import 'package:bimbala/view/drawer.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// WebViewController? _webViewController;
WebViewController? controllerGlobal;

class WebViewScreen extends StatefulWidget {
  WebViewScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  String user;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
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

        //~ Drawer
        drawerEnableOpenDragGesture: false,
        drawer: DrawerG(user: widget.user),

        // ~ WebView
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: WebView(
              initialUrl: 'https://${widget.user}.bimbala.com/',
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
              child: Text('Current place: ${widget.user}'),
            ),
            IconButton(
              onPressed: () {},
              icon: PopupMenuButton(
                onSelected: (item) {
                  if (item == 1) {
                    _scaffoldKey.currentState?.openDrawer();
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuItem>[
                  const PopupMenuItem(
                    value: 1,
                    child: Text('See favorites'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
