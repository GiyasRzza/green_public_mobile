class PlacemarkResponse {
  List<Placemark> data;
  Meta meta;

  PlacemarkResponse({required this.data, required this.meta});

  factory PlacemarkResponse.fromJson(Map<String, dynamic> json) {
    return PlacemarkResponse(
      data: List<Placemark>.from(json['data'].map((item) => Placemark.fromJson(item))),
      meta: Meta.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((placemark) => placemark.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }
}

class Placemark {
  int id;
  String name;
  double latitude;
  double longitude;
  String createdAt;
  String updatedAt;
  String publishedAt;
  String documentId;

  Placemark({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.documentId,
  });

  factory Placemark.fromJson(Map<String, dynamic> json) {
    return Placemark(
      id: json['id'],
      name: json['Name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      publishedAt: json['publishedAt'],
      documentId: json['documentId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Name': name,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'publishedAt': publishedAt,
      'documentId': documentId,
    };
  }
}

class Meta {
  Pagination pagination;

  Meta({required this.pagination});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      pagination: Pagination.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pagination': pagination.toJson(),
    };
  }
}

class Pagination {
  int page;
  int pageSize;
  int pageCount;
  int total;

  Pagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'],
      pageSize: json['pageSize'],
      pageCount: json['pageCount'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'pageSize': pageSize,
      'pageCount': pageCount,
      'total': total,
    };
  }
}