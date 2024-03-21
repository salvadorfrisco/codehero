import 'package:hero/features/heroes/domain/models/hero_model.dart';

class HeroResponse {
  final int offset;
  final int limit;
  final int total;
  final int count;
  final List<HeroModel> heroes;

  HeroResponse({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.heroes,
  });

  factory HeroResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> results = json['data']['results'];
    final heroes =
        results.map((heroJson) => HeroModel.fromJson(heroJson)).toList();
    return HeroResponse(
      offset: json['data']['offset'],
      limit: json['data']['limit'],
      total: json['data']['total'],
      count: json['data']['count'],
      heroes: heroes,
    );
  }
}
