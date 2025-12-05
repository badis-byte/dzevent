// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class InterestModel {
  final int userId;
  final String eventId;
  final DateTime createdAt;
  InterestModel({
    required this.userId,
    required this.eventId,
    required this.createdAt,
  });

  InterestModel copyWith({int? userId, String? eventId, DateTime? createdAt}) {
    return InterestModel(
      userId: userId ?? this.userId,
      eventId: eventId ?? this.eventId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'eventId': eventId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory InterestModel.fromMap(Map<String, dynamic> map) {
    return InterestModel(
      userId: map['userId'] as int,
      eventId: map['eventId'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory InterestModel.fromJson(String source) =>
      InterestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'InterestModel(userId: $userId, eventId: $eventId, createdAt: $createdAt)';

  @override
  bool operator ==(covariant InterestModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.eventId == eventId &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => userId.hashCode ^ eventId.hashCode ^ createdAt.hashCode;
}
