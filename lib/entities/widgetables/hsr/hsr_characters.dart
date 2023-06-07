import 'package:flutter/material.dart';
import 'package:web_renderer/web_renderer.dart';

import '../../../widgets/hsr/hsr_characters_grid_widget.dart';
import '../../hsr.dart';

class HSRCharacters implements Widgetable {
  static const padding = 5.0;
  static const defaultPixelRatio = 1.0;
  static const defaultWindowMultiplier = 130.0;
  int get maxCols => avatarList.length <= 8 ? 3 : 4;
  int get maxRows => (avatarList.length / maxCols).ceil();
  static const bottomMargin = 0.2;
  static const topMargin = 0.2;

  final UserStats userStats;
  final List<Avatar> avatarList;
  final double? _pixelRatio;
  final double? _windowMultiplier;

  const HSRCharacters({
    required this.userStats,
    required this.avatarList,
    double? pixelRatio,
    double? windowMultiplier,
  })  : _pixelRatio = pixelRatio,
        _windowMultiplier = windowMultiplier;

  @override
  double get pixelRatio => _pixelRatio ?? 1.0;

  @override
  Size get size =>
      Size(maxCols.toDouble() + 1.7,
          maxRows.toDouble() + 2.7 + bottomMargin + topMargin) *
      (_windowMultiplier ?? defaultWindowMultiplier);

  @override
  Widget asWidget() {
    return HSRCharactersGridWidget(
      userStats: userStats,
      avatarList: avatarList,
      maxCols: maxCols.toInt(),
    );
  }

  static HSRCharacters fromJson(Map<String, dynamic> json) {
    return HSRCharacters(
      userStats: UserStats.fromJson(json['data']['user_stats']),
      avatarList: List<Avatar>.from(
        json['data']['avatar_list'].map((e) => Avatar.fromJson(e)),
      ),
      pixelRatio: json['pixel_ratio']?.toDouble(),
      windowMultiplier: json['window_multiplier']?.toDouble(),
    );
  }
}
