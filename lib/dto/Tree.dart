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
  CharacteristicBundle? characteristicBundle;
  PlantingProcess? plantingProcess;
  String createdAt;
  String updatedAt;
  String publishedAt;
  String locale;
  List<String> bestSeasons;
  String pictureUrl;
  String videoUrl;
  String videoPreview;
  String videoName;

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
    this.characteristicBundle,
    this.plantingProcess,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.locale,
    required this.bestSeasons,
    required this.pictureUrl,
    required this.videoUrl,
    required this.videoPreview,
    required this.videoName
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
        characteristicBundle = null,
        plantingProcess = null,
        createdAt = 'Unknown',
        updatedAt = 'Unknown',
        publishedAt = 'Unknown',
        locale = 'Unknown',
        bestSeasons = [],
        pictureUrl = '',
        videoUrl = '',
        videoPreview = '',
        videoName="";

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
      characteristicBundle: attributes['characteristic_bundle']?['data'] != null
          ? CharacteristicBundle.fromJson(attributes['characteristic_bundle']['data'])
          : null,
      plantingProcess: attributes['planting_process']?['data'] != null
          ? PlantingProcess.fromJson(attributes['planting_process']['data'])
          : null,
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
      videoName: videoData != null && videoData.containsKey('attributes')
          ? videoData['attributes']['name'] ?? ''
          : '',
    );
  }
}

class CharacteristicBundle {
  int id;
  String name;
  String createdAt;
  String updatedAt;
  String publishedAt;
  List<Characteristic> characteristics;

  CharacteristicBundle({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.characteristics,
  });

  factory CharacteristicBundle.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] ?? {};
    final characteristicsData = attributes['characteristics']?['data'] ?? [];

    List<Characteristic> characteristics = characteristicsData
        .map<Characteristic>((item) => Characteristic.fromJson(item))
        .toList();

    return CharacteristicBundle(
      id: json['id'] ?? 0,
      name: attributes['name'] ?? 'Unknown',
      createdAt: attributes['createdAt'] ?? 'Unknown',
      updatedAt: attributes['updatedAt'] ?? 'Unknown',
      publishedAt: attributes['publishedAt'] ?? 'Unknown',
      characteristics: characteristics,
    );
  }
}

class Characteristic {
  int id;
  String name;
  String value;
  String createdAt;
  String updatedAt;
  String publishedAt;

  Characteristic({
    required this.id,
    required this.name,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  factory Characteristic.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] ?? {};
    return Characteristic(
      id: json['id'] ?? 0,
      name: attributes['name'] ?? 'Unknown',
      value: attributes['value'] ?? 'Unknown',
      createdAt: attributes['createdAt'] ?? 'Unknown',
      updatedAt: attributes['updatedAt'] ?? 'Unknown',
      publishedAt: attributes['publishedAt'] ?? 'Unknown',
    );
  }
}

class PlantingProcess {
  int id;
  String header;
  String createdAt;
  String updatedAt;
  String publishedAt;
  List<ProcessElement> processElements;

  PlantingProcess({
    required this.id,
    required this.header,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.processElements,
  });

  factory PlantingProcess.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] ?? {};
    final processElementsData = attributes['process_elements']?['data'] ?? [];

    List<ProcessElement> processElements = processElementsData
        .map<ProcessElement>((item) => ProcessElement.fromJson(item))
        .toList();

    return PlantingProcess(
      id: json['id'] ?? 0,
      header: attributes['header'] ?? 'Unknown',
      createdAt: attributes['createdAt'] ?? 'Unknown',
      updatedAt: attributes['updatedAt'] ?? 'Unknown',
      publishedAt: attributes['publishedAt'] ?? 'Unknown',
      processElements: processElements,
    );
  }
}

class ProcessElement {
  int id;
  String text;
  String createdAt;
  String updatedAt;
  String publishedAt;

  ProcessElement({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  factory ProcessElement.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] ?? {};
    return ProcessElement(
      id: json['id'] ?? 0,
      text: attributes['text'] ?? 'Unknown',
      createdAt: attributes['createdAt'] ?? 'Unknown',
      updatedAt: attributes['updatedAt'] ?? 'Unknown',
      publishedAt: attributes['publishedAt'] ?? 'Unknown',
    );
  }
}
