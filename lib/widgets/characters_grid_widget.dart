import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshin_renderer/entities/genshin.dart';
import 'package:genshin_renderer/entities/widgetables/genshin_characters.dart';

class ConstellationCircle extends StatelessWidget {
  final double width;
  final double height;
  final bool isActive;

  const ConstellationCircle({
    required this.isActive,
    required this.width,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.white : const Color.fromARGB(100, 0, 0, 0),
      ),
    );
  }
}

class CharacterCard extends StatelessWidget {
  final Avatar avatar;

  const CharacterCard({
    required this.avatar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final wd20 = (width / 100).toDouble();
    return Stack(
      fit: StackFit.expand,
      children: [
        avatar.background,
        Image(
          image: CachedNetworkImageProvider(avatar.image),
          filterQuality: FilterQuality.high,
          isAntiAlias: true,
          fit: BoxFit.cover,
        ),
        Positioned(
          right: 0,
          top: 0,
          width: width / 25,
          height: width / 25,
          child: Image(
            image: CachedNetworkImageProvider(avatar.elementUrl),
          ),
        ),
        Positioned(
          left: 5,
          top: 5,
          child: Wrap(
            direction: Axis.vertical,
            spacing: 2,
            children: [
              ...List.generate(
                avatar.activedConstellationNum,
                (index) => ConstellationCircle(
                  isActive: true,
                  width: wd20,
                  height: wd20,
                ),
              ),
              ...List.generate(
                6 - avatar.activedConstellationNum,
                (index) => ConstellationCircle(
                  isActive: false,
                  width: wd20,
                  height: wd20,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: 0,
          height: width / 20,
          child: Container(
            color: Colors.black.withOpacity(0.7),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3.0, right: 3),
                    child: Row(
                      children: [
                        Image.asset(
                          'resources/images/genshin/Item_Character_EXP.png',
                        ),
                        Expanded(
                          flex: 1,
                          child: FittedBox(
                            child: Text('${avatar.level}'),
                          ),
                        ),
                        const Spacer(flex: 4),
                        Image.asset(
                          'resources/images/genshin/Item_Companionship_EXP.png',
                        ),
                        Expanded(
                          flex: 1,
                          child: FittedBox(
                            child: Text('${avatar.fetter}'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      avatar.name,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CharactersGridWidget extends StatelessWidget {
  static const paddingH = 6.0;
  static const paddingW = 6.0;

  final UserInfo userInfo;
  final int maxCols;

  const CharactersGridWidget({
    required this.userInfo,
    required this.maxCols,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 39, 39, 39),
      child: Stack(
        children: [
          GridView.builder(
            padding: const EdgeInsets.all(GenshinCharacters.padding),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: maxCols,
              childAspectRatio: 1.0,
              crossAxisSpacing: paddingW,
              mainAxisSpacing: paddingH,
            ),
            itemCount: userInfo.avatars.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: CharacterCard(
                  avatar: userInfo.avatars[index],
                ),
              );
            },
          ),
          const Positioned(
            right: 5,
            bottom: 5,
            child: Text('patreon.com/KaikyuLotus'),
          )
        ],
      ),
    );
  }
}
