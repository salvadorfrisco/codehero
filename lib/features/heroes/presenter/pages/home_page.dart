import 'package:flutter/material.dart';
import 'package:hero/features/heroes/domain/models/hero_model.dart';

import 'package:hero/features/heroes/domain/repositories/hero_repository.dart';
import 'package:hero/features/heroes/presenter/widgets/hero_list.dart';
import 'package:hero/features/heroes/repositories/hero_repository_impl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HeroRepository heroRepository = HeroRepositoryImpl();
  bool _isLoading = true;

  List<HeroModel> heroesList = [];
  int currentPage = 0;
  String? filterName;
  int totalHeroes = 0;

  @override
  void initState() {
    super.initState();
    _loadHeroes();
  }

  void _loadHeroes() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await heroRepository.getHeroes(
        offset: currentPage * 4,
        name: filterName,
      );

      setState(() {
        heroesList = response.heroes;
        totalHeroes = response.total;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
      _loadHeroes();
    }
  }

  void _nextPage() {
    if ((currentPage + 1) * 4 < totalHeroes) {
      setState(() {
        currentPage++;
      });
      _loadHeroes();
    }
  }

  void _goToPage(int page) {
    setState(() {
      currentPage = page - 1;
    });
    _loadHeroes();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 136,
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'BUSCA MARVEL',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          TextSpan(
                            text: 'TESTE FRONTEND',
                            style: Theme.of(context).textTheme.titleSmall,
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 54,
                      height: 4,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 12),
                    Text('Nome do Personagem',
                        style: Theme.of(context).textTheme.titleSmall),
                    SizedBox(
                      height: 40,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        onChanged: (value) {
                          setState(() {
                            filterName = value.isEmpty ? null : value;
                          });
                          _loadHeroes();
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            body: Column(
              children: <Widget>[
                Container(
                    color: Theme.of(context).primaryColor,
                    height: 40,
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 96,
                        ),
                        Text(
                          'Nome',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    )),
                Expanded(
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        )) // Show progress indicator while loading
                      : heroesList.isNotEmpty
                          ? HeroList(
                              heroesList: heroesList,
                            )
                          : Center(
                              child: Text(
                              'Ops! não há personagens...',
                              style: Theme.of(context).textTheme.bodyLarge,
                            )),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.only(top: 18, bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: _previousPage,
                        icon: const Icon(Icons.arrow_left),
                        iconSize: 48,
                        color: currentPage > 0
                            ? Theme.of(context).primaryColor
                            : Colors.black26,
                      ),
                      const SizedBox(width: 16),
                      ..._buildPageButtons(),
                      const SizedBox(width: 16),
                      IconButton(
                        onPressed: _nextPage,
                        icon: const Icon(Icons.arrow_right),
                        iconSize: 48,
                        color: currentPage + 1 < (totalHeroes / 4).ceil()
                            ? Theme.of(context).primaryColor
                            : Colors.black26,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  height: 16,
                ),
              ],
            ),
          ),
        ));
  }

  List<Widget> _buildPageButtons() {
    final List<Widget> buttons = [];
    final int totalPages = (totalHeroes / 4).ceil();
    final int startPage = currentPage > 0 ? currentPage - 1 : currentPage;
    final int endPage =
        startPage + 2 < totalPages ? startPage + 2 : totalPages - 1;

    for (int i = startPage; i <= endPage; i++) {
      buttons.add(_buildPageButton(i + 1));
      if (i < endPage) {
        buttons.add(const SizedBox(width: 16));
      }
    }

    return buttons;
  }

  Widget _buildPageButton(int page) {
    final isActive = page == currentPage + 1;
    return GestureDetector(
      onTap: () => _goToPage(page),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Theme.of(context).primaryColor, width: 1.5),
          color: isActive ? Theme.of(context).primaryColor : null,
        ),
        child: Text(
          '$page',
          style: TextStyle(
            color: isActive ? Colors.white : Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
