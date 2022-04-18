import 'package:compass/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';

class Deck extends StatelessWidget {
  Deck(this.users, {Key? key}) : super(key: key);
  final List<User> users;
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: ((context, setState) => SwipeDetector(
            child: Card(
              child: Row(
                children: [
                  Expanded(child: Image.network(users[current].imgSource))
                ],
              ),
            ),
            onSwipeRight: (Offset offset) {
              setState(
                () => current = (current + 1) % users.length,
              );
            },
            onSwipeLeft: (_) {
              setState(
                () => current = (current + users.length - 1) % users.length,
              );
            },
          )),
    );
  }
}
