import 'package:firebase_core/firebase_core.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:flutterfire_ui_oauth/flutterfire_ui_oauth.dart';

import '../configs/provider_configuration.dart';

abstract class OAuthProviderConfiguration<T extends OAuthProvider>
    extends ProviderConfiguration {
  const OAuthProviderConfiguration(this.provider);

  final OAuthProvider provider;

  String get defaultRedirectUri =>
      'https://${Firebase.apps.first.options.projectId}.firebaseapp.com/__/auth/handler';

  String getLabel(FlutterFireUILocalizationLabels labels);
}
