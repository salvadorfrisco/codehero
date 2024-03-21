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
        padding: const EdgeInsets.all(16.0),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return LayoutBuilder(
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
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSection(
          context,
          title: 'Descrição',
          items: [hero.description],
        ),
        _buildSection(
          context,
          title: 'Séries',
          items: hero.series.items.map((series) => series.name).toList(),
        ),
        _buildSection(
          context,
          title: 'Eventos',
          items: hero.events.items
              .map<String>((event) => event['name'] as String)
              .toList(),
        ),
      ],
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required List<String> items}) {
    return Visibility(
      visible: items.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items.map((item) {
              return Text(
                item,
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
