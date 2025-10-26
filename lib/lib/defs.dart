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
  final String brief;
  final String aboutUs;
  final List<ContactInfo> contactInfo;
  const Association({
    required this.name,
    required this.imageUrl,
    this.brief = "",
    this.aboutUs = "",
    this.contactInfo = const <ContactInfo>[],
  });
}

enum ContactInfoType { email, phone, web }

class ContactInfo {
  final ContactInfoType type;
  final String address;
  const ContactInfo({required this.type, required this.address});
}
