import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key, required this.shot}) : super(key: key);
  final DocumentSnapshot<Map<String, dynamic>> shot;
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
          ElevatedButton(onPressed: () {}, child: const Text("Connect"))
        ],
      ),
    );
  }
}
