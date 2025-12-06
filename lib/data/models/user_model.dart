// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  int? id;
  String name;
  String email;
  String profilePicture;
  DateTime createdAt;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.profilePicture,
    required this.createdAt,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? profilePicture,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'profilePicture': profilePicture,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      profilePicture: map['profilePicture'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, profilePicture: $profilePicture, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.profilePicture == profilePicture &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        profilePicture.hashCode ^
        createdAt.hashCode;
  }
}
