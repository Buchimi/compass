
enum SecurityMode { loose, moderate, strict }

class User {
  String name;
  String imgSource;
  User(this.name,
      {this.imgSource =
          "https://media.discordapp.net/attachments/811722728310046724/949424608145195058/unknown.png"});

  late double lat;
  late double long;
  late SecurityMode _securityMode;

  SecurityMode get securityMode => _securityMode;

  setSecurityMode(SecurityMode securityMode) {
    _securityMode = securityMode;
  }

  //LatLng get latLng => LatLng(lat, long);
}
