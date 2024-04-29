class Store {
   int id=0;
   String storeName="Test";
   String phoneNumber="";
   String address="";
   String storeDescription="";
   int distance=1;
   String openingAt="";
   String closingAt="";
   String createdAt="";
   String updatedAt="";
   String publishedAt="";
   String imageUrl="";
   List<String> openDays=[];

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
    required this.imageUrl,
    required this.openDays,
  });


  Store.empty();

  factory Store.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] ?? {};

    final coverPhotoData = attributes['coverPhoto'] ?? {};
    final coverPhotoAttributes = coverPhotoData['data'] ?? {};
    final coverPhoto = coverPhotoAttributes['attributes'] ?? {};
    final imageUrl = coverPhoto['url'] ?? 'Unknown';

    return Store(
      id: json['id'] ?? 0,
      storeName: attributes['storeName'] ?? 'Unknown',
      phoneNumber: attributes['phoneNumber'] ?? 'Unknown',
      address: attributes['Address'] ?? 'Unknown',
      storeDescription: attributes['storeDescription'] ?? 'No description available',
      distance: attributes['distance'] ?? 0,
      openingAt: attributes['openingAt'] ?? '09:00:00',
      closingAt: attributes['closingAt'] ?? '18:00:00',
      createdAt: attributes['createdAt'] ?? 'Unknown',
      updatedAt: attributes['updatedAt'] ?? 'Unknown',
      publishedAt: attributes['publishedAt'] ?? 'Unknown',
      openDays: attributes.containsKey('openDays') ? List<String>.from(attributes['openDays']) : [],
      imageUrl: imageUrl,
    );
  }

}
