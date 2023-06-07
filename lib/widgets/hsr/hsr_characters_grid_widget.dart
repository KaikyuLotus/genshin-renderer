import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshin_renderer/entities/constants.dart' as constants;
import 'package:genshin_renderer/entities/hsr.dart';

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
  static const bgMap = {
    5: "https://act.hoyolab.com/app/community-game-records-sea/images/character_r_5.99d42eb7.png",
    4: "https://act.hoyolab.com/app/community-game-records-sea/images/character_r_4.24f329b7.png",
  };
  static const elemMap = {
    'quantum':
        "https://honkailab.com/wp-content/uploads/2023/02/Star_Rail_Element_Quantum.webp",
    'wind': "https://honkailab.com/wp-content/uploads/2023/02/Element_Wind.png",
    'physical':
        "https://honkailab.com/wp-content/uploads/2023/02/Star_Rail_Element_Physical.webp",
    'ice': "https://honkailab.com/wp-content/uploads/2023/02/Element_Ice.png",
    'fire': "https://honkailab.com/wp-content/uploads/2023/02/Element_Fire.png",
    'imaginary':
        "https://honkailab.com/wp-content/uploads/2023/02/Star_Rail_Element_Imaginary.webp",
    'lightning':
        "https://honkailab.com/wp-content/uploads/2023/02/Star_Rail_Element_Lightning.webp",
  };
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
        Image(
          image: CachedNetworkImageProvider(
            bgMap[avatar.rarity]!,
          ),
          filterQuality: FilterQuality.high,
          isAntiAlias: true,
          fit: BoxFit.cover,
        ),
        Image(
          image: CachedNetworkImageProvider(avatar.icon),
          filterQuality: FilterQuality.high,
          isAntiAlias: true,
          fit: BoxFit.cover,
        ),
        Positioned(
          left: 5,
          top: 5,
          child: Wrap(
            direction: Axis.vertical,
            spacing: 2,
            children: [
              ...List.generate(
                avatar.rank,
                (index) => ConstellationCircle(
                  isActive: true,
                  width: wd20,
                  height: wd20,
                ),
              ),
              ...List.generate(
                6 - avatar.rank,
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
                  child: Row(
                    children: [
                      FittedBox(
                        child: Text(
                          avatar.name,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Spacer(),
                      FittedBox(
                        child: Text('${avatar.level}'),
                      ),
                      const SizedBox(width: 3),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 5,
          top: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: Colors.black.withOpacity(0.2),
              height: width / 21,
              child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Center(
                    child: Image(
                      image: CachedNetworkImageProvider(
                        elemMap[avatar.element]!,
                      ), // avatar.element no url for this yet
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}

class PlayerInfo extends StatelessWidget {
  final UserStats userStats;

  const PlayerInfo({required this.userStats, super.key});

  @override
  Widget build(BuildContext context) {
    final tsf = MediaQuery.of(context).textScaleFactor * 1.5;
    return Card(
      color: const Color.fromARGB(255, 60, 60, 60),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FittedBox(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Days Active\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'DIN',
                          ),
                        ),
                        TextSpan(
                          text: '${userStats.activeDays}',
                          style: const TextStyle(fontFamily: 'DIN'),
                        ),
                      ],
                    ),
                    textScaleFactor: tsf,
                    textAlign: TextAlign.center,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Characters\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'DIN',
                        ),
                      ),
                      TextSpan(
                        text: '${userStats.avatarNum}',
                        style: const TextStyle(fontFamily: 'DIN'),
                      ),
                    ],
                  ),
                  textScaleFactor: tsf,
                  textAlign: TextAlign.center,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Achievements\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'DIN',
                        ),
                      ),
                      TextSpan(
                        text: '${userStats.achievementNum}',
                        style: const TextStyle(fontFamily: 'DIN'),
                      ),
                    ],
                  ),
                  textScaleFactor: tsf,
                  textAlign: TextAlign.center,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Chests\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'DIN',
                        ),
                      ),
                      TextSpan(
                        text: '${userStats.chestNum}',
                        style: const TextStyle(fontFamily: 'DIN'),
                      ),
                    ],
                  ),
                  textScaleFactor: tsf,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                userStats.abyssProcess
                    .replaceAll('<unbreak>', '')
                    .replaceAll('</unbreak>', ''),
                style: const TextStyle(fontFamily: 'DIN', fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HSRCharactersGridWidget extends StatelessWidget {
  static const paddingH = 12.0;
  static const paddingW = 12.0;

  final UserStats userStats;
  final List<Avatar> avatarList;
  final int maxCols;

  const HSRCharactersGridWidget({
    required this.userStats,
    required this.avatarList,
    required this.maxCols,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(fontFamily: 'DIN', fontSize: 20),
      child: Container(
        color: constants.bgColor,
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 40,
                  right: 40,
                ),
                child: PlayerInfo(userStats: userStats),
              ),
            ),
            if (avatarList.length == 8)
              const Expanded(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 10),
                      child: Text(
                        'Showing only top 8 due to Hoyoverse limitations.',
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              flex: 50,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: GridView.builder(
                  // padding: const EdgeInsets.all(0),
                  // shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: maxCols,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: paddingW,
                    mainAxisSpacing: paddingH,
                  ),
                  itemCount: avatarList.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: CharacterCard(
                        avatar: avatarList[index],
                      ),
                    );
                  },
                ),
              ),
            ),
            const Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10, bottom: 10),
                    child: Text(
                      'ko-fi.com/KaikyuLotus',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
