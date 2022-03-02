import 'package:flutter/material.dart';
import 'package:genshin_renderer/widgets/stats.dart';
import 'package:web_renderer/web_renderer.dart';

import '../genshin.dart';

class Stats implements Widgetable {
  final UserInfo userInfo;
  final double? _pixelRatio;
  final double? _windowMultiplier;

  Stats({
    required this.userInfo,
    final double? pixelRatio,
    final double? windowMultiplier,
  })  : _pixelRatio = pixelRatio,
        _windowMultiplier = windowMultiplier;

  @override
  double get pixelRatio => _pixelRatio ?? 1.0;

  @override
  Size get size => const Size(550, 800) * (_windowMultiplier ?? 1.0);

  @override
  Widget asWidget() => StatsWidget(userInfo: userInfo);

  static Stats fromJson(Map<String, dynamic> json) {
    return Stats(
      userInfo: UserInfo.fromJson(json['user_info']),
      pixelRatio: json['pixel_ratio']?.toDouble(),
      windowMultiplier: json['window_multiplier']?.toDouble(),
    );
  }
}
