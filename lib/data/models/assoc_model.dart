// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AssociationModel {
  int id;
  String name;
  String email;
  String passwordHash;
  String profilePicture;
  String bio;
  DateTime createdAt;
  bool verified =false;
  AssociationModel({
    required this.id,
    required this.name,
    required this.email,
    required this.passwordHash,
    required this.profilePicture,
    required this.bio,
    required this.createdAt,
    required this.verified,
  });

  AssociationModel copyWith({
    int? id,
    String? name,
    String? email,
    String? passwordHash,
    String? profilePicture,
    String? bio,
    DateTime? createdAt,
    bool? verified,
  }) {
    return AssociationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      profilePicture: profilePicture ?? this.profilePicture,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      verified: verified ?? this.verified,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'passwordHash': passwordHash,
      'profilePicture': profilePicture,
      'bio': bio,
      'createdAt': createdAt.toIso8601String(),
      'verified': verified,
    };
  }

  factory AssociationModel.fromMap(Map<String, dynamic> map) {
    return AssociationModel(
      id: map['id'] is int ? map['id'] : int.parse(map['id'].toString()),
      name: map['name'] as String,
      email: map['email'] as String,
      passwordHash: map['passwordHash'] as String,
      profilePicture: map['profilePicture'] as String,
      bio: map['bio'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ),
      verified: map['verified'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssociationModel.fromJson(String source) => AssociationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AssociationModel(id: $id, name: $name, email: $email, passwordHash: $passwordHash, profilePicture: $profilePicture, bio: $bio, createdAt: $createdAt, verified: $verified)';
  }

  @override
  bool operator ==(covariant AssociationModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.passwordHash == passwordHash &&
      other.profilePicture == profilePicture &&
      other.bio == bio &&
      other.createdAt == createdAt &&
      other.verified == verified;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      passwordHash.hashCode ^
      profilePicture.hashCode ^
      bio.hashCode ^
      createdAt.hashCode ^
      verified.hashCode;
  }
}
