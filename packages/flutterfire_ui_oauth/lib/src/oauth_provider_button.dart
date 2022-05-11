import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfire_ui_oauth/flutterfire_ui_oauth.dart';

typedef CredentialReceivedCallback = void Function(
  OAuthCredential credential,
);

typedef ErrorBuilder = Widget Function(Exception e);

class OAuthProviderButton extends StatefulWidget {
  final ThemedOAuthProviderButtonStyle style;
  final String label;
  final double size;
  final double _padding;
  final Widget loadingIndicator;
  final Future<void> Function() onTap;

  const OAuthProviderButton({
    Key? key,
    required this.style,
    required this.label,
    required this.onTap,
    required this.loadingIndicator,
    this.size = 19,
  })  : _padding = size * 1.33 / 2,
        super(key: key);

  @override
  State<OAuthProviderButton> createState() => _OAuthProviderButtonState();
}

class _OAuthProviderButtonState extends State<OAuthProviderButton> {
  double get _height => widget.size + widget._padding * 2;
  bool isLoading = false;

  Widget _buildCupertino(
    BuildContext context,
    OAuthProviderButtonStyle style,
    double margin,
    double borderRadius,
    double iconBorderRadius,
  ) {
    return Container();
  }

  Future<void> _signIn() async {
    try {
      setState(() {
        isLoading = true;
      });
      await widget.onTap();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _buildMaterial(
    BuildContext context,
    OAuthProviderButtonStyle style,
    double margin,
    double borderRadius,
    double iconBorderRadius,
  ) {
    final br = BorderRadius.circular(borderRadius);

    return _ButtonContainer(
      borderRadius: br,
      color: style.backgroundColor,
      height: _height,
      width: widget.label.isEmpty ? _height : null,
      margin: margin,
      child: Stack(
        children: [
          _ButtonContent(
            assetsPackage: style.assetsPackage,
            iconSrc: style.iconSrc,
            isLoading: false,
            label: widget.label,
            height: _height,
            fontSize: widget.size,
            textColor: style.color,
            loadingIndicator: widget.loadingIndicator,
          ),
          _MaterialForeground(onTap: () => _signIn()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCupertino = CupertinoUserInterfaceLevel.maybeOf(context) != null;
    final brightness =
        CupertinoTheme.of(context).brightness ?? Theme.of(context).brightness;

    final style = widget.style.withBrightness(brightness);
    final margin = (widget.size + widget._padding * 2) / 10;
    final borderRadius = widget.size / 3;
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

class _ButtonContent extends StatelessWidget {
  final double height;
  final String iconSrc;
  final String assetsPackage;
  final String label;
  final bool isLoading;
  final Color textColor;
  final double fontSize;
  final Widget loadingIndicator;

  const _ButtonContent({
    Key? key,
    required this.height,
    required this.iconSrc,
    required this.assetsPackage,
    required this.label,
    required this.isLoading,
    required this.fontSize,
    required this.textColor,
    required this.loadingIndicator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = SvgPicture.asset(
      iconSrc,
      package: assetsPackage,
      width: height,
      height: height,
    );

    if (label.isNotEmpty) {
      child = Row(
        children: [
          child,
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.1,
                color: textColor,
                fontSize: fontSize,
              ),
            ),
          ),
        ],
      );
    }

    return child;
  }
}

class _MaterialForeground extends StatelessWidget {
  final VoidCallback onTap;

  const _MaterialForeground({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
        ),
      ),
    );
  }
}

class _ButtonContainer extends StatelessWidget {
  final double margin;
  final double height;
  final double? width;
  final Color color;
  final BorderRadius borderRadius;
  final Widget child;

  const _ButtonContainer({
    Key? key,
    required this.margin,
    required this.height,
    required this.color,
    required this.borderRadius,
    required this.child,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(margin),
      child: SizedBox(
        height: height,
        width: width,
        child: Material(
          color: color,
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: child,
          ),
        ),
      ),
    );
  }
}
