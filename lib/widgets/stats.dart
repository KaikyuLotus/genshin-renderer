import 'package:flutter/material.dart';
import 'package:genshin_renderer/entities/genshin.dart';
import 'package:genshin_renderer/entities/constants.dart' as constants;

class StatCount extends StatelessWidget {
  final String title;
  final int count;

  const StatCount({
    Key? key,
    required this.title,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context)
        .textTheme
        .bodyText1
        ?.copyWith(fontSize: 12, color: constants.subtitleColor);
    final countStyle =
        Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 23);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$count', style: countStyle, textAlign: TextAlign.center),
          Text(
            title.replaceAll(' ', '\n'),
            style: titleStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  static StatCount fromKeyValue(MapEntry<String, int> entry) {
    return StatCount(title: entry.key, count: entry.value);
  }
}

class StatsWidget extends StatelessWidget {
  final UserInfo userInfo;

  const StatsWidget({Key? key, required this.userInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titles = userInfo.stats.titleValueMap.entries
        .map(StatCount.fromKeyValue)
        .toList();
    return Container(
      color: constants.bgColor,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: Card(
                color: constants.cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.4,
                  ),
                  itemCount: titles.length,
                  itemBuilder: (context, index) => titles[index],
                ),
              ),
            ),
          ),
          Expanded(flex: 4, child: Container()),
        ],
      ),
    );
  }
}
