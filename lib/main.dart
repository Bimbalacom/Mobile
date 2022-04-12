import 'package:webview_part2/wigets/logic.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Flutter Demo',

      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
