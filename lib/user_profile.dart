import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String name = "";
  String moka = "";
  String kisam = "";
  String onwan = "";

  bool isMySQL = false;

  @override
  void initState() {
    super.initState();

    // Execute a query with parameters
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
    for (var row in results) {
      setState(() {
        name = row[0].toString();
        kisam = row[1].toString();
        moka = row[2].toString();
        onwan = row[3].toString();
      });
      break;
    }
    await conn.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: !isMySQL
          ? Container(
              child: Center(
                child: Text("Sorry! You Are Not An Authoriezed User"),
              ),
            )
          : Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  name == ""
                      ? Container(
                          margin: EdgeInsets.all(10),
                          child: CircularProgressIndicator())
                      : Text(""),
                  Stack(
                    fit: StackFit.loose,
                    children: <Widget>[
                      Card(
                        elevation: 5,
                        color: Colors.lightBlue,
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
                          width: double.infinity,
                          height: 100,
                          child: Text(
                            "معلومات الموظف",
                            style: TextStyle(fontSize: 28),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Card(
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "الاسم  :                        $name   ",
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          " القسم  :                        $kisam",
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          " الموقع :                        $moka",
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "العنوان الوظيفي :          $onwan",
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CupertinoButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("الأخبار"),
                          color: Colors.lightBlue,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
