import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:pomoslime/utils/google_auth_client.dart';

class SignInProvider with ChangeNotifier {
  GoogleSignInAccount? _googleAccount;
  bool _loggedIn = false;
  String _displayName = "Unnamed";
  drive.DriveApi? _driveApi;

  SignInProvider() {
    _loginCheck();
  }

  Future<void> _loginCheck() async {
    _googleAccount = await GoogleSignIn(scopes: [
      drive.DriveApi.driveAppdataScope,
    ]).signInSilently();
    // User? user = FirebaseAuth.instance.currentUser;
    if (_googleAccount != null) {
      _loggedIn = true;
      _displayName = _googleAccount!.displayName ?? "Unnamed";
      setDriveApi(_googleAccount);
      notifyListeners();
    }
  }

  bool get loggedIn => _loggedIn;

  String get displayName => _displayName;

  drive.DriveApi? get driveApi => _driveApi;

  Future<void> signInWithGoogle() async {
    _googleAccount = await GoogleSignIn(scopes: [
      drive.DriveApi.driveAppdataScope,
    ]).signIn();

    if (_googleAccount != null) {
      _displayName = _googleAccount!.displayName ?? "Unnamed";

      final GoogleSignInAuthentication googleAuth =
          await _googleAccount!.authentication;

      final googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential credential =
          await FirebaseAuth.instance.signInWithCredential(googleCredential);

      if (credential.user != null) {
        _loggedIn = true;
        setDriveApi(_googleAccount);
        notifyListeners();
      }
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    _loggedIn = false;
    setDriveApi(null);
    notifyListeners();
  }

  Future<void> setDriveApi(GoogleSignInAccount? googleUser) async {
    try {
      if (googleUser == null) {
        _driveApi = null;
      } else {
        Map<String, String> header = await googleUser.authHeaders;
        GoogleAuthClient client = GoogleAuthClient(header);
        _driveApi = drive.DriveApi(client);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
