class Store {
  final int id;
  final String storeName;
  final String phoneNumber;
  final String address;
  final String storeDescription;
  final double distance;
  final String openingAt;
  final String closingAt;
  final String createdAt;
  final String updatedAt;
  final String publishedAt;
  final List<String> openDays;

  Store({
    required this.id,
    required this.storeName,
    required this.phoneNumber,
    required this.address,
    required this.storeDescription,
    required this.distance,
    required this.openingAt,
    required this.closingAt,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.openDays,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] ?? {};
    return Store(
      id: json['id'] ?? 0,
      storeName: attributes['storeName'] ?? 'Unknown',
      phoneNumber: attributes['phoneNumber'] ?? 'Unknown',
      address: attributes['Address'] ?? 'Unknown',
      storeDescription: attributes['storeDescription'] ?? 'No description available',
      distance: attributes['distance'] ?? 0.0,
      openingAt: attributes['openingAt'] ?? '09:00:00',
      closingAt: attributes['closingAt'] ?? '18:00:00',
      createdAt: attributes['createdAt'] ?? 'Unknown',
      updatedAt: attributes['updatedAt'] ?? 'Unknown',
      publishedAt: attributes['publishedAt'] ?? 'Unknown',
      openDays: attributes.containsKey('openDays') ? List<String>.from(attributes['openDays']) : [],
    );
  }
}
