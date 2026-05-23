import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whatdoidraw/shared/models/notification_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'notifications_provider.g.dart';

@riverpod
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
        .select()
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
        .update({'is_read': true}).eq('id', notificationId);
    
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
    final supabase = Supabase.instance.client;
    await supabase.from('users').update({
      'has_seen_push_prompt': true,
      'push_notifications': accepted,
    }).eq('id', userId);
  }
}
