class HeroEntity {
  int id;
  String name;
  String description;
  String modified;
  Thumbnail thumbnail;
  String resourceURI;
  Comics comics;
  Series series;
  Stories stories;
  Events events;
  List<Url> urls;

  HeroEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.modified,
    required this.thumbnail,
    required this.resourceURI,
    required this.comics,
    required this.series,
    required this.stories,
    required this.events,
    required this.urls,
  });

  factory HeroEntity.fromJson(Map<String, dynamic> json) {
    return HeroEntity(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      modified: json['modified'],
      thumbnail: Thumbnail.fromJson(json['thumbnail']),
      resourceURI: json['resourceURI'],
      comics: Comics.fromJson(json['comics']),
      series: Series.fromJson(json['series']),
      stories: Stories.fromJson(json['stories']),
      events: Events.fromJson(json['events']),
      urls: (json['urls'] as List<dynamic>)
          .map((url) => Url.fromJson(url))
          .toList(),
    );
  }
}

class Thumbnail {
  String path;
  String extension;

  Thumbnail({required this.path, required this.extension});

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(
      path: json['path'],
      extension: json['extension'],
    );
  }

  @override
  String toString() {
    return '$path.$extension';
  }
}

class Comics {
  int available;
  String collectionURI;
  List<ComicSummary> items;
  int returned;

  Comics({
    required this.available,
    required this.collectionURI,
    required this.items,
    required this.returned,
  });

  factory Comics.fromJson(Map<String, dynamic> json) {
    return Comics(
      available: json['available'],
      collectionURI: json['collectionURI'],
      items: (json['items'] as List<dynamic>)
          .map((item) => ComicSummary.fromJson(item))
          .toList(),
      returned: json['returned'],
    );
  }
}

class ComicSummary {
  String resourceURI;
  String name;

  ComicSummary({required this.resourceURI, required this.name});

  factory ComicSummary.fromJson(Map<String, dynamic> json) {
    return ComicSummary(
      resourceURI: json['resourceURI'],
      name: json['name'],
    );
  }
}

class Series {
  int available;
  String collectionURI;
  List<SeriesSummary> items;
  int returned;

  Series({
    required this.available,
    required this.collectionURI,
    required this.items,
    required this.returned,
  });

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
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

class Stories {
  int available;
  String collectionURI;
  List<StorySummary> items;
  int returned;

  Stories({
    required this.available,
    required this.collectionURI,
    required this.items,
    required this.returned,
  });

  factory Stories.fromJson(Map<String, dynamic> json) {
    return Stories(
      available: json['available'],
      collectionURI: json['collectionURI'],
      items: (json['items'] as List<dynamic>)
          .map((item) => StorySummary.fromJson(item))
          .toList(),
      returned: json['returned'],
    );
  }
}

class StorySummary {
  String resourceURI;
  String name;
  String type;

  StorySummary(
      {required this.resourceURI, required this.name, required this.type});

  factory StorySummary.fromJson(Map<String, dynamic> json) {
    return StorySummary(
      resourceURI: json['resourceURI'],
      name: json['name'],
      type: json['type'],
    );
  }
}

class Events {
  int available;
  String collectionURI;
  List<dynamic> items;
  int returned;

  Events({
    required this.available,
    required this.collectionURI,
    required this.items,
    required this.returned,
  });

  factory Events.fromJson(Map<String, dynamic> json) {
    return Events(
      available: json['available'],
      collectionURI: json['collectionURI'],
      items: json['items'],
      returned: json['returned'],
    );
  }
}

class Url {
  String type;
  String url;

  Url({required this.type, required this.url});

  factory Url.fromJson(Map<String, dynamic> json) {
    return Url(
      type: json['type'],
      url: json['url'],
    );
  }
}
