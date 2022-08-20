import 'package:bimbala/constants/colors.dart';
import 'package:bimbala/logic/favorites_controller.dart';
import 'package:bimbala/view/start_screen.dart';
import 'package:bimbala/view/webpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerG extends StatefulWidget {
  DrawerG({Key? key, required this.user}) : super(key: key);
  String user;

  @override
  State<DrawerG> createState() => _DrawerGState();
}

class _DrawerGState extends State<DrawerG> {
  @override
  Widget build(BuildContext context) {
    final Favorite _favorite = Favorite();

    // ~ onTap send the user to the favorite place
    void goToPlace(String place) async {
      _favorite.saveCurrentPage(place);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => WebViewScreen(
            user: place,
          ),
        ),
      );
    }

    // ~ Remove from Favorite
    void remove(String place) {
      _favorite.remove(place);
      setState(() {
        _favorite.items;
      });
      Navigator.pop(context);
      var snackBar = SnackBar(
        content: Text('$place is removed from Favorites'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    // ~ Add current page to favorite
    void addToFavorite() async {
      String result = await Favorite().store(widget.user);
      if (result == 'Already Exist') {
        Navigator.pop(context);
        var snackBar = SnackBar(
          content: Text('${widget.user} is already in Favorites'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        setState(() {
          _favorite.items;
        });
        var snackBar = SnackBar(
          content: Text('${widget.user} is added to Favorites'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    // ~ Add new page
    void addNewFavorite() async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => StartScreen(),
        ),
      );
    }

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // ~ Workspaces
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [blue1, blue2],
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Workspaces',
                  style: TextStyle(fontSize: 25, color: white),
                ),
              ),
            ),
            FutureBuilder(
              future: _favorite.items,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                // ~ If There is a favorite 'places' shows them
                if (snapshot.data != null && snapshot.data.length > 0) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => goToPlace(snapshot.data[index]),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: white,
                              foregroundImage: NetworkImage(
                                  'https://${widget.user}.bimbala.com/favicon.ico'),
                            ),
                            title: Text(
                              snapshot.data[index].toString(),
                            ),
                            trailing: IconButton(
                              onPressed: () => remove(snapshot.data[index]),
                              icon: const Icon(Icons.highlight_remove),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                // ~ Show text/picture if there is no Favorite 'places' added
                return const Expanded(
                  child: Center(
                    child: Text('No Favorites Yet!'),
                  ),
                );
              },
            ),
            // ~ Add Buttons
            Column(
              children: [
                const Divider(thickness: 1),
                GestureDetector(
                  onTap: () => addToFavorite(),
                  child: const ListTile(
                    title: Text('Add this domain to favourite'),
                  ),
                ),
                GestureDetector(
                  onTap: () => addNewFavorite(),
                  child: const ListTile(
                    title: Text('Open a new domain'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
