import 'package:flutter/material.dart';
import 'package:hero/features/heroes/domain/models/hero_model.dart';

class HeroDetailsPage extends StatelessWidget {
  final HeroModel hero;

  const HeroDetailsPage({super.key, required this.hero});

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(hero.thumbnail.toString()),
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
                          color: Theme.of(context).secondaryHeaderColor,
                        )),
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
                                color: Theme.of(context).secondaryHeaderColor,
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
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      );
                    }),
                  ],
                ),
              ),

              /* ListView.builder(
                itemCount: hero.events.items.length,
                itemBuilder: (context, index) {
                  final item = hero.events.items[index];
                  return Text(
                    item['name'],
                    style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  );
                },
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
