//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
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

  Widget updateMap(BuildContext ctx, AsyncSnapshot<dynamic> snapshot) {
    //TODO: do stuff
    return const CustomPaint();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            center: lat_lng.LatLng(37.7, -122.43),
          ),
          layers: [
            TileLayerOptions(
                urlTemplate:
                    "https://a.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png"),
            MarkerLayerOptions(markers: [
              Marker(
                  point: lat_lng.LatLng(37.7, -122.43),
                  builder: (context) {
                    return GestureDetector(
                      child: const FlutterLogo(),
                      onTap: () => showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return const Text("Hello");
                          }),
                    );
                  })
            ])
          ],
        ),
        StreamBuilder(
          builder: updateMap,
        ),
      ],
    );
  }
}
