import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatdoidraw/features/auth/auth_provider.dart';

// Importación condicional para evitar errores en móviles
import 'package:whatdoidraw/features/auth/views/widgets/google_auth_button_stub.dart'
    if (dart.library.html) 'package:whatdoidraw/features/auth/views/widgets/google_auth_button_web.dart';

class GoogleAuthButton extends ConsumerWidget {
  const GoogleAuthButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kIsWeb) {
      // En Web, mostramos el botón oficial renderizado por Google
      return const GoogleAuthButtonWeb();
    } else {
      // En Android/iOS, mostramos nuestro botón personalizado
      return SizedBox(
        width: double.infinity,
        height: 50,
        child: OutlinedButton.icon(
          onPressed: () =>
              ref.read(authControllerProvider.notifier).signInWithGoogle(),
          icon: const Icon(Icons.g_mobiledata, size: 30),
          label: const Text('Continuar con Google'),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      );
    }
  }
}
