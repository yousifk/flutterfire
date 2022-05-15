import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

mixin PlatformSignIn {
  FirebaseAuth? get auth;
  dynamic get firebaseAuthProvider;

  Future<User> signIn(TargetPlatform platform) async {
    final _auth = auth ?? FirebaseAuth.instance;

    UserCredential credential;

    if (_auth.currentUser != null) {
      credential = await _auth.currentUser!.linkWithPopup(firebaseAuthProvider);
    } else {
      credential = await _auth.signInWithPopup(firebaseAuthProvider);
    }

    return credential.user!;
  }
}
