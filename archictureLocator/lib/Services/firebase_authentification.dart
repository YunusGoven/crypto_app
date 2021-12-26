import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthentification {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _connectionStatus(User user) {
    return user != null ? true : false;
  }

  Stream<bool> get user {
    return _auth.authStateChanges().map(_connectionStatus);
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
      var token = await _auth.currentUser.getIdToken();
      return token;
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future<bool> signInWithEmailAndPass(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      //UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _connectionStatus(user);
    } catch (exception) {
      print(exception.toString());
      return false;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }
}
