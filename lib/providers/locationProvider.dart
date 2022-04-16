import 'package:flutter/services.dart';
import 'package:location/location.dart';

class LocationProvider {
  static final Location _location = Location();
  static late bool _serviceEnabled;
  static late PermissionStatus _permissible;

  static Future<LocationData> get locationData async => _location.getLocation();
  static Stream<LocationData> get locationStream => _location.onLocationChanged;
  static bool isInitialized = false;
  static void initialize() async {
    //request permissions to use device location
    //ask for location permission
    _permissible = await _location.hasPermission();
    if (_permissible == PermissionStatus.denied) {
      _permissible = await _location.requestPermission();
    }
    print("Has permission = ");
    print(_permissible);

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
    print("Service enabled ");
    print(_serviceEnabled);
    //enable background mode
    _location.enableBackgroundMode(enable: true);
    //End permission ask
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
