import 'package:shared_preferences/shared_preferences.dart';

class Favorite {
  // ~ Store 'place' to favorite
  Future<String> store(String value) async {
    final pref = await SharedPreferences.getInstance();
    List<String>? items = pref.getStringList('favorites');
    if (items == null) {
      await pref.setStringList('favorites', <String>[value]);
      saveCurrentPage(value);
      return 'Added!';
    }
    if (items.contains(value)) {
      return 'Already Exist';
    }
    items.add(value);
    await pref.setStringList('favorites', items);
    saveCurrentPage(value);
    saveCurrentPage(value);
    return '';

    // await pref.setStringList('favorites', <String>[value]);

    // if (items!.contains(value)) {
    //   return 'Already Exist';
    // } else {
    //   items.add(value);
    //   await pref.setStringList('favorites', items);
    //   saveCurrentPage(value);
    //   return '';
    // }
  }

  // ~ Remove 'place' from favorite
  void remove(String value) async {
    final pref = await SharedPreferences.getInstance();
    final List<String>? items = pref.getStringList('favorites');
    // ~ Remove from Fav
    items!.remove(value);
    await pref.setStringList('favorites', items);
  }

  // ~ Show Favorites
  get items async {
    final pref = await SharedPreferences.getInstance();
    final List<String>? items = pref.getStringList('favorites');
    return items;
  }

  // ~ Saving current webpage
  void saveCurrentPage(String value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('current', value);
  }

  // ~ Show Current Page
  get currentPage async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('current').toString();
  }
}
