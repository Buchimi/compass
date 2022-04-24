import 'package:rxdart/subjects.dart';

class NearbyUsers {
  late BehaviorSubject subject;
  NearbyUsers(dynamic data) {
    subject = BehaviorSubject.seeded(data);
  }
}
