import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class WebViewGit extends StatelessWidget {
  const WebViewGit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: WebView(
              initialUrl: 'https://github.com/Bimbalacom/Mobile',
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ));
  }
}



// import 'dart:async';
// import 'dart:io';

// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sembast/sembast.dart';
// import 'package:sembast/sembast_io.dart';

// var db;

// Future createDir() async {
//   Directory appDocDirectory = await getApplicationDocumentsDirectory();
//   new Directory(appDocDirectory.path + '/' + 'dir')
//       .create(recursive: true)
//       .then(
//           (Directory directory) => print('Path of New Dir: ' + directory.path));
//   db = await databaseFactoryIo.openDatabase(join(appDocDirectory.path));
// }

// Future saveData(String place) async {
//   createDir();
//   var store = intMapStoreFactory.store('my_store');
//   var key = await store.add(db, {'place': place});
//   var record = await (store.record(key).getSnapshot(db)
//       as FutureOr<RecordSnapshot<int, Map<String, Object>>>);
//   record =
//       (await store.find(db, finder: Finder(filter: Filter.byKey(record.key))))
//           .first as RecordSnapshot<int, Map<String, Object>>;
//   print(record);
//   var records = (await (store.find(db,
//           finder: Finder(filter: Filter.matches('name', place)))
//       as FutureOr<List<RecordSnapshot<int, Map<String, Object>>>>));
//   print(records);
//   print('Hello');
// }





















// import 'package:hive/hive.dart';
// import 'package:hive_flutter/adapters.dart';

// saveData(String place) async {
//   var box = Hive.box('urlBox');
//   // Hive.openBox('urlBox');
//   await box.put('name', place);
//   readData();
// }

// readData() {
//   Hive.openBox('urlBox');
//   var box = Hive.box('urlBox');
//   String name = box.get('name');
//   print(name);
// }


// import 'package:shared_preferences/shared_preferences.dart';

// saveData(String place) async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString('counter', place);
// }

// readData() async {
//   final prefs = await SharedPreferences.getInstance();
//   final String? counter = prefs.getString('counter');
//   return counter;
// }



// import 'dart:async';

// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:flutter/widgets.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final database = openDatabase(
//     join(await getDatabasesPath(), 'url_save.db'),
//     onCreate: (db, version) {
//       return db.execute(
//         'CREATE TABLE url(id INTEGER PRIMARY KEY, name TEXT, url TEXT)',
//       );
//     },
//     version: 1,
//   );

//   Future<void> insertUrl(Url name) async {
//     final db = await database;
//     await db.insert(
//       'url',
//       name.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<List<Url>> urls() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('Url');
//     return List.generate(maps.length, (i) {
//       return Url(
//         id: maps[i]['id'],
//         name: maps[i]['name'],
//         url: maps[i]['url'],
//       );
//     });
//   }
// }

// class Url {
//   final int id;
//   final String name;
//   final String url;

//   const Url({
//     required this.id,
//     required this.name,
//     required this.url,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'url': url,
//     };
//   }

//   @override
//   String toString() {
//     return 'Url{id: $id, name: $name, url: $url}';
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// Future<SharedPreferences> prefs = SharedPreferences.getInstance();

// saveStringValue(String url, String name) async {
//   final prefs = await SharedPreferences.getInstance();
//   prefs.setString(url, name);
// }

// retrieveStringValue() async {
//   final prefs = await SharedPreferences.getInstance();
//   String? value = prefs.getString("username");
//   print(value);
// }


// deleteValue () async
//   {
//     prefs = await SharedPreferences.getInstance();
//     prefs.remove("username");
//   }


// var databasesPath = await getDatabasesPath();
// String path = join(databasesPath, 'url.db');


// Database database = await openDatabase(path, version: 1,
//     onCreate: (Database db, int version) async {
//   // When creating the db, create the table
//   await db.execute(
//       'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value TEXT)');
// });


// await database.transaction((txn) async {
//   int id1 = await txn.rawInsert(
//       'INSERT INTO Test(name, value) VALUES("$place", "$url")');

//   int id2 = await txn.rawInsert(
//       'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
//       ['another name', 12345678, 3.1416]);
//   print('inserted2: $id2');
// });







// Future<void> saveURL(favorites) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setStringList('items', favorites);
// }
// // Save the Urls;

// Future<int> readURL() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   final List<String>? items = prefs.getStringList('items');
//   if (items!.isNotEmpty) {
//     return items.length;
//   } else {
//     return 0;
//   }
// }
// // Place the Urls;

// Future<int> countURL() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   final List<String>? items = prefs.getStringList('items');
//   if (items!.length > 0) {
//     return items.length;
//   } else {
//     return 0;
//   }
// }
// // Place the Urls;




