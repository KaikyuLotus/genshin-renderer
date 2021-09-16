import 'package:flutter/material.dart';
import 'package:genshin_renderer/widgets/character_widget.dart';
import 'package:web_renderer/web_renderer.dart';

import '../genshin.dart';

class GenshinCharacter implements Widgetable {
  final double? _pixelRatio;
  final DetailedAvatar avatar;

  GenshinCharacter({
    required this.avatar,
    double? pixelRatio,
  }) : _pixelRatio = pixelRatio;

  @override
  double get pixelRatio => _pixelRatio ?? 1.0;

  @override
  Size get size => const Size(9, 12) * 50;

  @override
  Widget asWidget() => CharacterWidget(avatar: avatar);

  static GenshinCharacter fromJson(Map<String, dynamic> json) {
    return GenshinCharacter(
      avatar: DetailedAvatar.fromJson(json['avatar']),
      pixelRatio: json['pixel_ratio']?.toDouble(),
    );
  }
}
