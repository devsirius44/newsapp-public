import 'package:flutter_candies_demo_library/flutter_candies_demo_library.dart';
import 'package:secapp/zoom_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';


class NewsTile extends StatefulWidget {
  final String mDescription;
  final String mTime;
  final String mUrl;
  final String mImageURL;

  NewsTile(this.mDescription, this.mTime, this.mImageURL, this.mUrl);

  @override
  _NewsTileState createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  List<ImgItem> imageItems = [];
  ImgItem imgItem;
  @override
  void initState() {
    super.initState();
    
    imgItem = ImgItem(desc: widget.mDescription, imgUrl: widget.mImageURL);
    imageItems.add(imgItem);
  }

  _openFacebook(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 3,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ZoomImage(imgUrl: widget.mImageURL)),
                      //builder: (context) => MyCropImage(index: 0, imageItemList: imageItems, knowImageSize: false)),
                );
              },
              child: Card(
                margin: EdgeInsets.all(10),
                child: Center(
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: widget.mImageURL,
                    width: 120,
                    height: 120,
                  ),
                ),
                elevation: 5,
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    _openFacebook(widget.mUrl);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(widget.mDescription),
                      Container(
                        margin: EdgeInsets.only(top: 90),
                        child: Text(
                          widget.mTime,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImgItem {
  final String desc;
  final String imgUrl;

  ImgItem ({
    this.desc,
    this.imgUrl
  });
}
