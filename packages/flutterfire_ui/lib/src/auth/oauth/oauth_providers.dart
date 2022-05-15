import 'package:firebase_auth/firebase_auth.dart' hide OAuthProvider;
import 'package:flutter/widgets.dart';
import 'package:flutterfire_ui_oauth/flutterfire_ui_oauth.dart';

@immutable
class ProviderKey {
  final FirebaseAuth auth;
  final String providerId;

  ProviderKey(this.auth, this.providerId);

  @override
  int get hashCode => hashValues(auth, providerId);

  @override
  bool operator ==(Object other) {
    return hashCode == other.hashCode;
  }
}

abstract class OAuthProviders {
  static final _providers = <ProviderKey, OAuthProvider>{};

  static void register(FirebaseAuth? auth, OAuthProvider provider) {
    final _auth = auth ?? FirebaseAuth.instance;
    final key = ProviderKey(_auth, provider.providerId);

    _providers[key] = provider;
  }

  static OAuthProvider? resolve(FirebaseAuth? auth, String providerId) {
    final _auth = auth ?? FirebaseAuth.instance;
    final key = ProviderKey(_auth, providerId);
    return _providers[key];
  }

  static Iterable<OAuthProvider> providersFor(FirebaseAuth auth) sync* {
    for (final k in _providers.keys) {
      if (k.auth == auth) {
        yield _providers[k]!;
      }
    }
  }

  static Future<void> signOut([FirebaseAuth? auth]) async {
    final _auth = auth ?? FirebaseAuth.instance;
    final futures = providersFor(_auth).map((e) => e.signOut());
    await Future.wait(futures);
  }
}

extension OAuthHelpers on User {
  bool isProviderLinked(String providerId) {
    try {
      providerData.firstWhere((e) => e.providerId == providerId);
      return true;
    } catch (_) {
      return false;
    }
  }
}
