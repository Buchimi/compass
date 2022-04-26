import 'package:compass/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';

class Deck extends StatelessWidget {
  Deck(this.users, {Key? key}) : super(key: key);
  final List<User> users;
  int current = 0;

  IconButton acceptButton =
      IconButton(onPressed: () {

      }, icon: const Icon(Icons.check));

  IconButton declineButton =
      IconButton(onPressed: () {}, icon: const Icon(Icons.cancel_outlined));
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: ((context, setState) => SwipeDetector(
            child: 
            Column(
              children: [
                Card(
                  child: Row(
                    children: [
                      Expanded(child: Image.network(users[current].imgSource))
                    ],
                  ),
                ),
                Row(
                  children: [acceptButton, declineButton],
                )
              ],
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
