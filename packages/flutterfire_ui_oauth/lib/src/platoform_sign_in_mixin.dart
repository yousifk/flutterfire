import 'package:desktop_webview_auth/desktop_webview_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' hide OAuthProvider;
import 'package:flutter/widgets.dart';
import 'package:flutterfire_ui_oauth/flutterfire_ui_oauth.dart';

mixin PlatformSignIn {
  OAuthProvider get provider;
  ProviderArgs get desktopSignInArgs;
  FirebaseAuth? get auth;
  dynamic get firebaseAuthProvider;

  OAuthCredential fromDesktopAuthResult(AuthResult result);

  Future<OAuthCredential> desktopSignIn() async {
    final result = await DesktopWebviewAuth.signIn(desktopSignInArgs);

    if (result == null) {
      throw Exception('Sign in failed');
    }

    final credential = fromDesktopAuthResult(result);
    return credential;
  }

  Future<OAuthCredential> signIn(TargetPlatform platform) async {
    if (platform == TargetPlatform.macOS ||
        platform == TargetPlatform.linux ||
        platform == TargetPlatform.windows) {
      return await provider.desktopSignIn();
    } else {
      return await provider.signInProvider();
    }
  }
}
