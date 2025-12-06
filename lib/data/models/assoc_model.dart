import 'dart:convert';

class AssociationModel {
  int? id;
  String name;
  String email;
  String profilePicture;
  String bio;
  DateTime createdAt;
  bool isVerified;

  AssociationModel({
    this.id,
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

  factory AssociationModel.fromMapDynamic(Map<String, dynamic> map) {
  // Make sure each field has a fallback value
  final id = map['id'] is int
      ? map['id'] as int
      : int.tryParse(map['id']?.toString() ?? '') ?? 0;

  final name = map['name']?.toString() ?? '';
  final email = map['email']?.toString() ?? '';
  final profilePicture = map['profilePicture']?.toString() ?? '';
  final bio = map['bio']?.toString() ?? '';

  // Handle createdAt as int (milliseconds) or string date
  final createdAtValue = map['createdAt'];
  final createdAt = createdAtValue is int
      ? DateTime.fromMillisecondsSinceEpoch(createdAtValue)
      : DateTime.tryParse(createdAtValue?.toString() ?? '') ?? DateTime.now();

  // Convert 0/1 or string '0'/'1' to bool
  final isVerifiedRaw = map['isVerified'] ?? 0;
  final isVerified = isVerifiedRaw.toString() == '1';

  return AssociationModel(
    id: id,
    name: name,
    email: email,
    profilePicture: profilePicture,
    bio: bio,
    createdAt: createdAt,
    isVerified: isVerified,
  );
}

  String toJson() => json.encode(toMap());

  factory AssociationModel.fromJson(String source) =>
      AssociationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AssociationModel(id: $id, name: $name, email: $email, profilePicture: $profilePicture, bio: $bio, createdAt: $createdAt, isVerified: $isVerified)';
  }

  @override
  bool operator ==(covariant AssociationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.profilePicture == profilePicture &&
        other.bio == bio &&
        other.createdAt == createdAt &&
        other.isVerified == isVerified;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        profilePicture.hashCode ^
        bio.hashCode ^
        createdAt.hashCode ^
        isVerified.hashCode;
  }
}
