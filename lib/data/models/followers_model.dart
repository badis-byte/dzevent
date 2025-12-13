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

  factory FollowModel.fromMap(Map<String, dynamic> map) {
    return FollowModel(
      id: map['id'],
      userId: map['user_id'],
      associationId: map['association_id'],
      notify: map['notify'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'association_id': associationId,
      'notify': notify ? 1 : 0,
    };
  }
}
