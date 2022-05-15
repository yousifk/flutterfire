import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui_oauth/src/platoform_sign_in_mixin.dart';

abstract class OAuthProvider with PlatformSignIn {
  String get providerId;

  dynamic get firebaseAuthProvider;

  Future<OAuthCredential> signInProvider();

  Future<void> logOutProvider();
  Future<void> signOut() async {}
}
