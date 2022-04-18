//in house packages
import 'package:compass/providers/realtime_database_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:compass/providers/location_provider.dart';

//firebase related
import 'package:compass/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

//google maps related
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "compass", options: DefaultFirebaseOptions.currentPlatform);

  //initialize the database
  RealDBProvider.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final FirebaseDatabase _database = FirebaseDatabase.instance;

  static const initialCameraPosition =
      CameraPosition(target: LatLng(37.7, -122.43), zoom: 11.5);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: GoogleMap(
          onMapCreated: (_) {
            LocationProvider.initialize();
            LocationProvider.locationStream.listen((event) {
              //push data to firebase on change
              _database
                  .ref("Users/bii")
                  .update({"lat": event.latitude, "long": event.longitude});
            });
          },
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapType: MapType.normal,
          initialCameraPosition: initialCameraPosition),
    );
  }
}
