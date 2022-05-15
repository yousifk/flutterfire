import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailLinkProviderConfiguration extends ProviderConfiguration {
  final ActionCodeSettings actionCodeSettings;
  final FirebaseDynamicLinks? dynamicLinks;

  const EmailLinkProviderConfiguration({
    required this.actionCodeSettings,
    this.dynamicLinks,
  });

  @override
  String get providerId => 'email_link';

  bool _isMobile(TargetPlatform platform) {
    return platform == TargetPlatform.android || platform == TargetPlatform.iOS;
  }

  @override
  bool isSupportedPlatform(TargetPlatform platform) {
    return !kIsWeb && _isMobile(platform);
  }
}
