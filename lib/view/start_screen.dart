import 'package:bimbala/logic/favorites_controller.dart';
import 'package:bimbala/view/webpage.dart';
import 'package:bimbala/view/webpage_url.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class StartScreen extends StatefulWidget {
  StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final TextEditingController _user = TextEditingController();
  final Favorite _userlastplace = Favorite();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [blue1, blue2],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            //~ Logo
            const CircleAvatar(
              radius: 70,
              backgroundColor: Colors.transparent,
              foregroundImage: AssetImage('assets/logo.png'),
            ),
            //~Title
            const SizedBox(height: 20),
            const Text('Specify your Bimbala domain:',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 20),
            //~Input
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: _user,
                    style: TextStyle(
                      color: white,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () => goToView(_user.text),
                        icon: Icon(
                          Icons.send,
                          color: white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: white,
                        ),
                      ),
                      label: Text(
                        'Domain',
                        style: TextStyle(
                          color: white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                  future: _userlastplace.currentPage,
                  builder: (context, snapshot) {
                    if (snapshot.data != null &&
                        snapshot.data.toString() != 'null') {
                      return Row(
                        children: [
                          Text(
                            'Last visited:',
                            style: TextStyle(color: white),
                          ),
                          TextButton(
                            onPressed: () => goToView(snapshot.data.toString()),
                            child: Text(
                              snapshot.data.toString(),
                              style: TextStyle(color: white),
                            ),
                          )
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            style: ButtonStyle(
                                side: MaterialStateProperty.all(BorderSide(
                              color: white,
                            ))),
                            onPressed: () => goToView('board'),
                            child: Text("Bimbala's Board",
                                style: TextStyle(
                                  color: white,
                                )))),
                    const SizedBox(width: 20),
                    Expanded(
                      child: OutlinedButton(
                          style: ButtonStyle(
                              side: MaterialStateProperty.all(BorderSide(
                            color: white,
                          ))),
                          onPressed: () => openBimbalaUrl(),
                          child: Text("Website",
                              style: TextStyle(
                                color: white,
                              ))),
                    ),
                  ],
                )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ~ Show WebViewScreen for user input if not empty
  void goToView(String domein) {
    if (domein != '') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => WebViewScreen(
            user: domein,
          ),
        ),
      );
    } else {
      const snackBar = SnackBar(
        content: Text('Please enter a domain'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void openBimbalaUrl() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const WebViewUrlScreen(
          url: 'https://bimbala.com/',
        ),
      ),
    );
  }

  @override
  void dispose() {
    _user.dispose();
    super.dispose();
  }
}
