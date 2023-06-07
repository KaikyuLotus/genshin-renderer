import 'dart:io';

import 'package:flutter/material.dart';
import 'package:web_renderer/web_renderer.dart';

import 'entities/widgetables/genshin/genshin_characters.dart';
import 'entities/widgetables/genshin/genshin_character.dart';
import 'entities/widgetables/health.dart';
import 'entities/widgetables/hsr/hsr_characters.dart';
import 'entities/widgetables/hsr/hsr_character.dart';

void main() {
  runApp(
    RenderCanvas(
      webserver: Webserver(
        config: WebserverConfig(
          requestMapping: {
            'genshin_characters': GenshinCharacters.fromJson,
            'genshin_character': GenshinCharacter.fromJson,
            'hsr_characters': HSRCharacters.fromJson,
            'hsr_character': HSRCharacter.fromJson,
            'health': Health.fromJson,
          },
          address: InternetAddress.anyIPv4,
          port: 8080,
          renderTimeout: const Duration(seconds: 30),
          logRequests: true,
        ),
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        cardColor: Colors.white,
        fontFamily: 'GenshinImpact',
      ),
    ),
  );
}
