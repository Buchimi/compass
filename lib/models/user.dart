import 'package:cloud_firestore/cloud_firestore.dart';

enum SecurityMode { loose, moderate, strict }

class User {
  String name;
  String imgSource;
  String? uid;
  User(this.name,
      {this.uid,
      this.imgSource =
          "https://media.discordapp.net/attachments/811722728310046724/949424608145195058/unknown.png"});

  late SecurityMode _securityMode;

  SecurityMode get securityMode => _securityMode;

  setSecurityMode(SecurityMode securityMode) {
    _securityMode = securityMode;
  }

  static User parseUserFromUsersSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    //this snapshot is from the active users
    //this snapshot holds
    //TODO: this could be error prone
    // print(snapshot.data());
    //String name = snapshot.;

    return User(
      snapshot["Name"],
      uid: snapshot["ID"],
    );
  }

  //LatLng get latLng => LatLng(lat, long);
}
