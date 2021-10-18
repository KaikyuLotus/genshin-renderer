import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:genshin_renderer/entities/constants.dart';
import 'package:genshin_renderer/entities/genshin.dart';

class ConstellationCard extends StatelessWidget {
  final Constellation constellation;
  final String element;

  const ConstellationCard({
    required this.element,
    required this.constellation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var elemColor = elementColors[element] ?? Colors.grey;
    var color = constellation.isActived ? elemColor : Colors.grey.shade400;
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        ),
        color: Colors.black.withOpacity(0.2),
        border: Border.all(
          color: color,
        ),
      ),
      child: Image(
        image: CachedNetworkImageProvider(
          constellation.icon,
        ),
        color: color,
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final String image;
  final int rarity;
  final String name;
  final String line1;
  final String? line2;

  const ItemCard({
    required this.image,
    required this.rarity,
    required this.name,
    required this.line1,
    this.line2,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final cardHeight = MediaQuery.of(context).size.height / 10;

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10),
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      shadowColor: const Color.fromARGB(12, 19, 19, 19),
      color: const Color.fromARGB(80, 19, 19, 19),
      child: SizedBox(
        height: cardHeight,
        // fit: BoxFit.fill,
        child: Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: colorMap[rarity] ?? Colors.grey,
                    ),
                  ),
                ),
                child: Image(
                  image: CachedNetworkImageProvider(
                    image,
                  ),
                  alignment: Alignment.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name),
                    Container(height: 5),
                    Text(
                      line1,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    if (line2 != null) ...[
                      Container(height: 5),
                      Text(
                        line2!,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CharacterWidget extends StatelessWidget {
  final DetailedAvatar avatar;

  const CharacterWidget({required this.avatar, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 39, 39, 39),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: CachedNetworkImageProvider(
              avatar.image,
            ),
            alignment: Alignment.centerRight,
            fit: BoxFit.fitHeight,
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 5,
            child: Container(
              color: elementColors[avatar.element] ?? Colors.grey,
            ),
          ),
          Positioned(
            left: 20,
            top: 10,
            // width: MediaQuery.of(context).size.width / 2,
            child: IntrinsicWidth(
              child: Column(
                // alignment: WrapAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ItemCard(
                    name: avatar.weapon.name,
                    rarity: avatar.weapon.rarity,
                    image: avatar.weapon.icon,
                    line1: avatar.weapon.line1,
                    line2: avatar.weapon.line2,
                  ),
                  ...avatar.artifacts.map(
                    (a) => ItemCard(
                      image: a.icon,
                      rarity: a.rarity,
                      name: a.name,
                      line1: a.description,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 30,
            bottom: 40,
            width: MediaQuery.of(context).size.width / 2,
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return ConstellationCard(
                  constellation: avatar.constellations[index],
                  element: avatar.element,
                );
              },
            ),
          ),
          const Positioned(
            bottom: 5,
            right: 5,
            child: Text('patreon.com/KaikyuLotus'),
          ),
        ],
      ),
    );
  }
}
