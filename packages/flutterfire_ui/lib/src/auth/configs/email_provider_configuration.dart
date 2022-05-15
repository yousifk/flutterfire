import 'package:flutter/foundation.dart';

import 'provider_configuration.dart';

const EMAIL_PROVIDER_ID = 'password';

class EmailProviderConfiguration extends ProviderConfiguration {
  @override
  String get providerId => EMAIL_PROVIDER_ID;

  const EmailProviderConfiguration();

  @override
  bool isSupportedPlatform(TargetPlatform platform) {
    return true;
  }
}
