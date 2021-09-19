import 'package:flutter/material.dart';
import 'package:web_renderer/web_renderer.dart';

class Health implements Widgetable {
  Health();

  @override
  double get pixelRatio => 1.0;

  @override
  Size get size => const Size(200, 200);

  @override
  Widget asWidget() => const Center(child: Text('Hello!'));

  static Health fromJson(Map<String, dynamic> json) => Health();
}
