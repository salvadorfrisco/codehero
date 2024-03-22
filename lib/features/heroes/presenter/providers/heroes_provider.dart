import 'package:flutter/material.dart';
import 'package:hero/features/heroes/domain/models/hero_model.dart';
import 'package:hero/features/heroes/domain/repositories/hero_repository.dart';
import 'package:hero/features/heroes/repositories/hero_repository_impl.dart';

class HeroesProvider extends ChangeNotifier {
  final HeroRepository _heroRepository = HeroRepositoryImpl();
  bool _isLoading = true;
  List<HeroModel> _heroesList = [];
  int _currentPage = 0;
  String? _filterName;
  int _totalHeroes = 0;

  bool get isLoading => _isLoading;
  List<HeroModel> get heroesList => _heroesList;
  int get currentPage => _currentPage;
  String? get filterName => _filterName;
  int get totalHeroes => _totalHeroes;

  void loadHeroes() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _heroRepository.getHeroes(
        offset: _currentPage * 4,
        name: _filterName,
      );

      _heroesList = response.heroes;
      _totalHeroes = response.total;
    } catch (e) {
      // (SF) Tratar erro aqui
    }

    _isLoading = false;
    notifyListeners();
  }

  void previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      loadHeroes();
    }
  }

  void nextPage() {
    if ((_currentPage + 1) * 4 < _totalHeroes) {
      _currentPage++;
      loadHeroes();
    }
  }

  void goToPage(int page) {
    _currentPage = page - 1;
    loadHeroes();
  }

  void setFilterName(String? name) {
    _filterName = name?.isEmpty ?? true ? null : name;
    loadHeroes();
  }
}
