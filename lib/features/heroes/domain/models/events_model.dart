class EventsModel {
  int available;
  String collectionURI;
  List<dynamic> items;
  int returned;

  EventsModel({
    required this.available,
    required this.collectionURI,
    required this.items,
    required this.returned,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) {
    return EventsModel(
      available: json['available'],
      collectionURI: json['collectionURI'],
      items: json['items'],
      returned: json['returned'],
    );
  }
}
