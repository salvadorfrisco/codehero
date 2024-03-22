import 'package:flutter/material.dart';
import 'package:hero/features/heroes/presenter/providers/heroes_provider.dart';
import 'package:hero/features/heroes/presenter/widgets/hero_list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HeroesProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = HeroesProvider();
    _provider.loadHeroes();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _provider,
      child: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 136,
                    title: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, right: 24, bottom: 34, left: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'BUSCA MARVEL',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    TextSpan(
                                      text: 'TESTE FRONTEND',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    )
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: constraints.maxWidth > 600,
                                child: Text('SALVADOR FRISCO',
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                              ),
                            ],
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
                            child: Consumer<HeroesProvider>(
                                builder: (context, heroes, child) {
                              return TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                textAlignVertical: TextAlignVertical.center,
                                onChanged: (value) {
                                  heroes.setFilterName(value);
                                },
                              );
                            }),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                  body: constraints.maxWidth > 600
                      ? _buildWebLayout()
                      : _buildMobileLayout());
            },
          ),
        ));
  }

  Widget _buildWebLayout() {
    return Consumer<HeroesProvider>(builder: (context, heroes, child) {
      return Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 42),
            height: 40,
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        'Personagem',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        'Séries',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        'Eventos',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: heroes.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ))
                : heroes.heroesList.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 42),
                        child: HeroList(
                          heroesList: heroes.heroesList,
                          web: true,
                        ),
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
                    onPressed: heroes.previousPage,
                    icon: const Icon(Icons.arrow_left),
                    iconSize: 48,
                    color: heroes.currentPage > 0
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor),
                const SizedBox(width: 12),
                ..._buildPageButtons(context, heroes, true),
                const SizedBox(width: 12),
                IconButton(
                    onPressed: heroes.nextPage,
                    icon: const Icon(Icons.arrow_right),
                    iconSize: 48,
                    color:
                        heroes.currentPage + 1 < (heroes.totalHeroes / 4).ceil()
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).disabledColor),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            height: 16,
          ),
        ],
      );
    });
  }

  Widget _buildMobileLayout() {
    return Consumer<HeroesProvider>(builder: (context, heroes, child) {
      return Column(
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
            child: heroes.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ))
                : heroes.heroesList.isNotEmpty
                    ? HeroList(
                        heroesList: heroes.heroesList,
                        web: false,
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
                  onPressed: heroes.previousPage,
                  icon: const Icon(Icons.arrow_left),
                  iconSize: 48,
                  color: heroes.currentPage > 0
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).disabledColor,
                ),
                const SizedBox(width: 16),
                ..._buildPageButtons(context, heroes, false),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: heroes.nextPage,
                  icon: const Icon(Icons.arrow_right),
                  iconSize: 48,
                  color:
                      heroes.currentPage + 1 < (heroes.totalHeroes / 4).ceil()
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).disabledColor,
                ),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            height: 16,
          ),
        ],
      );
    });
  }

  List<Widget> _buildPageButtons(
      BuildContext context, HeroesProvider heroes, bool web) {
    final List<Widget> buttons = [];
    final int totalPages = (heroes.totalHeroes / 4).ceil();
    final int numberButtons = web ? 4 : 2;
    final int startPage =
        heroes.currentPage > 0 ? heroes.currentPage - 1 : heroes.currentPage;
    final int endPage = startPage + numberButtons < totalPages
        ? startPage + numberButtons
        : totalPages - 1;

    for (int i = startPage; i <= endPage; i++) {
      buttons.add(_buildPageButton(context, heroes, i + 1));
      if (i < endPage) {
        buttons.add(const SizedBox(width: 16));
      }
    }

    return buttons;
  }

  Widget _buildPageButton(
      BuildContext context, HeroesProvider heroes, int page) {
    final isActive = page == heroes.currentPage + 1;
    return GestureDetector(
      onTap: () => heroes.goToPage(page),
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
            color: isActive
                ? Theme.of(context).primaryColorLight
                : Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
