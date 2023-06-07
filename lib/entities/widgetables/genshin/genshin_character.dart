import 'package:flutter/material.dart';
import 'package:genshin_renderer/widgets/genshin/genshin_character_widget.dart';
import 'package:web_renderer/web_renderer.dart';

import '../../genshin.dart';

class GenshinCharacter implements Widgetable {
  static const defaultWindowMultiplier = 50.0;

  final DetailedAvatar avatar;
  final double? _pixelRatio;
  final double? _windowMultiplier;

  GenshinCharacter({
    required this.avatar,
    double? pixelRatio,
    double? windowMultiplier,
  })  : _pixelRatio = pixelRatio,
        _windowMultiplier = windowMultiplier;

  @override
  double get pixelRatio => _pixelRatio ?? 1.0;

  @override
  Size get size =>
      const Size(9, 12) * (_windowMultiplier ?? defaultWindowMultiplier);

  @override
  Widget asWidget() => CharacterWidget(avatar: avatar);

  static GenshinCharacter fromJson(Map<String, dynamic> json) {
    return GenshinCharacter(
      avatar: DetailedAvatar.fromJson(json['avatar']),
      pixelRatio: json['pixel_ratio']?.toDouble(),
      windowMultiplier: json['window_multiplier']?.toDouble(),
    );
  }
}
