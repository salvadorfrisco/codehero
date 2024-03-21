import 'package:hero/features/heroes/domain/models/hero_response_model.dart';

abstract interface class HeroRepository {
  //Future<List<HeroModel>> getHeroes();
  Future<HeroResponse> getHeroes({required int offset, String? name});
}
