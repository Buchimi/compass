import 'package:compass/providers/user_provider.dart';
import 'package:flutter/material.dart';

class SignInWithGoogle extends StatelessWidget {
  const SignInWithGoogle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const ElevatedButton(
        onPressed: UserProvider.signInWithGoogle,
        child: Text("Sign in with Google"));
  }
}
