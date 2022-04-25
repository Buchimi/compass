import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compass/providers/user_provider.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  UserCard({Key? key, required this.shot}) : super(key: key);
  final DocumentSnapshot<Map<String, dynamic>> shot;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Image.network(shot.get("Profile Url")),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                DocumentReference refToUser =
                    _firestore.collection("Users").doc(shot["ID"]);
                refToUser.update({
                  "Mailbox": {
                    FieldValue.arrayUnion([UserProvider.user.uid]):
                        "Hangout Proposed"
                  }
                });
                // set(
                //   {},
                //   SetOptions(merge: true),
                // );
              },
              child: const Text("Connect"))
        ],
      ),
    );
  }
}
