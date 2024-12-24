class Tree {
  final int id;
  final String name;
  final String insertedDate;
  final String updatedDate;
  final double price;
  final String description;
  final List<String> bestSeasons;
  final String createdAt;
  final String updatedAt;
  final String publishedAt;
  final String locale;
  final String documentId;
  final CharacteristicBundle characteristicBundle;
  final PlantingProcess plantingProcess;
  final Picture picture;

  Tree.empty()
      : id = 0,
        name = '',
        insertedDate = '',
        updatedDate = '',
        price = 0.0,
        description = '',
        bestSeasons = [],
        createdAt = '',
        updatedAt = '',
        publishedAt = '',
        locale = '',
        documentId = '',
        characteristicBundle = CharacteristicBundle.empty(),
        plantingProcess = PlantingProcess.empty(),
        picture = Picture.empty();

  Tree({
    required this.id,
    required this.name,
    required this.insertedDate,
    required this.updatedDate,
    required this.price,
    required this.description,
    required this.bestSeasons,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.locale,
    required this.documentId,
    required this.characteristicBundle,
    required this.plantingProcess,
    required this.picture,
  });

  factory Tree.fromJson(Map<String, dynamic> json) {
    return Tree(
      id: json['id'],
      name: json['name'],
      insertedDate: json['inserted_date'],
      updatedDate: json['updated_date'],
      price: json['price'].toDouble(),
      description: json['description'],
      bestSeasons: List<String>.from(json['bestSeasons']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      publishedAt: json['publishedAt'],
      locale: json['locale'],
      documentId: json['documentId'],
      characteristicBundle:
      CharacteristicBundle.fromJson(json['characteristic_bundle']),
      plantingProcess: PlantingProcess.fromJson(json['planting_process']),
      picture: Picture.fromJson(json['picture']),
    );
  }
}

class CharacteristicBundle {
  final int id;
  final String name;
  final String createdAt;
  final String updatedAt;
  final String publishedAt;
  final String documentId;
  final List<Characteristic> characteristics;

  CharacteristicBundle.empty()
      : id = 0,
        name = '',
        createdAt = '',
        updatedAt = '',
        publishedAt = '',
        documentId = '',
        characteristics = [];

  CharacteristicBundle({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.documentId,
    required this.characteristics,
  });

  factory CharacteristicBundle.fromJson(Map<String, dynamic> json) {
    return CharacteristicBundle(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      publishedAt: json['publishedAt'],
      documentId: json['documentId'],
      characteristics: List<Characteristic>.from(
        json['characteristics'].map((x) => Characteristic.fromJson(x)),
      ),
    );
  }
}

class Characteristic {
  final int id;
  final String name;
  final String value;
  final String createdAt;
  final String updatedAt;
  final String publishedAt;
  final String documentId;

  Characteristic({
    required this.id,
    required this.name,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.documentId,
  });

  factory Characteristic.fromJson(Map<String, dynamic> json) {
    return Characteristic(
      id: json['id'],
      name: json['name'],
      value: json['value'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      publishedAt: json['publishedAt'],
      documentId: json['documentId'],
    );
  }
}

class PlantingProcess {
  final int id;
  final String header;
  final String createdAt;
  final String updatedAt;
  final String publishedAt;
  final String documentId;
  final List<ProcessElement> processElements;

  PlantingProcess.empty()
      : id = 0,
        header = '',
        createdAt = '',
        updatedAt = '',
        publishedAt = '',
        documentId = '',
        processElements = [];

  PlantingProcess({
    required this.id,
    required this.header,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.documentId,
    required this.processElements,
  });

  factory PlantingProcess.fromJson(Map<String, dynamic> json) {
    return PlantingProcess(
      id: json['id'],
      header: json['header'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      publishedAt: json['publishedAt'],
      documentId: json['documentId'],
      processElements: List<ProcessElement>.from(
        json['process_elements'].map((x) => ProcessElement.fromJson(x)),
      ),
    );
  }
}

class ProcessElement {
  final int id;
  final String text;
  final String createdAt;
  final String updatedAt;
  final String publishedAt;
  final String documentId;

  ProcessElement.empty()
      : id = 0,
        text = '',
        createdAt = '',
        updatedAt = '',
        publishedAt = '',
        documentId = '';

  ProcessElement({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.documentId,
  });

  factory ProcessElement.fromJson(Map<String, dynamic> json) {
    return ProcessElement(
      id: json['id'],
      text: json['text'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      publishedAt: json['publishedAt'],
      documentId: json['documentId'],
    );
  }
}

class Picture {
  final int id;
  final String name;
  final String? alternativeText;
  final String? caption;
  final int width;
  final int height;
  final String hash;
  final String ext;
  final String mime;
  final double size;
  final String url;
  final String? previewUrl;
  final String provider;
  final String createdAt;
  final String updatedAt;
  final String documentId;
  final String publishedAt;

  Picture.empty()
      : id = 0,
        name = '',
        alternativeText = null,
        caption = null,
        width = 0,
        height = 0,
        hash = '',
        ext = '',
        mime = '',
        size = 0.0,
        url = '',
        previewUrl = null,
        provider = '',
        createdAt = '',
        updatedAt = '',
        documentId = '',
        publishedAt = '';

  Picture({
    required this.id,
    required this.name,
    this.alternativeText,
    this.caption,
    required this.width,
    required this.height,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    this.previewUrl,
    required this.provider,
    required this.createdAt,
    required this.updatedAt,
    required this.documentId,
    required this.publishedAt,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      id: json['id'],
      name: json['name'],
      alternativeText: json['alternativeText'],
      caption: json['caption'],
      width: json['width'],
      height: json['height'],
      hash: json['hash'],
      ext: json['ext'],
      mime: json['mime'],
      size: json['size'].toDouble(),
      url: json['url'],
      previewUrl: json['previewUrl'],
      provider: json['provider'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      documentId: json['documentId'],
      publishedAt: json['publishedAt'],
    );
  }
}