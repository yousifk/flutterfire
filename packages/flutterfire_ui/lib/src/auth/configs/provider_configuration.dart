import 'package:flutter/foundation.dart';

abstract class ProviderConfiguration {
  const ProviderConfiguration();
  String get providerId;
  bool isSupportedPlatform(TargetPlatform platform);
}
