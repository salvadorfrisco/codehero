import 'package:flutter/material.dart';
import 'package:hero/features/heroes/domain/models/hero_model.dart';

class HeroDetailsPage extends StatelessWidget {
  final HeroModel hero;
  final bool web;

  const HeroDetailsPage({
    super.key,
    required this.hero,
    required this.web,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          hero.name,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (web) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Image.network(hero.thumbnail.toString()),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 3,
                      child: _buildDetails(context),
                    ),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxWidth,
                      child: Image.network(hero.thumbnail.toString()),
                    ),
                    const SizedBox(height: 16),
                    _buildDetails(context),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: hero.description.isNotEmpty,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Descrição',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(hero.description,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                  )),
            ],
          ),
        ),
        Visibility(
          visible: hero.series.items.isNotEmpty,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Séries',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: hero.series.items
                    .map(
                      (series) => Text(
                        series.name,
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
        Visibility(
          visible: hero.events.items.isNotEmpty,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Eventos',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ...hero.events.items.map((event) {
                return Text(
                  event['name'],
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
