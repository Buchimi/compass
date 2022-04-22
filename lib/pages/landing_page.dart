import 'package:compass/widgets/sign_in_with/google.dart';
import 'package:flutter/material.dart';
//This page would probably be used for login and onboarding

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [SignInWithGoogle()],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
