import 'package:google_maps_flutter/google_maps_flutter.dart';

class User {
  late String name;
  late double lat;
  late double long;

  LatLng get latLng => LatLng(lat, long);
}
