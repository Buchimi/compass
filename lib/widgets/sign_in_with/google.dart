import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInWithGoogle extends StatelessWidget {
  const SignInWithGoogle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          //TODO: User retrieval starts here
          print("jere");
          final GoogleSignInAccount? user = await GoogleSignIn().signIn();

          final GoogleSignInAuthentication? auth = await user?.authentication;

          final credidential = GoogleAuthProvider.credential(
              idToken: auth?.idToken, accessToken: auth?.accessToken);

          UserCredential userCredidential =
              await FirebaseAuth.instance.signInWithCredential(credidential);

          //Next page after sign in
          //for now just print
          print("Credidential:");
          print(userCredidential.user);
        },
        child: const Text("Sign in with Google"));
  }
}
