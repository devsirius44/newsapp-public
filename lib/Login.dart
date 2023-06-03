import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secapp/SignUp.dart';
import './main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _UserIDController = TextEditingController();

  final _PasswordController = TextEditingController();

  void showSnackbar(BuildContext ctxx, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      // action: SnackBarAction(
      //   label: 'Undo',
      //   onPressed: () {
      //     // Some code to undo the change.
      //   },
      // ),
    );

    // Find the Scaffold in the widget tree and use
    // it to show a SnackBar.
    Scaffold.of(ctxx).showSnackBar(snackBar);
  }

  void validateAndLogin(BuildContext ctx) {
    final UserID = _UserIDController.text;
    final Password = _PasswordController.text;

    if (UserID.isEmpty) {
      showSnackbar(ctx, "User ID Required");
      return;
    }
    if (Password.isEmpty) {
      showSnackbar(ctx, "Password Required");
      return;
    }

    LoginWithFirebase(UserID, Password);
  }

  void LoginWithFirebase(String ID, String Pass) async {
    ID = ID + "@gmail.com";
    Pass = Pass + "888";
    try {
      FirebaseUser user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: ID, password: Pass))
          .user;
      print(user.uid);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyApp(),
          ));
    } catch (e) {
      print("Errorororororor");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              child: Text(
                "لجنة منتسبي نفط البصرة",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Text(
                      "LOGIN",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'User ID',
                        labelStyle: Theme.of(context).textTheme.title,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                    controller: _UserIDController,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: Theme.of(context).textTheme.title,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                    controller: _PasswordController,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SnackBarPage(validateAndLogin),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("New Here ?"),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                          },
                          child: Text(
                            "SignUp",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SnackBarPage extends StatelessWidget {
  Function validate;
  SnackBarPage(this.validate);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoButton(
        onPressed: () {
          validate(context);
        },
        color: Colors.lightBlue,
        child: Text("Login"),
      ),
    );
  }
}
