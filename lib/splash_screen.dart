import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.lightBlue[600],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 100.0,
                        backgroundColor: Colors.white,
                        child: Image.asset("lib/assets/logo.png", height: 170, width: 180,),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0),),
                      Text("لجنة منتسبي نفط البصرة",style: TextStyle(

                        fontSize: 35.0,
                        color: Colors.white
                        
                      ),)
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child:
                Center(child: CircularProgressIndicator(),)
                 
              )
            ],)
        ],
      ),
    );
  }
}
