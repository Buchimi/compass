import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

class FirestoreProvider {
  static late FirebaseFirestore _instance;
  static bool _isInitialized = false;

  static bool get isInitialzed => _isInitialized;
  static FirebaseFirestore get instance => _instance;

  static void initialize() {
    _instance = FirebaseFirestore.instance;
    _isInitialized = true;
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> scanForUsers(
    //Soon we may make this a stream 
      LocationData locationData, double radius) {
    return _instance
        .collection("Users")
        .where("lat", isGreaterThan: locationData.latitude! - radius)
        .where("lat", isLessThan: locationData.latitude! + radius)
        .get();
  }
}
