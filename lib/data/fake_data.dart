import 'package:dzevent/data/models/event_model.dart';
import 'package:uuid/uuid.dart';

final event1 = EventModel.fromMap({
  "id": Uuid().v6(),
  "title": "Campus Tech Meetup",
  "description":
      "A gathering for students interested in software, AI, and robotics.",
  "startDatetime": DateTime(2025, 3, 12, 14, 0).toIso8601String(),
  "endDatetime": DateTime(2025, 3, 12, 17, 0).toIso8601String(),
  "imageUrl": "https://example.com/images/tech_meetup.jpg",
  "location": "Main Auditorium",
  "createdAt": DateTime(2025, 1, 20, 10, 30).toIso8601String(),
  "associationId": 3,
  "category": "Technology",
});

final event2 = EventModel.fromMap({
  "id": Uuid().v6(),
  "title": "Art & Creativity Workshop",
  "description":
      "Hands-on workshop exploring painting, design, and digital art.",
  "startDatetime": DateTime(2025, 4, 3, 9, 30).toIso8601String(),
  "endDatetime": DateTime(2025, 4, 3, 12, 0).toIso8601String(),
  "imageUrl": "https://example.com/images/art_workshop.png",
  "location": "Creative Arts Center",
  "createdAt": DateTime(2025, 1, 22, 15, 45).toIso8601String(),
  "associationId": 5,
  "category": "Art",
});

final events = [event1, event2];
