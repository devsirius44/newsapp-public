
import './Upload.dart';


import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import './news_tile.dart';

class Older extends StatelessWidget {
  final DatabaseReference itemReff;
  final List<Upload> itemss;

  Older(this.itemReff, this.itemss);

  @override
  Widget build(BuildContext context) {
     return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           
            Flexible(
              child: FirebaseAnimatedList(
                query: itemReff,
                itemBuilder: (BuildContext contex, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                    return new NewsTile(itemss[index].mDisc, itemss[index].mtime, itemss[index].mImageUrl, itemss[index].mUrl);
                },
              ),
            ),
          ],
        );
  }
}