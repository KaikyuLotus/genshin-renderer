import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genshin_renderer/entities/widgetables/genshin_characters.dart';
import 'package:web_renderer/web_renderer.dart';

import 'entities/widgetables/genshin_character.dart';

void main() {
  runApp(
    RenderCanvas(
      webserver: Webserver(
        config: WebserverConfig(
          requestMapping: {
            'genshin_characters': GenshinCharacters.fromJson,
            'genshin_character': GenshinCharacter.fromJson,
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
        fontFamily: 'RobotoMono',
        textTheme: const TextTheme(
          bodyText2: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
    ),
  );
}
