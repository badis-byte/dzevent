// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  int id;
  String name;
  String email;
  String passwordHash;
  String profilePicture;

  DateTime createdAt;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.passwordHash,
    required this.profilePicture,
    required this.createdAt,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? passwordHash,
    String? profilePicture,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      profilePicture: profilePicture ?? this.profilePicture,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'passwordHash': passwordHash,
      'profilePicture': profilePicture,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      passwordHash: map['passwordHash'] as String,
      profilePicture: map['profilePicture'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, passwordHash: $passwordHash, profilePicture: $profilePicture, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.passwordHash == passwordHash &&
        other.profilePicture == profilePicture &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        passwordHash.hashCode ^
        profilePicture.hashCode ^
        createdAt.hashCode;
  }
}
