import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:hero/core/constants/constants.dart';
import 'package:hero/features/heroes/domain/models/hero_response_model.dart';
import 'package:hero/features/heroes/domain/repositories/hero_repository.dart';
import 'package:hero/secrets.dart';

class HeroRepositoryImpl implements HeroRepository {
  final dio = Dio();
  final publicKey = Secrets.publicKey;
  final privateKey = Secrets.privateKey;

  @override
  Future<HeroResponse> getHeroes({required int offset, String? name}) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final hash =
        md5.convert(utf8.encode('$timestamp$privateKey$publicKey')).toString();

    try {
      final Map<String, dynamic> queryParameters = {
        'ts': timestamp,
        'apikey': publicKey,
        'hash': hash,
        'limit': 4,
        'offset': offset,
      };

      if (name != null) {
        queryParameters['nameStartsWith'] = name;
      }

      final response = await dio.get(
        '$baseUrl/v1/public/characters',
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        return HeroResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load heroes');
      }
    } catch (e) {
      throw Exception('Failed to load heroes: $e');
    }
  }
}
