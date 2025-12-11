import 'package:dzevent/data/models/notifi_model.dart';
import 'package:dzevent/logic/notifications/notifications_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  // STATIC FAKE DATA FOR NOW
  final List<NotificationModel> _fakeData = [
    NotificationModel(
      id: "1",
      type: "like",
      title: "New Like!",
      body: "Sarah liked your post.",
      createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      isRead: false,
    ),
    NotificationModel(
      id: "2",
      type: "follow",
      title: "New Follower",
      body: "John started following you.",
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: true,
    ),
    NotificationModel(
      id: "3",
      type: "event",
      title: "New Event Near You",
      body: "A tech meetup is happening tomorrow!",
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      isRead: false,
    ),
    NotificationModel(
      id: "4",
      type: "announcement",
      title: "App Update",
      body: "We added new features. Check them out!",
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      isRead: true,
    ),
  ];

  // Load notifications
  Future<void> load() async {
    emit(NotificationsLoading());
    await Future.delayed(const Duration(milliseconds: 500)); // simulate loading
    emit(NotificationsLoaded(List.from(_fakeData)));
  }

  // Swipe delete
  void delete(String id) {
    if (state is NotificationsLoaded) {
      final s = state as NotificationsLoaded;
      final updated = List<NotificationModel>.from(s.notifications)
        ..removeWhere((n) => n.id == id);

      emit(NotificationsLoaded(updated));
    }
  }

  // Mark read when tapped
  void markRead(String id) {
    if (state is NotificationsLoaded) {
      final s = state as NotificationsLoaded;
      final updated = s.notifications.map((n) {
        if (n.id == id) return NotificationModel(
          id: n.id,
          type: n.type,
          title: n.title,
          body: n.body,
          createdAt: n.createdAt,
          isRead: true,
          actionId: n.actionId,
        );
        return n;
      }).toList();

      emit(NotificationsLoaded(updated));
    }
  }
}
