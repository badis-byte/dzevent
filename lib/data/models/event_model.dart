// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EventModel {
  final String id;
  final String title;
  final String description;
  final DateTime startDatetime;
  final DateTime endDatetime;
  final String imageUrl;
  final String location;
  final DateTime createdAt;
  final int associationId;
  final String category;
  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startDatetime,
    required this.endDatetime,
    required this.imageUrl,
    required this.location,
    required this.createdAt,
    required this.associationId,
    required this.category,
  });

  EventModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startDatetime,
    DateTime? endDatetime,
    String? imageUrl,
    String? location,
    DateTime? createdAt,
    int? associatoinId,
    String? category,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDatetime: startDatetime ?? this.startDatetime,
      endDatetime: endDatetime ?? this.endDatetime,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      associationId: associatoinId ?? this.associationId,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'startDatetime': startDatetime.toIso8601String(),
      'endDatetime': endDatetime.toIso8601String(),
      'imageUrl': imageUrl,
      'location': location,
      'createdAt': createdAt.toIso8601String(),
      'associationId': associationId,
      'category': category,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      startDatetime: DateTime.parse(map['startDatetime']),
      endDatetime: DateTime.parse(map['endDatetime']),
      imageUrl: map['imageUrl'] as String,
      location: map['location'] as String,
      createdAt: DateTime.parse(map['createdAt']),
      associationId: map['associationId'] as int,
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EventModel(id: $id, title: $title, description: $description, startDatetime: $startDatetime, endDatetime: $endDatetime, imageUrl: $imageUrl, location: $location, createdAt: $createdAt, associatoinId: $associationId, category: $category)';
  }

  @override
  bool operator ==(covariant EventModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.startDatetime == startDatetime &&
        other.endDatetime == endDatetime &&
        other.imageUrl == imageUrl &&
        other.location == location &&
        other.createdAt == createdAt &&
        other.associationId == associationId &&
        other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        startDatetime.hashCode ^
        endDatetime.hashCode ^
        imageUrl.hashCode ^
        location.hashCode ^
        createdAt.hashCode ^
        associationId.hashCode ^
        category.hashCode;
  }
}
