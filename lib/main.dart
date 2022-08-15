import 'package:bimbala/view/webpage.dart';
import 'package:flutter/material.dart';
import 'logic/favorites_controller.dart';
import 'view/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, this.place}) : super(key: key);
  String? place;
  final Favorite _favorite = Favorite();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bimbala',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      // ~ If there is a saved page it will go there
      home: StartScreen(),
    );
  }
}
