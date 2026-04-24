import 'package:flutter/material.dart';

class GoogleAuthButtonWeb extends StatelessWidget {
  const GoogleAuthButtonWeb({super.key});

  @override
  Widget build(BuildContext context) {
    // Esto nunca debería ejecutarse en móviles
    return const SizedBox.shrink();
  }
}
