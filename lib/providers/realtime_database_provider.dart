import 'package:firebase_database/firebase_database.dart';

class RealDBProvider {
  static late FirebaseDatabase _database;
  static initialize() {
    _database = FirebaseDatabase.instance;
  }

  FirebaseDatabase get instance => _database;
}
