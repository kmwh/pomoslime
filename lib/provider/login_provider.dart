import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginProvider with ChangeNotifier {
  bool _loggedIn = false;
  User? _user;
  String _displayName = "";

  LoginProvider() {
    _loginCheck();
  }

  bool get loggedIn => _loggedIn;

  String get displayName => _displayName;

  void _loginCheck() {
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      _loggedIn = true;
      _displayName = _user!.displayName!;
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? account = await GoogleSignIn().signIn();

    if (account != null) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await account.authentication;

      // Create a new credential
      final googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential credential =
          await FirebaseAuth.instance.signInWithCredential(googleCredential);

      if (credential.user != null) {
        _loggedIn = true;
        notifyListeners();
      }
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    _loggedIn = false;
    notifyListeners();
  }
}
