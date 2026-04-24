import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'package:google_sign_in_web/web_only.dart' as web;

class GoogleAuthButtonWeb extends StatelessWidget {
  const GoogleAuthButtonWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: web.renderButton(
        configuration: web.GSIButtonConfiguration(
          theme: web.GSIButtonTheme.outline,
          text: web.GSIButtonText.continueWith,
          shape: web.GSIButtonShape.rectangular,
          size: web.GSIButtonSize.large,
        ),
      ),
    );
  }
}
