// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotificationModel {
  final String id;
  // final String title;
  final int user_id;
  final String body;
  // final DateTime time;
  // final String type;
  NotificationModel({
    required this.id,
    required this.user_id,
    required this.body,
  });

  NotificationModel copyWith({String? id, int? user_id, String? body}) {
    return NotificationModel(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'user_id': user_id, 'body': body};
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as String,
      user_id: map['user_id'] as int,
      body: map['body'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'NotificationModel(id: $id, user_id: $user_id, body: $body)';

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.user_id == user_id && other.body == body;
  }

  @override
  int get hashCode => id.hashCode ^ user_id.hashCode ^ body.hashCode;
}
