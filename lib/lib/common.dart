class Event {
  final String imageUrl;
  final String title;
  final DateTime datetime;
  final String location;
  final Association association;
  final String description;
  const Event({
    required this.imageUrl,
    required this.title,
    required this.datetime,
    required this.location,
    required this.association,
    required this.description,
  });
}

class Association {
  final String name;
  final String imageUrl;
  const Association({required this.name, required this.imageUrl});
}
