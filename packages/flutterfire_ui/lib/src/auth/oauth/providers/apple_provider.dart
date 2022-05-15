import 'package:flutterfire_ui/i10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterfire_ui_oauth/flutterfire_ui_oauth.dart';

import '../../configs/oauth_provider_configuration.dart';
import '../provider_icons.dart';

class AppleProviderConfiguration
    extends OAuthProviderConfiguration<OAuthProvider> {
  const AppleProviderConfiguration();
  @override
  String get providerId => APPLE_PROVIDER_ID;

  @override
  String getLabel(FlutterFireUILocalizationLabels labels) {
    return labels.signInWithAppleButtonText;
  }

  @override
  bool isSupportedPlatform(TargetPlatform platform) {
    return !kIsWeb &&
        (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS);
  }
}
