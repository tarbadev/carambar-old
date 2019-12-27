import 'dart:convert';
import 'dart:io';

import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/repository/entity/initiate_event_entity.dart';
import 'package:carambar/home/domain/entity/age_event.dart';
import 'package:carambar/home/repository/entity/age_event_entity.dart';
import 'package:carambar/character/domain/entity/character.dart';
import 'package:carambar/character/repository/entity/character_entity.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Storage {
  final String fileName;

  Storage(this.fileName);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  Future<String> read() async {
    try {
      final file = await _localFile;

      return await file.readAsString();
    } catch (e) {
      return null;
    }
  }

  Future<File> write(dynamic entity) async {
    final file = await _localFile;
    return file.writeAsString(jsonEncode(entity));
  }

  Future<void> delete() async {
    final file = await _localFile;
    if (await file.exists()) await file.delete();
  }

  static Future<void> setupStorage() async {
    final directory = await Directory.systemTemp.createTemp();

    const MethodChannel('plugins.flutter.io/path_provider')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        return directory.path;
      }
      return null;
    });
  }
}

class CharacterStorage extends Storage {
  CharacterStorage() : super('testingCharacter.json');

  Future<File> store(Character character) async {
    return write(CharacterEntity.fromCharacter(character));
  }
}

class AgeEventStorage extends Storage {
  AgeEventStorage() : super('testingAgeEvents.json');

  Future<File> store(List<AgeEvent> ageEvents) async {
    return write(ageEvents
        .map((ageEvent) => AgeEventEntity.fromAgeEvent(ageEvent))
        .toList());
  }
}

class GameStorage extends Storage {
  GameStorage() : super('testingGames.json');

  Future<File> store(List<InitiateEvent> events) async {
    return write(events
        .map((event) => InitiateEventEntity.fromInitiateEvent(event))
        .toList());
  }
}
