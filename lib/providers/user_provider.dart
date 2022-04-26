//This is initialized after the user signs in
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProvider {
  static bool _initialized = false;
  static late UserCredential _credential;
  static User get user => _getUser();

  static void signInWithGoogle() async {
    final GoogleSignInAccount? user = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? auth = await user?.authentication;

    final credidential = GoogleAuthProvider.credential(
        idToken: auth?.idToken, accessToken: auth?.accessToken);

    _credential =
        await FirebaseAuth.instance.signInWithCredential(credidential);

    //write to database
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    _firestore.collection("Users").doc(_credential.user!.uid).set({
      "First Name": "Bee", //TODO: update
      "Last Name": "Bee",
      "Photo URL" : _credential.user?.photoURL,
      "Age": 20,
      "Mailbox": []
    });
    _initialized = true;
  }

  static User _getUser() {
    if (!_initialized) {
      //initialize, better logic can be used eventually
      signInWithGoogle();
      //TODO we should await this, fix it
    }
    return _credential.user!;
  }
}
