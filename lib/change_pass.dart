import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';

class ChangePass extends StatefulWidget {
  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final _NewController = TextEditingController();

  final _ConfirmController = TextEditingController();

  void changePass() async {
    String newP = _NewController.text;
    String conP = _ConfirmController.text;

    if (newP.isEmpty) {
      Toast.show("New Password is Missing", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      return;
    }
    if (conP.isEmpty) {
      Toast.show("Confirm Password is Missing", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      return;
    }
    if (newP != conP) {
      Toast.show("Passwords doesn't Match", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      return;
    }
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    try {
      await user.updatePassword(newP).then((_){
         Toast.show("Succesfull changed password", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      print("Succesfull changed password");
      Navigator.pop(context);
    }).catchError((error){
       Toast.show("Password can't be changed", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
    } catch (e) {
      Toast.show(e.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  labelText: 'New Password',
                  labelStyle: Theme.of(context).textTheme.title,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
              controller: _NewController,
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
              controller: _ConfirmController,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: CupertinoButton(
                onPressed: changePass,
                child: Text("Change"),
                color: Colors.lightBlue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
