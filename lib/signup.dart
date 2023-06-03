import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _UserIDSignUpController = TextEditingController();

  final _PasswordSignUpController = TextEditingController();
  final _ConfirmPasswordSignUpController = TextEditingController();

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
    final UserID = _UserIDSignUpController.text;
    final Password = _PasswordSignUpController.text;
     final Confirm = _ConfirmPasswordSignUpController.text;

    if (UserID.isEmpty) {
      showSnackbar(ctx, "User ID Required");
      return;
    }
    if (Password.isEmpty) {
      showSnackbar(ctx, "Password Required");
      return;
    }
    if (Password.length < 4) {
      showSnackbar(ctx, "Minimum Password length is 4");
      return;
    }

    if (Confirm.isEmpty) {
      showSnackbar(ctx, "Confirm Password Required");
      return;
    }
    if (Confirm != Password) {
      showSnackbar(ctx, "Password Mismatch");
      return;
    }

    LoginWithFirebase(UserID, Password);
  }

  void LoginWithFirebase(String e, String p) async{
    

    FirebaseAuth.instance.createUserWithEmailAndPassword(email: e+"@gmail.com", password: p+"888").then((_){
         Toast.show("Succesfully Registered", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      print("Succesfull registered");
      Navigator.pop(context);
    }).catchError((error){
       Toast.show("Something Went Wrong", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      print("Something went wrong in registration" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("SignUp"),
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
                      "SignUp",
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
                        hintText: 'eg : john123',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                    controller: _UserIDSignUpController,
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
                    controller: _PasswordSignUpController,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: Theme.of(context).textTheme.title,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                    controller: _ConfirmPasswordSignUpController,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SnackBarPage(validateAndLogin),
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
        child: Text("Sign Up"),
      ),
    );
  }
}
