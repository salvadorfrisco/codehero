class SeriesModel {
  int available;
  String collectionURI;
  List<SeriesSummary> items;
  int returned;

  SeriesModel({
    required this.available,
    required this.collectionURI,
    required this.items,
    required this.returned,
  });

  factory SeriesModel.fromJson(Map<String, dynamic> json) {
    return SeriesModel(
      available: json['available'],
      collectionURI: json['collectionURI'],
      items: (json['items'] as List<dynamic>)
          .map((item) => SeriesSummary.fromJson(item))
          .toList(),
      returned: json['returned'],
    );
  }
}

class SeriesSummary {
  String resourceURI;
  String name;

  SeriesSummary({required this.resourceURI, required this.name});

  factory SeriesSummary.fromJson(Map<String, dynamic> json) {
    return SeriesSummary(
      resourceURI: json['resourceURI'],
      name: json['name'],
    );
  }
}
