class Association {
  final int id;
  final String name;
  final String imageUrl;
  final String brief;
  final String aboutUs;
  final List<ContactInfo> contactInfo;
  const Association({
    required this.id,
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
