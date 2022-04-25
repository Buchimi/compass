import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compass/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart' as lat_lng;
import 'package:geoflutterfire/geoflutterfire.dart';

typedef UserStream = Stream<List<DocumentSnapshot<Map<String, dynamic>>>>;

class MapPage extends StatelessWidget {
  MapPage({Key? key, required this.stream}) : super(key: key);
  // static const initialCameraPosition =
  //     CameraPosition(target: LatLng(37.7, -122.43), zoom: 11.5);
  // final Marker marker =
  //     const Marker(markerId: MarkerId("me"), position: LatLng(37.7, -122.43));
  // late GoogleMapController controller;
  Geoflutterfire geo = Geoflutterfire();

  //I am skeptical this will work
  UserStream stream;
  //init stream

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Marker createMarker(DocumentSnapshot<Map<String, dynamic>> shot) {
    GeoPoint point = getGeoPointFromDocSnapshot(shot);
    return Marker(
      point: lat_lng.LatLng(point.latitude, point.longitude),
      builder: (context) {
        return GestureDetector(
          child: const FlutterLogo(),
          onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) {
                return UserCard(
                  shot: shot,
                );
              }),
        );
      },
    );
  }

  GeoPoint getGeoPointFromDocSnapshot(
      DocumentSnapshot<Map<String, dynamic>> shot) {
    return shot.get("Location")["geopoint"] as GeoPoint;
  }

  Widget widgetBuilder(BuildContext context,
      AsyncSnapshot<List<DocumentSnapshot<Map<String, dynamic>>>> shot) {
    if (!GetIt.I.isRegistered<List<Marker>>()) {
      GetIt.I.registerSingleton(<Marker>[]);
    }
    shot.data?.forEach(
        (element) => GetIt.I<List<Marker>>().add(createMarker(element)));
    return FlutterMap(
      options: MapOptions(
        center: lat_lng.LatLng(37.7, -122.43),
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://a.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png"),
        MarkerLayerOptions(
          markers: () {
            try {
              if (!GetIt.I.isRegistered<List<Marker>>()) {
                GetIt.I.registerSingleton(<Marker>[]);
              }
              return GetIt.I<List<Marker>>();
            } catch (f) {
              print("What the fuck");
              return <Marker>[];
            }
          }(),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder(stream: stream, builder: widgetBuilder),
      ],
    );
  }
}
