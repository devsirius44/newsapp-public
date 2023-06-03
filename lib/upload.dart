import 'package:firebase_database/firebase_database.dart';

class Upload {
  String mImageUrl;
  String mDisc;
  String mtime;
  String mUrl;
  String imgID;
  String key;
  Upload(this.mImageUrl, this.mDisc, this.mtime, this.mUrl, this.imgID);

  Upload.fromSnapshot(DataSnapshot snapshot)
    : key = snapshot.key,
      mImageUrl = snapshot.value["mImageUrl"],
      mDisc = snapshot.value["disc"],
      mtime = snapshot.value["time"],
      mUrl = snapshot.value["mUri"],
      imgID = snapshot.value["imgID"]
      ;
      

}
