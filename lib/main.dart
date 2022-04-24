//in house packages
import 'package:compass/pages/map_page.dart';
import 'package:compass/providers/realtime_database_provider.dart';
import 'package:compass/providers/user_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:compass/providers/location_provider.dart';

//firebase related
import 'package:compass/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get_it/get_it.dart';

//Extras

//Type definitions
//for firestore query stream
typedef UserStream = Stream<List<DocumentSnapshot<Map<String, dynamic>>>>;

void main() async {
  //Registers get it
  GetIt.I.registerSingleton<Geoflutterfire>(Geoflutterfire());

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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int radius = 20;

  UserStream stream = Stream.empty();

  UserStream scanForUsers(GeoFirePoint location) {
    return GetIt.I<Geoflutterfire>()
        .collection(collectionRef: _firestore.collection("ActiveUsers"))
        .within(center: location, radius: radius.toDouble(), field: "Location");
  }

  // static const initialCameraPosition =
  //     CameraPosition(target: LatLng(37.7, -122.43), zoom: 11.5);
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: MapPage(
          stream: stream,
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              //get location data
              final locData = await LocationProvider.locationData;
              //turn it to a geo point
              GeoFirePoint location = GetIt.I<Geoflutterfire>().point(
                  latitude: locData.latitude!, longitude: locData.longitude!);

              //store the position data into the database
              _firestore.collection("ActiveUsers").add({
                "Name": UserProvider.user.displayName,
                "Location": location.data
              });

              //subscribe to query streams
              //and scan for users
              final userStream = scanForUsers(location);

              //remember to conditionally register getit singletons
              GetIt.I.registerSingleton<UserStream>(userStream);
              stream = GetIt.I<UserStream>();

              //now we want to activate a sort of boolean that says we are initialized
              
              //TODO: Remember to dispose the stream when done!
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
