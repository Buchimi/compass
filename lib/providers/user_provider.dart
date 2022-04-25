//This is initialized after the user signs in
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
