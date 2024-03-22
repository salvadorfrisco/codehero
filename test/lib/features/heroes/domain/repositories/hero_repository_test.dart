import 'package:flutter_test/flutter_test.dart';
import 'package:hero/features/heroes/domain/models/hero_response_model.dart';
import 'package:hero/features/heroes/domain/repositories/hero_repository.dart';

void main() {
  group('HeroRepository', () {
    late HeroRepository heroRepository;

    setUp(() {
      heroRepository = MockHeroRepository();
    });

    test('getHeroes should return a HeroResponse', () async {
      final response = await heroRepository.getHeroes(offset: 0, name: null);

      expect(response, isA<HeroResponse>());
    });
  });
}

class MockHeroRepository implements HeroRepository {
  @override
  Future<HeroResponse> getHeroes({required int offset, String? name}) async {
    await Future.delayed(const Duration(seconds: 1));
    return HeroResponse(heroes: [], offset: 0, limit: 4, count: 0, total: 0);
  }
}
