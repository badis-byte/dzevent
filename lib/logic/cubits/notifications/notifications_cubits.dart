import 'package:dzevent/data/remoteRepo/notifications/notif_base_repo.dart';
import 'package:dzevent/logic/cubits/notifications/notifications_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final repo = NotifRepoBase.getInstance();
  NotificationsCubit() : super(NotificationsInitial());

  // Load notifications
  Future<void> getUserNotifications({required int userId}) async {
    try {
      emit(NotificationsLoading());
      // repo
      final notifications = await repo.getUserNotifications(userId: userId);
      emit(NotificationsLoaded(notifications));
    } catch (e) {
      print(e);
      emit(NotificationsError(e.toString()));
    }
  }

  // Swipe delete
  void delete(String id) {
    // if (state is NotificationsLoaded) {
    //   final s = state as NotificationsLoaded;
    //   final updated = List<NotificationModel>.from(s.notifications)
    //     ..removeWhere((n) => n.id == id);

    //   emit(NotificationsLoaded(updated));
    // }
  }

  // Mark read when tapped
  void markRead(String id) {
    //   if (state is NotificationsLoaded) {
    //     final s = state as NotificationsLoaded;
    //     final updated = s.notifications.map((n) {
    //       if (n.id == id)
    //         return NotificationModel(
    //           id: n.id,
    //           type: n.type,
    //           title: n.title,
    //           body: n.body,
    //           createdAt: n.createdAt,
    //           isRead: true,
    //           actionId: n.actionId,
    //         );
    //       return n;
    //     }).toList();

    //     emit(NotificationsLoaded(updated));
    //   }
  }
}
