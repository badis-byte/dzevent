import 'dart:convert';

class FollowModel {
  final int id;
  final int userId;
  final int associationId;
  final bool notify;

  FollowModel({
    required this.id,
    required this.userId,
    required this.associationId,
    required this.notify,
  });

  FollowModel copyWith({
    int? id,
    int? userId,
    int? associationId,
    bool? notify,
  }) {
    return FollowModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      associationId: associationId ?? this.associationId,
      notify: notify ?? this.notify,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'associationId': associationId,
      'notify': notify ? 1 : 0,
    };
  }

factory FollowModel.fromMap(Map<String, dynamic> map) {
  final idValue = map['id'];
  final userIdValue = map['userId'];
  final assocIdValue = map['associationId'];
  final notifyValue = map['notify'];

  return FollowModel(
    id: idValue != null
        ? (idValue is int ? idValue : int.tryParse(idValue.toString()) ?? 0)
        : 0,
    userId: userIdValue != null
        ? (userIdValue is int
            ? userIdValue
            : int.tryParse(userIdValue.toString()) ?? 0)
        : 0,
    associationId: assocIdValue != null
        ? (assocIdValue is int
            ? assocIdValue
            : int.tryParse(assocIdValue.toString()) ?? 0)
        : 0,
    notify: notifyValue != null
        ? (notifyValue is bool
            ? notifyValue
            : notifyValue == 1 || notifyValue.toString() == 'true')
        : false,
  );
}


  String toJson() => json.encode(toMap());

  factory FollowModel.fromJson(String source) =>
      FollowModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FollowModel(id: $id, userId: $userId, associationId: $associationId, notify: $notify)';

  @override
  bool operator ==(covariant FollowModel other) {
    if (identical(this, other)) return true;
    return other.id == id &&
        other.userId == userId &&
        other.associationId == associationId &&
        other.notify == notify;
  }

  @override
  int get hashCode =>
      id.hashCode ^ userId.hashCode ^ associationId.hashCode ^ notify.hashCode;
}
