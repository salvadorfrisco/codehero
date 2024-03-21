import 'package:flutter/material.dart';
import 'package:hero/features/heroes/domain/models/hero_model.dart';
import 'package:hero/features/heroes/presenter/pages/hero_details_page.dart';

class HeroList extends StatelessWidget {
  final List<HeroModel> heroesList;
  final bool web;

  const HeroList({
    super.key,
    required this.heroesList,
    required this.web,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: heroesList.length,
      itemBuilder: (context, index) {
        final hero = heroesList[index];
        return Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HeroDetailsPage(
                      hero: hero,
                      web: web,
                    ),
                  ),
                ).then((_) {
                  // This is executed when the HeroDetailsPage is popped
                  FocusManager.instance.primaryFocus?.unfocus();
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ListTile(
                        title: Text(
                          hero.name,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        leading: CircleAvatar(
                          radius: 32.0,
                          backgroundImage: NetworkImage(
                            '${hero.thumbnail.path}.${hero.thumbnail.extension}',
                          ),
                        ),
                      ),
                    ),
                    if (web)
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
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
                        ),
                      ),
                    if (web)
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
                thickness: 1.6,
              ),
            )
          ],
        );
      },
    );
  }
}
