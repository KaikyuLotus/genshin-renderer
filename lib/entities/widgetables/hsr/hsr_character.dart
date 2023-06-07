import 'package:flutter/material.dart';
import 'package:genshin_renderer/widgets/hsr/hsr_character_widget.dart';
import 'package:web_renderer/web_renderer.dart';

import '../../hsr.dart';

class HSRCharacter implements Widgetable {
  static const defaultWindowMultiplier = 50.0;

  final Avatar avatar;
  final double? _pixelRatio;
  final double? _windowMultiplier;

  HSRCharacter({
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
  Widget asWidget() => HSRCharacterWidget(avatar: avatar);

  static HSRCharacter fromJson(Map<String, dynamic> json) {
    return HSRCharacter(
      avatar: Avatar.fromJson(json['avatar']),
      pixelRatio: json['pixel_ratio']?.toDouble(),
      windowMultiplier: json['window_multiplier']?.toDouble(),
    );
  }
}
