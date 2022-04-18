import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  MapPage({Key? key}) : super(key: key);
  static const initialCameraPosition =
      CameraPosition(target: LatLng(37.7, -122.43), zoom: 11.5);
  final Marker marker =
      const Marker(markerId: MarkerId("me"), position: LatLng(37.7, -122.43));
  late GoogleMapController controller;

  Widget updateMap(BuildContext ctx, AsyncSnapshot<dynamic> snapshot) {
    //TODO: do stuff
    return const CustomPaint();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: initialCameraPosition,
          markers: <Marker>{marker},
          onMapCreated: (_) => {controller = _},
        ),
        StreamBuilder(builder: updateMap)
      ],
    );
  }
}
