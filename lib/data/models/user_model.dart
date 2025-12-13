import 'dart:convert';

class UserModel {
  int? id;
  String name;
  String email;
  String password;
  String profilePicture;
  DateTime createdAt;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.profilePicture,
    required this.createdAt,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    String? profilePicture,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      profilePicture: profilePicture ?? this.profilePicture,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'profilePicture': profilePicture,
      'createdAt': createdAt.toIso8601String(),
    };
  }

factory UserModel.fromMap(Map<String, dynamic> map) {
  // Handle createdAt as int or ISO string
  final createdAtValue = map['createdAt'];
  DateTime createdAt;

  if (createdAtValue is int) {
    createdAt = DateTime.fromMillisecondsSinceEpoch(createdAtValue);
  } else if (createdAtValue is String) {
    createdAt = DateTime.parse(createdAtValue);
  } else {
    createdAt = DateTime.now(); // fallback
  }

  return UserModel(
    id: map['id'] as int?,
    name: map['name'] as String,
    email: map['email'] as String,
    password: map['password'] as String,
    profilePicture: map['profilePicture'] as String,
    createdAt: createdAt,
  );
}


  factory UserModel.fromMapDynamic(Map<String, dynamic> map) {
  // Make sure each field has a fallback value
  final id = map['id'] is int
      ? map['id'] as int
      : int.tryParse(map['id']?.toString() ?? '') ?? 0;

  final name = map['name']?.toString() ?? '';
  final email = map['email']?.toString() ?? '';
  final password = map['email']?.toString() ?? '';
  final profilePicture = map['profilePicture']?.toString() ?? '';

  // Handle createdAt as int (milliseconds) or string date
  final createdAtValue = map['createdAt'];
  final createdAt = createdAtValue is int
      ? DateTime.fromMillisecondsSinceEpoch(createdAtValue)
      : DateTime.tryParse(createdAtValue?.toString() ?? '') ?? DateTime.now();

  return UserModel(
    id: id,
    name: name,
    email: email,
    password: password,
    profilePicture: profilePicture,
    createdAt: createdAt,
  );
}

  //String toJson() => json.encode(toMap());
  Map<String, dynamic> toJson() => toMap();


  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AssociationModel(id: $id, name: $name, email: $email, profilePicture: $profilePicture, createdAt: $createdAt.';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.password == password &&
        other.profilePicture == profilePicture &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        profilePicture.hashCode ^
        createdAt.hashCode;
  }
}
