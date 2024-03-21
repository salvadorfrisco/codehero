import 'package:flutter/material.dart';
import 'package:hero/features/heroes/domain/models/hero_model.dart';
import 'package:hero/features/heroes/presenter/pages/hero_details_page.dart';

class HeroList extends StatelessWidget {
  final List<HeroModel> heroesList;
  const HeroList({
    super.key,
    required this.heroesList,
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: ListTile(
                    title: Text(
                      hero.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    leading: CircleAvatar(
                      radius: 32.0,
                      backgroundImage: NetworkImage(
                          '${hero.thumbnail.path}.${hero.thumbnail.extension}'),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HeroDetailsPage(hero: hero),
                    ),
                  );
                }),
            Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1,
                  thickness: 1.6,
                ))
          ],
        );
      },
    );
  }
}
