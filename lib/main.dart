import 'dart:async';
import 'package:mysql1/mysql1.dart';
import './change_pass.dart';
import './constants.dart';
import './login.dart';
import './user_profile.dart';

import './Upload.dart';
import './splash_screen.dart';
import './older.dart';
import './recents.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'لجنة منتسبي نفط البصرة',
      theme: ThemeData(
          primaryColor: Colors.lightBlue[600],
          primaryColorLight: Colors.blue[200],
          accentColor: Colors.blue[100],
          fontFamily: 'Manjari'),
      home: MyHomePage(title: 'لجنة منتسبي نفط البصرة'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Upload> items = List();
  List<Upload> items2 = List();
  Upload item;
  Upload item2;
  DatabaseReference itemRef;

  DatabaseReference itemRef2;
  bool loaded = false;
  bool isMySQL = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void CheckUser() async {
    FirebaseUser user = await _auth.currentUser();
    if (user == null) {
      print("NULL");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } else {
      print("FUCK");
    }
  }

  @override
  void initState() {
    super.initState();

    CheckUser();
    if (!loaded) {
      Timer(Duration(seconds: 5), () {
        setState(() {
          loaded = true;
        });
      });
    }
    item2 = Upload("", "", "", "", "");
    itemRef2 = FirebaseDatabase.instance.reference().child("Recents");
    itemRef2.onChildAdded.listen(_onEntryAdded2);
    itemRef2.onChildChanged.listen(_onEntryChanged2);
    itemRef2.onChildRemoved.listen(_onEntryRemoved2);
    item = Upload("", "", "", "", "");
    itemRef = FirebaseDatabase.instance.reference().child("News");
    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);
    itemRef.onChildRemoved.listen(_onEntryRemoved);

    retrieveData();
  }

  Future retrieveData() async {
    final conn = await MySqlConnection.connect(new ConnectionSettings(
        host: '148.72.232.171',
        port: 3306,
        user: 'hassamtalha',
        password: '123456',
        db: 'secondNewsAppDB'));

    FirebaseUser UID = await FirebaseAuth.instance.currentUser();
    String uid = UID.email;

    uid = uid.substring(0, uid.length - 10);

    var results = await conn.query(
        'select NAME, KISAM, MOKA, ONWAN from users where ID = ?', [uid]);
    if (results.isEmpty || results == null) {
      print(
          "------------------------------------------User Not Found ---------------------------");
      setState(() {
        isMySQL = false;
      });
    } else {
      setState(() {
        isMySQL = true;
      });
    }
    await conn.close();
  }

  _onEntryRemoved2(Event event) {
    setState(() {
      items2.remove(Upload.fromSnapshot(event.snapshot));
    });
  }

  _onEntryRemoved(Event event) {
    setState(() {
      items.remove(Upload.fromSnapshot(event.snapshot));
    });
  }

  _onEntryAdded(Event event) {
    setState(() {
      items.add(Upload.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = items.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      items[items.indexOf(old)] = Upload.fromSnapshot(event.snapshot);
    });
  }

  _onEntryAdded2(Event event) {
    setState(() {
      items2.add(Upload.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged2(Event event) {
    var old2 = items2.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      items2[items2.indexOf(old2)] = Upload.fromSnapshot(event.snapshot);
    });
  }

  void choiceAction(String choice) {
    if (choice == Constants.ChangePass) {
      print("ChangePass");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChangePass()),
      );
    } else if (choice == Constants.Profile) {
      print("Profile");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserProfile()),
      );
    } else if (choice == Constants.LogOut) {
      print("Log Out");
      _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return loaded
        ? DefaultTabController(
            length:!isMySQL? 1 : 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
                actions: <Widget>[
                  PopupMenuButton<String>(
                    onSelected: choiceAction,
                    itemBuilder: (BuildContext context) {
                      return Constants.choices.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  )
                ],
                bottom: TabBar(
                  tabs: !isMySQL
                      ? <Widget>[
                          Tab(text: "الأخبار المؤرشفة"),
                        ]
                      : <Widget>[
                          Tab(text: "الأخبار"),
                          Tab(text: "الأخبار المؤرشفة"),
                        ],
                ),
              ),
              body: TabBarView(
                children: !isMySQL
                    ? <Widget>[
                        items2.length == 0
                            ? Image.asset("lib/assets/no_new_notifications.jpg")
                            : Older(itemRef2, items2),
                      ]
                    : <Widget>[
                        items.length == 0
                            ? Image.asset("lib/assets/no_new_notifications.jpg")
                            : Recents(itemRef, items),
                        items2.length == 0
                            ? Image.asset("lib/assets/no_new_notifications.jpg")
                            : Older(itemRef2, items2),
                      ],
              ),
            ),
          )
        : SplashScreen();
  }
}
