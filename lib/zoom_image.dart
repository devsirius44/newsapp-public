
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_candies_demo_library/flutter_candies_demo_library.dart';
import 'package:secapp/image_editor.dart';

class ZoomImage extends StatelessWidget {
  final imgUrl;
  ZoomImage({this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(children: <Widget>[
      AppBar(
        title: Text("Zoom/Pan Image"),
        actions: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageEditor(url: this.imgUrl)
                            ),
                          );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Image.asset('lib/assets/image_editor_icon.png', height: 30, width: 30,),
                  )
                ),
        ],
      ),
      Expanded(
        child: LayoutBuilder(builder: (_, c) {
          Size size = Size(c.maxWidth, c.maxHeight);
          return ExtendedImage.network(
            this.imgUrl,
            fit: BoxFit.contain,
            //enableLoadState: false,
            mode: ExtendedImageMode.gesture,
            initGestureConfigHandler: (state) {
              double initialScale = 1.0;

              if (state.extendedImageInfo != null &&
                  state.extendedImageInfo.image != null) {
                initialScale = initScale(
                    size: size,
                    initialScale: initialScale,
                    imageSize: Size(
                        state.extendedImageInfo.image.width.toDouble(),
                        state.extendedImageInfo.image.height.toDouble()));
              }
              return GestureConfig(
                minScale: 0.9,
                animationMinScale: 0.7,
                maxScale: 4.0,
                animationMaxScale: 4.5,
                speed: 1.0,
                inertialSpeed: 100.0,
                initialScale:  initialScale,
                inPageView: false,
                initialAlignment: InitialAlignment.center,
              );
            },
          );
        }),
      )
    ]));
  }
}
