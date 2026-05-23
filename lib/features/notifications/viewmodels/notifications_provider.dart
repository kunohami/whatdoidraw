import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whatdoidraw/shared/models/notification_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:whatdoidraw/features/profile/services/profile_service.dart';

part 'notifications_provider.g.dart';

@Riverpod(keepAlive: true)
class Notifications extends _$Notifications {
  @override
  FutureOr<List<NotificationModel>> build() async {
    return _fetchNotifications();
  }

  Future<List<NotificationModel>> _fetchNotifications() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) return [];

    final response = await supabase
        .from('notifications')
        .select('*, actor:users!actor_id(username, avatar_url)')
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    return (response as List<dynamic>)
        .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> markAsRead(String notificationId) async {
    final supabase = Supabase.instance.client;
    await supabase
        .from('notifications')
        .update({'is_read': true})
        .eq('id', notificationId);

    if (state.value != null) {
      final newList = state.value!.map((n) {
        if (n.id == notificationId) {
          return n.copyWith(isRead: true);
        }
        return n;
      }).toList();
      state = AsyncData(newList);
    }
  }

  Future<void> markPushPromptAsSeen(String userId, bool accepted) async {
    final profileService = ref.read(profileServiceProvider);

    if (accepted) {
      await requestPushPermissionsAndSaveToken(userId);
    } else {
      await profileService.updatePushSettings(
        userId,
        hasSeenPushPrompt: true,
        pushNotifications: false,
      );
    }
  }

  Future<void> requestPushPermissionsAndSaveToken(String userId) async {
    // IMPORTANTE: Obtenemos el profileService ANTES de cualquier brecha asíncrona (await).
    // Esto previene que si el provider se destruye o reconstruye durante la espera nativa de Firebase,
    // de error al intentar usar el 'ref'.
    final profileService = ref.read(profileServiceProvider);

    try {
      final messaging = FirebaseMessaging.instance;

      // Solicitar permisos nativos del sistema con un timeout de 5 segundos
      final settings = await messaging
          .requestPermission(
            alert: true,
            announcement: false,
            badge: true,
            carPlay: false,
            criticalAlert: false,
            provisional: false,
            sound: true,
          )
          .timeout(const Duration(seconds: 5));

      final isAuthorized =
          settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional;

      String? token;
      if (isAuthorized) {
        token = await messaging.getToken().timeout(const Duration(seconds: 5));
        print('FCM Token obtenido exitosamente: $token');
      }

      // Guardar en base de datos usando la referencia de profileService ya guardada
      await profileService.updatePushSettings(
        userId,
        hasSeenPushPrompt: true,
        pushNotifications: isAuthorized,
        fcmToken: token,
      );
    } catch (e, stack) {
      print('Error al solicitar permisos FCM / Obtener Token: $e');
      print(stack);

      // Si falla algo con Firebase (ej. en web o emulador sin Google Play), guardamos sin token
      try {
        await profileService.updatePushSettings(
          userId,
          hasSeenPushPrompt: true,
          pushNotifications: false,
        );
      } catch (dbError) {
        print(
          'Error crítico: También falló el guardado en base de datos: $dbError',
        );
      }
    }
  }
}
