class Tree {
  final int id;
  final String name;
  final String insertedDate;
  final String updatedDate;
  final double price;
  final String description;
  final String watering;
  final String depth;
  final String spacing;
  final String light;
  final String soilType;
  final String plantingProcess;
  final String createdAt;
  final String updatedAt;
  final String publishedAt;
  final String locale;
  final List<String> bestSeasons;
  final String pictureUrl;
  final String videoUrl;

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
  });

  factory Tree.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] ?? {};
    final pictureData = attributes['picture']['data'] ?? {};
    final videoData = attributes['video']['data'] ?? {};


    double price;
    try {
      price = attributes['price']?.toDouble() ?? 0.0;
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
      plantingProcess: attributes['plantingProcess'] ?? 'Unknown',
      createdAt: attributes['createdAt'] ?? 'Unknown',
      updatedAt: attributes['updatedAt'] ?? 'Unknown',
      publishedAt: attributes['publishedAt'] ?? 'Unknown',
      locale: attributes['locale'] ?? 'Unknown',
      bestSeasons: attributes.containsKey('bestSeasons') ? List<String>.from(attributes['bestSeasons']) : [],
      pictureUrl: pictureData.containsKey('attributes') ? pictureData['attributes']['url'] ?? '' : '',
      videoUrl: videoData.containsKey('attributes') ? videoData['attributes']['url'] ?? '' : '',
    );
  }


}
