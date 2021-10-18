import 'package:flutter/material.dart';
import 'package:genshin_renderer/widgets/characters_grid_widget.dart';
import 'package:web_renderer/web_renderer.dart';

import '../genshin.dart';

class GenshinCharacters implements Widgetable {
  static const padding = 5.0;
  static const defaultPixelRatio = 1.0;
  static const defaultWindowMultiplier = 130.0;
  final maxCols = 5;
  int get maxRows => (userInfo.avatars.length / maxCols).ceil();
  static const bottomMargin = 0.2;

  final UserInfo userInfo;
  final double? _pixelRatio;
  final double? _windowMultiplier;

  const GenshinCharacters({
    required this.userInfo,
    double? pixelRatio,
    double? windowMultiplier,
  })  : _pixelRatio = pixelRatio,
        _windowMultiplier = windowMultiplier;

  @override
  double get pixelRatio => _pixelRatio ?? 1.0;

  @override
  Size get size =>
      Size(maxCols.toDouble(), maxRows.toDouble() + bottomMargin) *
      (_windowMultiplier ?? defaultWindowMultiplier);

  @override
  Widget asWidget() {
    return CharactersGridWidget(userInfo: userInfo, maxCols: maxCols.toInt());
  }

  static GenshinCharacters fromJson(Map<String, dynamic> json) {
    return GenshinCharacters(
      userInfo: UserInfo.fromJson(json['user_info']),
      pixelRatio: json['pixel_ratio']?.toDouble(),
      windowMultiplier: json['window_multiplier']?.toDouble(),
    );
  }
}
