import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: "Login Failed: ${e.toString()}");
      return null;
    }
  }

  Future<User?> registerWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: "Registration Failed: ${e.toString()}");
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Fluttertoast.showToast(msg: "Logged Out Successfully");
    } catch (e) {
      print(e.toString());
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result = await _auth.signInWithCredential(credential);
      return result.user;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: "Google Sign-In Failed: ${e.toString()}");
      return null;
    }
  }
}
