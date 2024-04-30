class Tree {
   int id=1;
   String name="";
   String insertedDate="";
   String updatedDate="";
   double price=0.0;
   String description="";
   String watering="";
   String depth="";
   String spacing="";
   String light="";
   String soilType="";
   String plantingProcess="";
   String createdAt="";
   String updatedAt="";
   String publishedAt="";
   String locale="";
   List<String> bestSeasons=[];
   String pictureUrl="";
   String videoUrl="";
   String videoPreview="";

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
    required this.videoPreview
  });


   Tree.empty();

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
      videoPreview: videoData.containsKey('attributes') ? videoData['attributes']['previewUrl'] ?? '':''
    );
  }
  // final attributes = json['attributes'] ?? {};
  // final pictureData = attributes['picture']['data'] ?? {};
  // final videoData = attributes['video']['data'] ?? {};

  // double price;
  // try {
  // price = attributes['price']?.toDouble() ?? 0.0;
  // } catch (e) {
  // price = 0.0;
  // }
  //
  //
  // String smallImageUrl = '';
  // if (pictureData.containsKey('attributes')) {
  // var pictureAttributes = pictureData['attributes'];
  //
  // if (pictureAttributes.containsKey('formats')) {
  // var formats = pictureAttributes['formats'];
  //
  // if (formats.containsKey('small')) {
  // var small = formats['small'];
  //
  // if (small.containsKey('url')) {
  // smallImageUrl = small['url'];
  // }
  // }
  // }
  // }

}
