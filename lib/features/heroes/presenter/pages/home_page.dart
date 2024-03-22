import 'package:flutter/material.dart';
import 'package:hero/features/heroes/presenter/providers/heroes_provider.dart';
import 'package:hero/features/heroes/presenter/widgets/hero_list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final provider = HeroesProvider();
        provider.loadHeroes();
        return provider;
      },
      child: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HeroesProvider>(context);

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
                      padding: const EdgeInsets.all(8.0),
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
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8.0),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              onChanged: (value) {
                                provider.setFilterName(value);
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                  body: constraints.maxWidth > 600
                      ? _buildWebLayout(context, provider)
                      : _buildMobileLayout(context, provider));
            },
          ),
        ));
  }

  Widget _buildWebLayout(BuildContext context, HeroesProvider provider) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          height: 40,
          alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Personagem',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: Container(
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Séries',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: Container(
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          child: provider.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ))
              : provider.heroesList.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: HeroList(
                        heroesList: provider.heroesList,
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
                onPressed: provider.previousPage,
                icon: const Icon(Icons.arrow_left),
                iconSize: 48,
                color: provider.currentPage > 0
                    ? Theme.of(context).primaryColor
                    : Colors.black26,
              ),
              const SizedBox(width: 16),
              ..._buildPageButtons(context, provider),
              const SizedBox(width: 16),
              IconButton(
                onPressed: provider.nextPage,
                icon: const Icon(Icons.arrow_right),
                iconSize: 48,
                color:
                    provider.currentPage + 1 < (provider.totalHeroes / 4).ceil()
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
    );
  }

  Widget _buildMobileLayout(BuildContext context, HeroesProvider provider) {
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
          child: provider.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ))
              : provider.heroesList.isNotEmpty
                  ? HeroList(
                      heroesList: provider.heroesList,
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
                onPressed: provider.previousPage,
                icon: const Icon(Icons.arrow_left),
                iconSize: 48,
                color: provider.currentPage > 0
                    ? Theme.of(context).primaryColor
                    : Colors.black26,
              ),
              const SizedBox(width: 16),
              ..._buildPageButtons(context, provider),
              const SizedBox(width: 16),
              IconButton(
                onPressed: provider.nextPage,
                icon: const Icon(Icons.arrow_right),
                iconSize: 48,
                color:
                    provider.currentPage + 1 < (provider.totalHeroes / 4).ceil()
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
    );
  }

  List<Widget> _buildPageButtons(
      BuildContext context, HeroesProvider provider) {
    final List<Widget> buttons = [];
    final int totalPages = (provider.totalHeroes / 4).ceil();
    final int startPage = provider.currentPage > 0
        ? provider.currentPage - 1
        : provider.currentPage;
    final int endPage =
        startPage + 2 < totalPages ? startPage + 2 : totalPages - 1;

    for (int i = startPage; i <= endPage; i++) {
      buttons.add(_buildPageButton(context, provider, i + 1));
      if (i < endPage) {
        buttons.add(const SizedBox(width: 16));
      }
    }

    return buttons;
  }

  Widget _buildPageButton(
      BuildContext context, HeroesProvider provider, int page) {
    final isActive = page == provider.currentPage + 1;
    return GestureDetector(
      onTap: () => provider.goToPage(page),
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
