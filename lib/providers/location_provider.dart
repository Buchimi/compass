import 'package:flutter/services.dart';
import 'package:location/location.dart';

class LocationProvider {
  static final Location _location = Location();
  static late bool _serviceEnabled;
  static late PermissionStatus _permissible;
  static late double? _lattitude;
  static late double? _longitude;

  static Future<LocationData> get locationData async => _location.getLocation();
  static Stream<LocationData> get locationStream => _location.onLocationChanged;
  static double get lattitude => _lattitude!;
  static double get longitude => _longitude!;

  static bool isInitialized = false;
  static void initialize() async {
    //request permissions to use device location
    //ask for location permission
    _permissible = await _location.hasPermission();
    if (_permissible == PermissionStatus.denied) {
      _permissible = await _location.requestPermission();
    }

    //ask for the user to enable location service
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        //Quit the app
        //TODO: we need better logic here
        SystemNavigator.pop();
      }
    }

    //enable background mode
    _location.enableBackgroundMode(enable: true);

    //Create location data stream listeners to constantly update lat and long data
    locationData.asStream().listen((event) {
      _lattitude = event.latitude;
      _longitude = event.longitude;
    });

    //End permission ask

    //set is initialized to true
    isInitialized = true;
  }

  static void changeSettings(
      LocationAccuracy? accuracy, int? interval, double? distanceFilter) {
    _location.changeSettings(

        ///
        accuracy: accuracy,
        interval: interval,
        distanceFilter: distanceFilter);
  }
}
