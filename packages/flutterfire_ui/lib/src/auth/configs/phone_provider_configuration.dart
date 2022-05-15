import '../configs/provider_configuration.dart';
import 'package:flutter/foundation.dart';

class PhoneProviderConfiguration extends ProviderConfiguration {
  const PhoneProviderConfiguration();

  @override
  String get providerId => 'phone';

  @override
  bool isSupportedPlatform(TargetPlatform platform) {
    return platform == TargetPlatform.iOS ||
        platform == TargetPlatform.android ||
        kIsWeb;
  }
}
