class NotificationModel {
  final String id;
  final String type; // like, follow, event, announcement
  final String title;
  final String body;
  final DateTime createdAt;
  final bool isRead;
  final String? actionId; // postId, userId, eventId...

  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.isRead,
    this.actionId,
  });
}
