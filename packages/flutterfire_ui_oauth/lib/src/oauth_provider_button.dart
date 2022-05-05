import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart' hide OAuthProvider;
import 'package:flutter/material.dart';
import 'package:flutterfire_ui_oauth/flutterfire_ui_oauth.dart';
import 'package:flutterfire_ui_oauth/src/oauth_provider_button_style.dart';

class OAuthProviderButton extends StatelessWidget {
  final OAuthProvider provider;
  final ThemedOAuthProviderButtonStyle style;
  final String label;
  final OAuthCredential Function() onCredentialReceived;
  final double size;
  final double _padding;
  final Widget loadingIndicator;
  final Widget errorWidget;

  const OAuthProviderButton({
    Key? key,
    required this.provider,
    required this.style,
    required this.label,
    required this.onCredentialReceived,
    required this.loadingIndicator,
    required this.errorWidget,
    this.size = 19,
  })  : _padding = size * 1.33 / 2,
        super(key: key);

  Widget _buildCupertino(
    BuildContext context,
    OAuthProviderButtonStyle style,
    double margin,
    double borderRadius,
    double iconBorderRadius,
  ) {
    return Container();
  }

  Widget _buildMaterial(
    BuildContext context,
    OAuthProviderButtonStyle style,
    double margin,
    double borderRadius,
    double iconBorderRadius,
  ) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final isCupertino = CupertinoUserInterfaceLevel.maybeOf(context) != null;
    final brightness =
        CupertinoTheme.of(context).brightness ?? Theme.of(context).brightness;

    final style = this.style.withBrightness(brightness);
    final margin = (size + _padding * 2) / 10;
    final borderRadius = size / 3;
    const borderWidth = 1.0;
    final iconBorderRadius = borderRadius - borderWidth;

    if (isCupertino) {
      return _buildCupertino(
        context,
        style,
        margin,
        borderRadius,
        iconBorderRadius,
      );
    } else {
      return _buildMaterial(
        context,
        style,
        margin,
        borderRadius,
        iconBorderRadius,
      );
    }
  }
}
