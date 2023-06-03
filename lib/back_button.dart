import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {

  final BuildContext context;
  final VoidCallback onBack;
  final Color color;
  
  BackButtonWidget({Key key, this.onBack, this.context, this.color= Colors.white}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,  //Color(0x664a414e),//Color(0xff6c5774), //Color(0xff947c9c),
      borderRadius: BorderRadius.all(Radius.circular(20)),
      
      child: InkWell(
        onTap: () {
          if(onBack == null) {
            Navigator.pop(context);
          } else {
            onBack();
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(Icons.arrow_back_ios, color: color),
            ),
          ],
        ),
      ),
    );
  }
}