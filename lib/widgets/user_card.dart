import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compass/models/user.dart';
import 'package:compass/providers/user_provider.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  UserCard({Key? key, required this.user}) : super(key: key);
  //final DocumentSnapshot<Map<String, dynamic>> shot;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  IconButton declineButton =
      IconButton(onPressed: () {}, icon: const Icon(Icons.cancel_outlined));

  IconButton acceptButton() {
    return IconButton(onPressed: sendRequest, icon: const Icon(Icons.check));
  }

  User user;

  sendRequest() {
    //Get a reference to the user we clicked
    DocumentReference<Map<String, dynamic>> refToUser =
        _firestore.collection("Users").doc(user.uid);

    //Send them the mail
    refToUser.update({
      "Mailbox": FieldValue.arrayUnion([
        {"ID": user.uid, "Reason": "Hangout Proposed"}
      ])
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Card(
            child: Row(
              children: [Expanded(child: Image.network(user.imgSource))],
            ),
          ),
          Row(
            children: [acceptButton()],
          )
        ],
      ),
    );
  }
}
