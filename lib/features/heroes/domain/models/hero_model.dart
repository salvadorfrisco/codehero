import 'package:hero/features/heroes/domain/models/events_model.dart';
import 'package:hero/features/heroes/domain/models/series_model.dart';
import 'package:hero/features/heroes/domain/models/thumbnail_model.dart';

class HeroModel {
  final int id;
  final String name;
  final String description;
  final ThumbnailModel thumbnail;
  final SeriesModel series;
  final EventsModel events;

  HeroModel({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.series,
    required this.events,
  });

  factory HeroModel.fromJson(Map<String, dynamic> json) {
    return HeroModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      thumbnail: ThumbnailModel.fromJson(json['thumbnail']),
      series: SeriesModel.fromJson(json['series']),
      events: EventsModel.fromJson(json['events']),
    );
  }
}
