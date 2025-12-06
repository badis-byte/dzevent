import 'dart:convert';

class AssociationModel {
  int id;
  String name;
  String email;
  String profilePicture;
  String bio;
  DateTime createdAt;
  bool isVerified;

  AssociationModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePicture,
    required this.bio,
    required this.createdAt,
    required this.isVerified,
  });

  AssociationModel copyWith({
    int? id,
    String? name,
    String? email,
    String? profilePicture,
    String? bio,
    DateTime? createdAt,
    bool? isVerified,
  }) {
    return AssociationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'profilePicture': profilePicture,
      'bio': bio,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'isVerified': isVerified ? 1 : 0,  // <-- FIX: true→1, false→0
    };
  }

  factory AssociationModel.fromMap(Map<String, dynamic> map) {
    return AssociationModel(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      profilePicture: map['profilePicture'] as String,
      bio: map['bio'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      isVerified: (map['isVerified'] ?? 0) == 1,  // <-- FIX: convert int→bool
    );
  }

  String toJson() => json.encode(toMap());

  factory AssociationModel.fromJson(String source) =>
      AssociationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
