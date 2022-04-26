import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compass/deck/deck.dart';
import 'package:compass/providers/user_provider.dart';
import 'package:compass/widgets/mail/messages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';

class MailBox extends StatelessWidget {
  MailBox({Key? key}) : super(key: key);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SimpleDialog generateDialog(
      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
    List<Widget> children = [];
    List<User> users = [];
    snapshot.data?.get("Mailbox").forEach(
          (element) => users.add(User(element["Name"],
              imgSource: element["Photo URL"], uid: element["ID"])),
        );
    children.add(Deck(users));
    return SimpleDialog(
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestore
            .collection("Users")
            .doc("NNd5HYTxZhZn3rSz9P5TSFO4ISe2") //UserProvider.user.uid)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> shots) {
          if (shots.hasData) {
            print(shots.data?.get("Mailbox"));

            if (shots.data?.get("Mailbox").length != 0) {
              return ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return generateDialog(shots);
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.mail_outline,
                    color: Colors.amber,
                  ),
                  label: const Text("Mail"));
            }
          }
          return ElevatedButton.icon(
              onPressed: null,
              icon: const Icon(
                Icons.mail_outline,
              ),
              label: const Text("Mail"));
        });
  }
}
