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

  bool get loggedIn => _loggedIn;

  String get displayName => _displayName;

  drive.DriveApi? get driveApi => _driveApi;

  Future<void> _loginCheck() async {
    _googleAccount = await GoogleSignIn(scopes: [
      drive.DriveApi.driveAppdataScope,
    ]).signInSilently();
    setUserInfo();
  }

  void setUserInfo() {
    if (_googleAccount != null) {
      _displayName = _googleAccount!.displayName ?? "Unnamed";
      _loggedIn = true;
      setDriveApi(_googleAccount);
      notifyListeners();
    }
  }

  Future<void> signIn() async {
    try {
      GoogleSignIn googleSignIn =
          GoogleSignIn(scopes: [drive.DriveApi.driveAppdataScope]);
      print("************** $googleSignIn");
      _googleAccount =
          await googleSignIn.signInSilently() ?? await googleSignIn.signIn();
      setUserInfo();
    } catch (e) {
      print("************** Error during Google Sign-In: $e");
    }
  }

  Future<void> signOut() async {
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
