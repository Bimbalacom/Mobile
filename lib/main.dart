import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(
      const MaterialApp(
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );

final textController = TextEditingController();
var t = textController.text;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(99, 102, 241, 1),
              Color.fromRGBO(99, 102, 241, 0.9),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  //shape: BoxShape.circle,
                  image: DecorationImage(
                    //fit: BoxFit.fill,
                    image: AssetImage(
                      'assetss/500x500.png',
                    ),
                  ),
                ),
              ),
            ),
            const Text(
              "Sub-Domain = Username",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 80,
                vertical: 20,
              ),
              child: TextFormField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
                controller: textController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  label: Text(
                    'Username',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const WebViewExample(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Go',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WebViewExample extends StatefulWidget {
  const WebViewExample({Key? key}) : super(key: key);

  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

WebViewController? controllerGlobal;

_exitApp(BuildContext context) async {
  if (await controllerGlobal!.canGoBack()) {
    controllerGlobal!.goBack();
  } else {
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "No back history item",
        ),
      ),
    );
    return Future.value(false);
  }
}

class _WebViewExampleState extends State<WebViewExample> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            NavigationControls(_controller.future),
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Builder(
          builder: (BuildContext context) {
            return WebView(
              initialUrl: 'https://$t.bimbala.com/',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
            );
          },
        ),
        drawer: Drawer(
          backgroundColor: Colors.blue[100],
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 60,
                    child: Text(
                      'WorkSpaces',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fi1.hdslb.com%2Fbfs%2Farchive%2F6677bf4a4697e30396ce925affdc2a73e476e402.jpg&f=1&nofb=1",
                  ),
                ),
                title: Text(
                  "Another Page!",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const <Widget>[
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Add Workspace'),
                  ),
                  ListTile(
                    leading: Icon(Icons.help),
                    title: Text('Help'),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopupMenuButton(
                icon: const Icon(
                  Icons.menu_outlined,
                  color: Colors.white,
                ),
                onSelected: (result) {
                  if (result == 0) {
                    _scaffoldKey.currentState!.openDrawer();
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                      value: 0,
                      child: Text('Favorites'),
                    ),
                  ];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

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
