// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EventsModel {
  final int id;
  final String name;
  final DateTime createdAt;
  EventsModel({required this.id, required this.name, required this.createdAt});

  EventsModel copyWith({int? id, String? name, DateTime? createdAt}) {
    return EventsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory EventsModel.fromMap(Map<String, dynamic> map) {
    return EventsModel(
      id: map['id'] as int,
      name: map['name'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventsModel.fromJson(String source) =>
      EventsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PostModel(id: $id, name: $name, createdAt: $createdAt)';

  @override
  bool operator ==(covariant EventsModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.createdAt == createdAt;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ createdAt.hashCode;
}
