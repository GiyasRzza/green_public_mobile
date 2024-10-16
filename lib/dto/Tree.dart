class Tree {
  int id;
  String name;
  String insertedDate;
  String updatedDate;
  double price;
  String description;
  String watering;
  String depth;
  String spacing;
  String light;
  String soilType;
  String plantingProcess;
  String createdAt;
  String updatedAt;
  String publishedAt;
  String locale;
  List<String> bestSeasons;
  String pictureUrl;
  String videoUrl;
  String videoPreview;

  Tree({
    required this.id,
    required this.name,
    required this.insertedDate,
    required this.updatedDate,
    required this.price,
    required this.description,
    required this.watering,
    required this.depth,
    required this.spacing,
    required this.light,
    required this.soilType,
    required this.plantingProcess,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.locale,
    required this.bestSeasons,
    required this.pictureUrl,
    required this.videoUrl,
    required this.videoPreview,
  });

  Tree.empty()
      : id = 0,
        name = 'Unknown',
        insertedDate = 'Unknown',
        updatedDate = 'Unknown',
        price = 0.0,
        description = 'No description available',
        watering = 'Unknown',
        depth = 'Unknown',
        spacing = 'Unknown',
        light = 'Unknown',
        soilType = 'Unknown',
        plantingProcess = 'Unknown',
        createdAt = 'Unknown',
        updatedAt = 'Unknown',
        publishedAt = 'Unknown',
        locale = 'Unknown',
        bestSeasons = [],
        pictureUrl = '',
        videoUrl = '',
        videoPreview = '';

  factory Tree.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] ?? {};
    final pictureData = attributes['picture']?['data'];
    final videoData = attributes['video']?['data'];

    double price;
    try {
      price = (attributes['price'] != null) ? attributes['price'].toDouble() : 0.0;
    } catch (e) {
      price = 0.0;
    }

    return Tree(
      id: json['id'] ?? 0,
      name: attributes['name'] ?? 'Unknown',
      insertedDate: attributes['inserted_date'] ?? 'Unknown',
      updatedDate: attributes['updated_date'] ?? 'Unknown',
      price: price,
      description: attributes['description'] ?? 'No description available',
      watering: attributes['watering'] ?? 'Unknown',
      depth: attributes['depth'] ?? 'Unknown',
      spacing: attributes['spacing'] ?? 'Unknown',
      light: attributes['light'] ?? 'Unknown',
      soilType: attributes['soilType'] ?? 'Unknown',
      plantingProcess: attributes['planting_process'] ?? 'Unknown',
      createdAt: attributes['createdAt'] ?? 'Unknown',
      updatedAt: attributes['updatedAt'] ?? 'Unknown',
      publishedAt: attributes['publishedAt'] ?? 'Unknown',
      locale: attributes['locale'] ?? 'Unknown',
      bestSeasons: attributes['bestSeasons'] != null
          ? List<String>.from(attributes['bestSeasons'])
          : [],
      pictureUrl: pictureData != null && pictureData.containsKey('attributes')
          ? pictureData['attributes']['url'] ?? ''
          : '',
      videoUrl: videoData != null && videoData.containsKey('attributes')
          ? videoData['attributes']['url'] ?? ''
          : '',
      videoPreview: videoData != null && videoData.containsKey('attributes')
          ? videoData['attributes']['previewUrl'] ?? ''
          : '',
    );
  }
}
