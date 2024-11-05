class Store {
  final int id;
  final String storeName;
  final String phoneNumber;
  final String address;
  final String storeDescription;
  final String openingAt;
  final String closingAt;
  final List<String> openDays;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;
  final double latitude;
  final double longitude;
  final String documentId;
  final List<Product> products;
  final List<Tree> trees;
  final Image coverPhoto;
  final Image profilePhoto;
  Store.empty()
      : id = 0,
        storeName = '',
        phoneNumber = '',
        address = '',
        storeDescription = '',
        openingAt = '',
        closingAt = '',
        openDays = [],
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        publishedAt = DateTime.now(),
        latitude = 0.0,
        longitude = 0.0,
        documentId = '',
        products = [],
        trees = [],
        coverPhoto = Image.empty(),
        profilePhoto = Image.empty();

  Store({
    required this.id,
    required this.storeName,
    required this.phoneNumber,
    required this.address,
    required this.storeDescription,
    required this.openingAt,
    required this.closingAt,
    required this.openDays,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.latitude,
    required this.longitude,
    required this.documentId,
    required this.products,
    required this.trees,
    required this.coverPhoto,
    required this.profilePhoto,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      storeName: json['storeName'],
      phoneNumber: json['phoneNumber'],
      address: json['Address'],
      storeDescription: json['storeDescription'],
      openingAt: json['openingAt'],
      closingAt: json['closingAt'],
      openDays: List<String>.from(json['openDays']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      publishedAt: DateTime.parse(json['publishedAt']),
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      documentId: json['documentId'],
      products: (json['products'] as List).map((e) => Product.fromJson(e)).toList(),
      trees: (json['trees'] as List).map((e) => Tree.fromJson(e)).toList(),
      coverPhoto: Image.fromJson(json['coverPhoto']),
      profilePhoto: Image.fromJson(json['profilePhoto']),
    );
  }
}

class Product {
  final int id;
  final String productName;
  final String? isInStock;
  final String description;
  final String price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;
  final String locale;
  final String about;
  final String documentId;
  final Image image;
  Product.empty()
      : id = 0,
        productName = '',
        isInStock = null,
        description = '',
        price = '',
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        publishedAt = DateTime.now(),
        locale = '',
        about = '',
        documentId = '',
        image = Image.empty();
  Product({
    required this.id,
    required this.productName,
    this.isInStock,
    required this.description,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.locale,
    required this.about,
    required this.documentId,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productName: json['productName'],
      isInStock: json['isInStock'],
      description: json['description'],
      price: json['price'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      publishedAt: DateTime.parse(json['publishedAt']),
      locale: json['locale'],
      about: json['about'],
      documentId: json['documentId'],
      image: Image.fromJson(json['image']),
    );
  }
}

class Tree {
  final int id;
  final String name;
  final DateTime insertedDate;
  final DateTime updatedDate;
  final int price;
  final String description;
  final List<String> bestSeasons;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;
  final String locale;
  final String documentId;
  final Image picture;
  Tree.empty()
      : id = 0,
        name = '',
        insertedDate = DateTime.now(),
        updatedDate = DateTime.now(),
        price = 0,
        description = '',
        bestSeasons = [],
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        publishedAt = DateTime.now(),
        locale = '',
        documentId = '',
        picture = Image.empty();
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
    required this.picture,
  });

  factory Tree.fromJson(Map<String, dynamic> json) {
    return Tree(
      id: json['id'],
      name: json['name'],
      insertedDate: DateTime.parse(json['inserted_date']),
      updatedDate: DateTime.parse(json['updated_date']),
      price: json['price'],
      description: json['description'],
      bestSeasons: List<String>.from(json['bestSeasons']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      publishedAt: DateTime.parse(json['publishedAt']),
      locale: json['locale'],
      documentId: json['documentId'],
      picture: Image.fromJson(json['picture']),
    );
  }
}

class Image {
  final int id;
  final String name;
  final String? alternativeText;
  final String? caption;
  final int width;
  final int height;
  final String ext;
  final String mime;
  final double size;
  final String url;
  final String? previewUrl;
  final String provider;
  final Map<String, dynamic>? providerMetadata;
  Image.empty()
      : id = 0,
        name = '',
        alternativeText = null,
        caption = null,
        width = 0,
        height = 0,
        ext = '',
        mime = '',
        size = 0.0,
        url = '',
        previewUrl = null,
        provider = '',
        providerMetadata = null;

  Image({
    required this.id,
    required this.name,
    this.alternativeText,
    this.caption,
    required this.width,
    required this.height,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    this.previewUrl,
    required this.provider,
    this.providerMetadata,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json['id'],
      name: json['name'],
      alternativeText: json['alternativeText'],
      caption: json['caption'],
      width: json['width'],
      height: json['height'],
      ext: json['ext'],
      mime: json['mime'],
      size: json['size'].toDouble(),
      url: json['url'],
      previewUrl: json['previewUrl'],
      provider: json['provider'],
      providerMetadata: json['provider_metadata'],
    );
  }
}