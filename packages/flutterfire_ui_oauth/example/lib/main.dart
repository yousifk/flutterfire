import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui_oauth/flutterfire_ui_oauth.dart';
import 'package:flutterfire_ui_oauth_google/flutterfire_ui_google_oauth.dart';

import 'firebase_options.dart';
import 'src/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const OAuthProviderButtonExample());
}

class OAuthProviderButtonExample extends StatelessWidget {
  const OAuthProviderButtonExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Settings(builder: (context, library, brightness) {
      if (library == DesignLibrary.material) {
        return MaterialApp(
          theme: ThemeData(brightness: brightness),
          home: Scaffold(
            body: Content(designLibrary: library),
          ),
        );
      } else {
        return CupertinoApp(
          theme: CupertinoThemeData(brightness: brightness),
          home: CupertinoPageScaffold(
            child: Content(designLibrary: library),
          ),
        );
      }
    });
  }
}

class Content extends StatefulWidget {
  final DesignLibrary designLibrary;
  const Content({
    Key? key,
    required this.designLibrary,
  }) : super(key: key);

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OAuthProviderButton(
              style: GoogleProviderButtonStyle(),
              label: 'Sign in with Google',
              onTap: () async {
                await Future.delayed(const Duration(seconds: 1));
              },
              loadingIndicator: widget.designLibrary == DesignLibrary.material
                  ? const CircularProgressIndicator()
                  : const CupertinoActivityIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
