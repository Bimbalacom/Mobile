import 'dart:async';
import 'package:webview_part2/wigets/custom_button.dart';
import 'package:webview_part2/wigets/logic.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

WebViewController? controllerGlobal;

class WebViewPage extends StatefulWidget {
  WebViewPage({Key? key, required this.place}) : super(key: key);
  String place;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
//navigation
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  String favorit = '';

  _exitApp(BuildContext context) async {
    if (await controllerGlobal!.canGoBack()) {
      controllerGlobal!.goBack();
    } else {
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(
        const SnackBar(content: Text("No back history item")),
      );
      return Future.value(false);
    }
  }
//end navigation

  void Gonext() {
    setState(() {
      var x = _favorites.single.toString();
      WebViewPage(place: x);
    });
  }

  final Set<String> _favorites = <String>{};

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          toolbarOpacity: 0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[NavigationControls(_controller.future)],
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            WebView(
              initialUrl: 'https://${widget.place}.bimbala.com/',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
            ),
            Positioned(
              bottom: 0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue,
                    child: IconButton(
                      onPressed: () {},
                      icon: PopupMenuButton(
                        onSelected: (result) {
                          if (result == 0) {
                            //_scaffoldKey.currentState!.openDrawer();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WebViewGit()));
                          }
                          if (result == 1) {}
                        },
                        child: const Icon(Icons.menu,
                            color: Colors.white, size: 25),
                        itemBuilder: (BuildContext context) {
                          return [
                            // const PopupMenuItem(
                            //     value: 0, child: Text('Favorites')),
                            const PopupMenuItem(value: 0, child: Text('GitHub'))
                          ];
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        drawerEnableOpenDragGesture: false, // Stopping draggable
        drawer: Drawer(
          child: Column(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blueAccent),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Workplaces',
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                ),
              ),
              Expanded(
                child: FutureBuilder<int>(builder: (context, snapshot) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          //Gonext();
                        },
                        child: ListTile(
                          minLeadingWidth: 1,
                          title: Text(
                            favorit,
                            // 'hello',
                            style: const TextStyle(fontSize: 17),
                          ),
                          leading:
                              const Icon(Icons.favorite, color: Colors.red),
                        ),
                      );
                    },
                  );
                }),
              ),
              Container(
                height: 130,
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        // saveData(widget.place);
                        // readData();
                      },
                      child: CustomButton(
                          text: ' Add Current Workspace ',
                          icon: Icons.favorite),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomePage()));
                      },
                      child: CustomButton(
                          text: ' Add Workspace ',
                          icon: Icons.add_circle_outline),
                    ),
                    InkWell(
                      onTap: () {},
                      child: CustomButton(
                          text: ' Metal Help ? ', icon: Icons.help_outlined),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Ne znam kakvo pravi ama raboti xD
// Navigaciq
class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final WebViewController controller = snapshot.data!;
        controllerGlobal = controller;
        return Container();
      },
    );
  }
}
