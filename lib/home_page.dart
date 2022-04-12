import 'package:webview_part2/web_view_site.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final subdomain = TextEditingController();

  @override
  void dispose() {
    subdomain.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(99, 102, 241, 1),
              Color.fromRGBO(99, 102, 241, 0.9)
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
                image: AssetImage("assets/500x500.png"),
                height: 140,
                width: 140),
            const SizedBox(height: 30),
            const Text('Sub-Domain = Username',
                style: TextStyle(color: Colors.white, fontSize: 23)),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38.0),
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  label: Text('Username',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
                controller: subdomain,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.green), // SMENQSH NA KAKVOTO ISKASH
              onPressed: () {
                String username = subdomain.text;
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => WebViewPage(place: username)),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Go', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
